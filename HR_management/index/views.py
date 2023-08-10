from django.shortcuts import render, redirect
from django.http import HttpResponse,HttpResponseRedirect
import json
import pandas as pd
from django.contrib import messages
from django.conf import settings
from django.core.files.storage import FileSystemStorage
import numpy as np
import mysql.connector
import openai
import langchain
from langchain.llms import OpenAI
import os
import random
from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.vectorstores import FAISS
from langchain.text_splitter import CharacterTextSplitter
from langchain.chains import ConversationalRetrievalChain
from langchain.chat_models import ChatOpenAI
from langchain.document_loaders import TextLoader, PDFPlumberLoader



#if this above not work 
openai.api_key = "Enter your key here "
llm = OpenAI(openai_api_key="Enter Your KKey Here")
embeddings = OpenAIEmbeddings()
llm = ChatOpenAI(temperature=0,model_name="gpt-3.5-turbo-16k-0613")

def connection():
	try:
		conn = mysql.connector.connect(host="localhost",user="root",password="",database="hr_management",port=3306)
	except Exception as e:
		print(e)
	return conn


def checkuser(username, password):
	conn = connection()
	data = pd.read_sql(f"select count(*) as userexit from users where username = '{username}' AND password='{password}';", conn)
	userdt = data.to_dict('records')
	data1 = userdt[0]['userexit']
	return data1

def login(request):
	myconn = connection()
	print(myconn)
	return render(request,'login.html')

def get_login_details(request):
	print(request)
	if request.method == "POST":
		uname = request.POST.get('username')
		passwd = request.POST.get('password')
		print(uname, passwd)
		exit_emp = checkuser(uname, passwd)
		if(exit_emp == 1):
			request.session['opoid'] = uname
			return redirect('dashboard')
		else:
			messages.success(request,"Username and pass is incorrect..")
			return redirect('/')
	else:
		return redirect('/')


def index(request):
	user = request.session.get('opoid')
	if(user == None):
		return redirect('/')
	else:		
		conn = connection()
		jobcounts = pd.read_sql(f"select count(*) as job from jobprofile", conn)
		jobcounts = jobcounts.to_dict('records')
		testcount = pd.read_sql(f"select count(*) as test from createtest", conn)
		testcount = testcount.to_dict('records')
		testassign = pd.read_sql(f"select count(*) as assign from candidate where test_status=1", conn)
		testassign = testassign.to_dict("records")
		testdone = pd.read_sql(f"select count(*) as done from candidate where test_status=2", conn)
		testdone = testdone.to_dict("records")
		ranks = pd.read_sql(f"select count(*) as rank from resumes_ranker", conn)
		ranks = ranks.to_dict("records")
		result_query = pd.read_sql(f"SELECT r.result_id, c.name, r.test_score,r.created_at FROM result_test as r JOIN candidate as c on c.cid=r.candidate_id order by r.result_id desc limit 5", conn)
		print(result_query)
		conn.close()
		result_data = result_query.to_dict('records')
		conn.close()
		context = {'jobcount':jobcounts[0]['job'],'testcount':testcount[0]['test'],'rs_data':result_data,'testassign':testassign[0]['assign'],'testdone':testdone[0]['done'],'ranks':ranks[0]['rank']}
		return render(request,'index.html', context)

def new_job_posting(request):

	return render(request,'new_job_posting.html')

def create_job_description(question):
	promptx = question
	print(promptx)
	response = openai.Completion.create(
      model="text-davinci-003",
      prompt= promptx,
      temperature=0,
      top_p=1,
      max_tokens=1000,
      frequency_penalty=0,
      presence_penalty=0)
	data =  response['choices'][0]["text"]
	print(data)
	return data


def get_job_details(request):
	if request.method == 'POST':
		jobtitle = request.POST.get('jobtitle')
		category = request.POST.get('category')
		subcategory = request.POST.get('subcategory')
		experience = request.POST.get('experience')
		skill = request.POST.get('skill')
		print(jobtitle, category, subcategory, skill, experience)
		question = f"write jd for job title {jobtitle} with category {category} with sub category {subcategory} with following skills like {skill} how having experience of {experience} year of company unicornis AI solutions in html format"
		generate_data = create_job_description(question)
		return HttpResponse(json.dumps({'done':1,'msg':'done','answer':generate_data}), content_type="application/json")
	else:
		return redirect('new_job_posting')

def generate_model(jdpath, jid):
	#pdf_loader = DirectoryLoader('media/process/'+direct, glob="./*pdf", loader_cls=PDFPlumberLoader, show_progress=True)
	txtloader = TextLoader(jdpath)
	documents = txtloader.load()
	text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
	documents = text_splitter.split_documents(documents)		
	db = FAISS.from_documents(documents, embeddings)
	db.save_local('media/models/jd_model_'+str(jid))



def save_all_data(request):
	if request.method=="POST":
		jobtitle = request.POST.get('jobtitle')
		category = request.POST.get('category')
		subcategory = request.POST.get('subcategory')
		experience = request.POST.get('experience')
		skill = request.POST.get('skill')
		description = request.POST.get('description')
		print(type(description))
		print(jobtitle, category, subcategory, experience, skill)

		number = random.randint(1000, 99999)
		jdfolder_name = "jd_files_"+str(number)

		path = os.path.join(f'media/', jdfolder_name)
		os.mkdir(path)

		jfpath = f"media/{jdfolder_name}/sample.txt"

		with open(f'media/{jdfolder_name}/sample.txt', 'w') as text_file:
			text_file.write(description)
			print("file created..")

		conn = connection()
		mydb = conn.cursor()
		query = f"insert into jobprofile (job_titles, category, sub_category, experience, skills, description, jd_path) values ('{jobtitle}','{category}','{subcategory}','{experience}','{skill}','{description}','{jfpath}')"
		print(query)
		mydb.execute(query)
		conn.commit()

		jd_id = pd.read_sql(f"select jid from jobprofile where jd_path='{jfpath}' ",conn)
		jd_id= jd_id.to_dict('records')
		print(jd_id)
		conn.close();

		generate_model(jfpath, jd_id[0]['jid'])

		return HttpResponse(json.dumps({'done':1,"datasave":1}), content_type="application/json")
	else:
		return redirect('new_job_posting')

import re






def ai_ranker(request):
	if request.method=="POST":
		key = request.POST.get('jid')
		conn = connection()
		
		print(key)
		db = FAISS.load_local('media/models/jd_model_'+str(key), embeddings)
		qa = ConversationalRetrievalChain.from_llm(llm, db.as_retriever(search_kwargs = {'k':5}))
		
		resume_path = pd.read_sql(f"select * from candidate where job_id={key}", conn)
		resume_path = resume_path.to_dict('records')
		print(resume_path)
		if resume_path is None:
			return HttpResponse(json.dumps({'success':0,'msg':"You don't have candidates for this ranking resumes"}), content_type="application/json")
		else:		
		
			for i in resume_path:
				pdf_loader = PDFPlumberLoader(i['resumefile'])
				documents = pdf_loader.load()
				text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
				documents = text_splitter.split_documents(documents)
				text_without_urls = re.sub(r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+', '', str(documents))
				text_without_paths = re.sub(r'([a-zA-Z]:)?(\\\\[a-zA-Z0-9_.-]+)+\\\\?', '', text_without_urls)
				text_without_paths = re.sub(r'\/[a-zA-Z0-9_.-\/]+', '', text_without_paths)
				#print(text_without_paths)
				#user_msg = f"score this resume {text_without_paths} base on existing data return json strictly with key 'score' if not possiable strictly return score as 0 "
				user_msg = f"Given the following resume information, please evaluate and score it for a {i['jobtitle']} position. Return the score as a JSON object with the key 'score'. Resume Information. {text_without_paths}"
				print(user_msg)
				response = qa({"question": user_msg, "chat_history": ""})
				answer = response['answer']
				print(answer)
				try:
					sc = json.loads(answer)
					print(sc)
					score = str(sc['score'])
				except:
					score = '0'

				print(score)
				mydb = conn.cursor()
				mydb.execute(f"insert into resumes_ranker (job_id, candidate_id, score) values ({key},{i['cid']},'{score}') ")
				conn.commit()
			conn.close()
			return HttpResponse(json.dumps({'success':1,"msg":'Resume ranking successfully done.'}), content_type="application/json")
	else:
		return redirect('/')

def resume_ranking(request):
	if request.method == "POST":
		jid = request.POST.get('jobid')
		print(jid)
		conn = connection()
		query = pd.read_sql(f"select c.name, c.jobtitle , r.score, r.created_at from resumes_ranker as r join candidate as c on r.candidate_id = c.cid where r.job_id = {jid};", conn)
		query = query.to_dict('records')
		print(query)
		conn.close()
		context	= {'data':query}
		return render(request,'resume_ranking.html', context)
	else:
		return redirect('/')


def view_all_posting(request):
	conn = connection()
	alljoblist = pd.read_sql(f"select * from jobprofile order by jid  desc", conn)
	conn.close()
	alljoblist = alljoblist.to_dict('records')
	context = {'job':alljoblist}
	return render(request,'view_all_posting.html', context)

def each_post_view(request):
	if request.method == "POST":
		jid = request.POST.get('jobid')
		print(jid)
		conn = connection()
		query = pd.read_sql(f"select * from jobprofile where jid = {jid}", conn)
		print(query.to_dict('records'))
		context = {'data':query.to_dict('records')}
		return render(request,'job_view_post.html', context)
	else:
		return redirect('/')




def create_test(request):
	conn = connection()
	query = pd.read_sql('select sub_category from jobprofile',conn)
	conn.close()
	context = {'job_category':query.to_dict('records')}
	return render(request,'create_test.html',context)

def create_questions_ai(prompt):
	promptx = prompt
	print(promptx)
	response = openai.Completion.create(
      model="text-davinci-003",
      prompt= promptx,
      temperature=0,
      top_p=1,
      max_tokens=2500,
      frequency_penalty=0,
      presence_penalty=0)
	print(response)
	data =  response['choices'][0]["text"]
	print(data)
	return data


def get_test_data(request):
	if request.method == 'POST':
		jobtitle = request.POST.get('jobtitle')
		category = request.POST.get('category')
		subcategory = request.POST.get('subcategory')
		prompt = f'generate quiz test with 10 questions for a {subcategory} post with output in json format where keys are always strictly as "question", "answers" and "rightanswer"  just write json array'
		data = create_questions_ai(prompt)
		print(jobtitle, category, subcategory)
		print("===========")
		questions = json.loads(data)
		print(questions)
		question_data = []

		for i in questions:
			question_data.append({"question":f"{i['question']}", "answers":i['answers'], "rightanswer":f"{i['rightanswer']}"},)

		resp_data = str(question_data).replace(";","semicolon").replace("'",'"');
		print(resp_data)

		print("===========")

		conn = connection()
		mydb = conn.cursor()
		mydb.callproc("setTest", [jobtitle, category, subcategory, resp_data])
		conn.commit()
		conn.close()

		return HttpResponse(json.dumps({'done':1}), content_type="application/json")
	else:
		return redirect('create_test')


def test_result(request):
	conn = connection()
	alltestlist = pd.read_sql(f"select tid,jobtitle,category,subcategory,is_test_active,create_at from createtest order by tid  desc", conn)
	
	conn.close()
	alltestlist = alltestlist.to_dict('records')

	context = {'test':alltestlist}
	return render(request,'test_result.html', context)

def each_test_view(request):
	if request.method == "POST":
		tid = request.POST.get('testid')
		print(tid)
		conn = connection()
		query = pd.read_sql(f"select * from createtest where tid = {tid}", conn)
		question = query.to_dict('records')
		qa = question[0]['questions']
		print(qa)
		
		r = json.loads(qa)
		print(type(r))
		#load_r = json.loads(r)
		#print(type(load_r))

		context = {'data':query.to_dict('records'),'quiz_data':r}
		return render(request,'test_view_page.html', context)
	else:
		return redirect('/')


def create_candidate(request):
	conn = connection()
	query = pd.read_sql('select jid, sub_category from jobprofile',conn)
	conn.close()
	context = {'job_category':query.to_dict('records')}
	return render(request,'create_candidate.html', context)

def create_name(category):
	print(category)
	newname = category.replace(" ","").lower()
	random_num = random.randint(10000,999999)
	new_folder_name = newname+"_"+str(random_num)
	new_path = "media/resumes"
	path = os.path.join(new_path, new_folder_name)
	os.mkdir(path)
	return new_folder_name, path

def handle_uploaded_resume(file, filename):
	fs = FileSystemStorage()
	filepath = os.path.join(settings.MEDIA_ROOT+"/resumes/",filename)
	fs.save(filepath, file)


def get_candidate_data(request):
	if request.method == "POST":
		name = request.POST.get('username')
		jobtitle = request.POST.get('jobtitle')
		category = request.POST.get('jobcategory')
		contact = request.POST.get('contact')
		jobid = request.POST.get('jobid')
		resume = request.FILES['resume']
		resume_name = request.FILES['resume'].name
		print(resume, resume_name, name, jobtitle, contact)
		#foldername, src = create_folder(category)
		print("-------")
		#print(foldername, src)
		print("-------")
		file_ext = "."+resume_name.split(".")[-1]
		randnum = random.randint(100000,9999999)
		new_resume_name = "resume"+"_"+str(randnum)+file_ext
		handle_uploaded_resume(resume, new_resume_name)
		conn = connection()
		mydb = conn.cursor()
		mydb.execute(f"insert into candidate (name, jobtitle, jobcategory, contact, resumefile, job_id) values ('{name}','{jobtitle}','{category}','{contact}','media/resumes/{	new_resume_name}','{jobid}' )")
		conn.commit()
		conn.close()
		messages.success(request,'Candidate create successfully..')
		return redirect('create_candidate')
	else:
		return redirect('/')

def view_candidate(request):
	conn = connection()
	can_query = pd.read_sql(f"select * from candidate order by cid desc", conn)
	test_subject = pd.read_sql(f"select subcategory, test_link from createtest where is_test_active=1", conn)
	conn.close()
	candidate_data = can_query.to_dict('records')
	context = {'candidate':candidate_data,'testdata':test_subject.to_dict('records')}
	return render(request,'view_candidate.html', context)
import string

def generate_random_url():
	 generate_link = ''.join([random.choice(string.ascii_lowercase + string.digits) for n in range(10)])
	 print(generate_link)
	 return generate_link

def create_test_link(request):
	if request.method == 'POST':
		test_id = request.POST.get('test_id')
		print(test_id)
		link = generate_random_url()
		conn = connection()
		mydb = conn.cursor()
		query = f"update createtest set test_link=%s, is_test_active=1 where tid=%s;"
		val = (link,test_id)
		mydb.execute(query, val)
		conn.commit()
		print(mydb.rowcount)
		conn.close()
		return HttpResponse(json.dumps({'msg':1}), content_type="application/json")
	else:
		return HttpResponse(json.dumps({'msg':0}), content_type="application/json")


def assign_test(request):
	if request.method == "POST":
		testkey = request.POST.get('test_key')
		cid = request.POST.get('cidkey')
		print("your test key", testkey, cid)
		sudo_link = f"http://localhost:12/test?key={testkey}"
		conn = connection()
		mydb = conn.cursor()
		mydb.execute(f"update candidate set test_status = 1 where cid={cid}")
		conn.commit()
		conn.close()
		return HttpResponse(json.dumps({'success':1,'link':sudo_link}), content_type="application/json")

	else:
		return HttpResponse(json.dumps({'success':0}), content_type="application/json")


def start_test(request):
	print("testt")
	key = request.GET.get('key')
	print(key)
	context = {'testkey':key}
	return render(request,'verify_your_details.html', context)

def verify_candidate(request):
	if request.method == "POST":
		print("in....")
		number = request.POST.get('mobile_num')
		link = request.POST.get('link')
		print("=====",link)
		print("out....")
		if link is None or link == 'None':
			return redirect('test')
		else:
			
			#print(number, link)
			conn = connection()
			get_number = pd.read_sql(f"SELECT count(*) as number, cid FROM `candidate` where contact = '{number}'", conn)
			get_number = get_number.to_dict('records')
			
			cid = get_number[0]['cid']
			print(cid)
			if get_number[0]['number'] == 1:
				quiz_questions = pd.read_sql(f"select * from createtest where test_link = '{link}' ", conn)
				quiz_questions = quiz_questions.to_dict('records')
				qa = quiz_questions[0]['questions']
				#print(qa)
				testid = quiz_questions[0]['tid']
				#print(testid)
				r = json.loads(qa.replace("'",'"'))
			#	print(type(r))
				conn.close()
				context = {'data':1,'verify':1,'candidate_number':number,'quiz_data':r,'candidateid':cid,'test_link':testid}
				return render(request,'start_test.html', context)
			else:
				return redirect('test')
	else:
		return redirect('test')



def test_submit(request):
	if request.method == "POST":
		total_score = request.POST.get('total_score')
		cid = request.POST.get('cid')
		testid = request.POST.get('testid')
		print(total_score, cid, testid)
		conn = connection()
		mydb = conn.cursor()
		query = f"insert into result_test (candidate_id, test_id, test_score) values ({cid},{testid},{total_score})"
		mydb.execute(query)
		mydb.execute(f"update candidate set test_status = 2 where cid={cid}")
		conn.commit()
		conn.close()

		return HttpResponse(json.dumps({'success':1}), content_type="application/json")

	else:
		return HttpResponse(json.dumps({'success':0}), content_type="application/json")


def check_results(request,id):
	testid = id
	print(testid)
	conn = connection()
	result_query = pd.read_sql(f"SELECT r.result_id, c.name, r.test_score,r.created_at FROM result_test as r JOIN candidate as c on c.cid=r.candidate_id where r.test_id={testid}", conn)
	print(result_query)
	conn.close()
	result_data = result_query.to_dict('records')
	context = {'rs_data':result_data}
	return render(request,'check_results.html', context)




def logout(request):
	del request.session['opoid']
	messages.success(request, "logout successfully...")
	return redirect('/')