"""HR_management URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from index import views as v
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('admin/', admin.site.urls),
    path('',v.login),
    path('get_login_details',v.get_login_details, name="get_login_details"),
    path('dashboard',v.index, name="dashboard"),
    path('new_job_posting', v.new_job_posting, name="new_job_posting"),
    path('get_job_details', v.get_job_details, name="get_job_details"),
    path('save_all_data', v.save_all_data, name="save_all_data"),
    path('view_all_posting', v.view_all_posting, name="view_all_posting"),
    path('check_job_description/', v.each_post_view),
    path('resume_ranking', v.resume_ranking, name="resume_ranking"),
    path('create_test', v.create_test, name="create_test"),
    path('get_test_data', v.get_test_data, name="get_test_data"),
    path('test_result', v.test_result, name="test_result"),
    path('check_test', v.each_test_view, name="check_test"),
    path('active_test', v.create_test_link, name="active_test"),
    path('create_candidate', v.create_candidate, name="create_candidate"),
    path('get_candidate_data', v.get_candidate_data, name="get_candidate_data"),
    path('view_candidate', v.view_candidate, name="view_candidate"),
    path('assign_test', v.assign_test, name="assign_test"),
    path('test', v.start_test, name="test"),
    path('verify_candidate',v.verify_candidate,name="verify_candidate"),
    path('test_submit',v.test_submit,name="test_submit"),
    path('check_results/<int:id>',v.check_results),
    path('ai_ranker',v.ai_ranker, name="ai_ranker"),

    
    path('logout', v.logout, name="logout"),

]+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
