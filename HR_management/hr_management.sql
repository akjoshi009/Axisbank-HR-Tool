-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 10, 2023 at 09:03 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hr_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertQuestionData` (IN `jobtitles` VARCHAR(255), IN `categorys` VARCHAR(255), IN `subcategorys` VARCHAR(255), IN `question_data` TEXT)   BEGIN
    INSERT INTO createtest(jobtitle, category, subcategory, questions)
    VALUES (jobtitles, categorys, subcategorys, question_data);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setTest` (IN `t_jobtitle` VARCHAR(100), IN `t_category` VARCHAR(100), IN `t_subcategory` VARCHAR(100), IN `t_questions` TEXT)   BEGIN
    INSERT INTO createtest (jobtitle, category, subcategory, questions)
    VALUES (t_jobtitle, t_category, t_subcategory, t_questions);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `candidate`
--

CREATE TABLE `candidate` (
  `cid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `jobtitle` varchar(100) NOT NULL,
  `jobcategory` varchar(100) NOT NULL,
  `contact` varchar(12) NOT NULL,
  `resumefile` varchar(150) NOT NULL,
  `job_id` int(11) DEFAULT NULL,
  `test_status` int(11) DEFAULT 0,
  `test_assign_no` int(5) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidate`
--

INSERT INTO `candidate` (`cid`, `name`, `jobtitle`, `jobcategory`, `contact`, `resumefile`, `job_id`, `test_status`, `test_assign_no`, `created_at`) VALUES
(1, 'Sojwal patil', 'laravel developer', 'php', '7485963212', 'media/resumes/resume_2742864.pdf', NULL, 2, NULL, '2023-08-09 15:31:56'),
(2, 'Suraj Gosavi', 'sql developer', 'database', '7588330924', 'media/resumes/resume_7503836.pdf', NULL, 2, NULL, '2023-08-09 15:38:19'),
(3, 'surojit mothye', 'Django developer', 'python', '9930234309', 'media/resumes/resume_7177080.pdf', NULL, 2, NULL, '2023-08-09 15:57:56'),
(4, 'Adarsh Admane', 'Django developer', 'python', '8693085008', 'media/resumes/resume_4614095.pdf', NULL, 0, NULL, '2023-08-09 16:04:29'),
(5, 'Alex Brown', 'Django developer', 'fullstack developer', '8693085009', 'media/resumes/resume_1225863.pdf', 1, 0, NULL, '2023-08-09 17:22:10'),
(6, 'Ajit yadav', 'Database administrator', 'DBA ', '8693058525', 'media/resumes/resume_6028125.pdf', 12, 0, NULL, '2023-08-09 17:32:32'),
(7, 'swapnil panedy', 'Database administrator', 'database', '8693058528', 'media/resumes/resume_2354218.pdf', 12, 0, NULL, '2023-08-09 19:07:57'),
(8, 'Michael Watkins', 'django developer', 'fullstack developer', '2228544879', 'media/resumes/resume_2089717.pdf', 13, 0, NULL, '2023-08-09 21:06:30'),
(10, 'Sojwal patil', 'php developer', 'fullstack developer', '8693085006', 'media/resumes/resume_6895672.pdf', 14, 0, NULL, '2023-08-09 22:07:39'),
(11, 'Aashish auti', 'Java FullStack Developer', 'java', '8693085236', 'media/resumes/resume_8067693.pdf', 15, 0, NULL, '2023-08-09 23:05:49'),
(12, 'Smit shinde', 'Java FullStack Developer', 'java developer', '8693305276', 'media/resumes/resume_2299568.pdf', 15, 0, NULL, '2023-08-09 23:06:47'),
(13, 'Adarsh Admane', 'django developer', 'django developer', '8693085000', 'media/resumes/resume_6699215.pdf', 13, 0, NULL, '2023-08-09 23:12:55'),
(14, 'Rahul Shembdekar', 'dot net developer', 'dot net', '8983586162', 'media/resumes/resume_266216.pdf', 16, 2, NULL, '2023-08-10 10:53:28'),
(15, 'Sachin Anbhule', 'IT Project Manager', 'Information Technology', '8693085123', 'media/resumes/resume_4475744.pdf', 17, 2, NULL, '2023-08-10 12:10:58');

-- --------------------------------------------------------

--
-- Table structure for table `createtest`
--

CREATE TABLE `createtest` (
  `tid` int(11) NOT NULL,
  `jobtitle` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `subcategory` varchar(100) NOT NULL,
  `questions` text NOT NULL,
  `test_link` text DEFAULT NULL,
  `is_test_active` int(11) DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `createtest`
--

INSERT INTO `createtest` (`tid`, `jobtitle`, `category`, `subcategory`, `questions`, `test_link`, `is_test_active`, `create_at`) VALUES
(1, 'Software Engineer', 'php', 'laravel developer', '[{\"question\": \"What is Laravel?\", \"answers\": [\"A PHP framework\", \"A JavaScript library\", \"A database system\"], \"rightanswer\": \"A PHP framework\"}, {\"question\": \"What is the default authentication system used in Laravel?\", \"answers\": [\"OAuth\", \"JWT\", \"Sessions\"], \"rightanswer\": \"Sessions\"}, {\"question\": \"What is the purpose of the .env file in Laravel?\", \"answers\": [\"To store environment variables\", \"To store application configuration\", \"To store database credentials\"], \"rightanswer\": \"To store environment variables\"}, {\"question\": \"What is the purpose of the Artisan command line tool in Laravel?\", \"answers\": [\"To generate code\", \"To manage database migrations\", \"To manage application routes\"], \"rightanswer\": \"To generate code\"}, {\"question\": \"What is the purpose of the Eloquent ORM in Laravel?\", \"answers\": [\"To manage database migrations\", \"To manage application routes\", \"To provide an object-relational mapping system\"], \"rightanswer\": \"To provide an object-relational mapping system\"}, {\"question\": \"What is the purpose of the Blade templating engine in Laravel?\", \"answers\": [\"To provide an object-relational mapping system\", \"To manage database migrations\", \"To provide a simple and powerful templating language\"], \"rightanswer\": \"To provide a simple and powerful templating language\"}, {\"question\": \"What is the purpose of the Laravel Mix tool?\", \"answers\": [\"To manage application routes\", \"To provide an object-relational mapping system\", \"To simplify webpack configuration\"], \"rightanswer\": \"To simplify webpack configuration\"}, {\"question\": \"What is the purpose of the Laravel Dusk tool?\", \"answers\": [\"To simplify webpack configuration\", \"To provide an object-relational mapping system\", \"To simplify browser automation testing\"], \"rightanswer\": \"To simplify browser automation testing\"}, {\"question\": \"What is the purpose of the Laravel Forge tool?\", \"answers\": [\"To simplify browser automation testing\", \"To simplify webpack configuration\", \"To simplify server deployment and configuration\"], \"rightanswer\": \"To simplify server deployment and configuration\"}, {\"question\": \"What is the purpose of the Laravel Horizon tool?\", \"answers\": [\"To simplify server deployment and configuration\", \"To simplify browser automation testing\", \"To simplify queue monitoring and management\"], \"rightanswer\": \"To simplify queue monitoring and management\"}]', 'hlusi8z2eg', 1, '2023-08-09 15:32:59'),
(2, 'Software Engineer', 'Database', 'sql developer', '[{\"question\": \"What is the purpose of the SELECT statement?\", \"answers\": [\"To delete data from a table\", \"To retrieve data from a table\", \"To update data in a table\", \"To create a table\"], \"rightanswer\": \"To retrieve data from a table\"}, {\"question\": \"Which of the following is not a valid aggregate function?\", \"answers\": [\"SUM\", \"AVG\", \"COUNT\", \"DELETE\"], \"rightanswer\": \"DELETE\"}, {\"question\": \"Which of the following is not a valid data type?\", \"answers\": [\"INTEGER\", \"VARCHAR\", \"FLOAT\", \"BOOLEAN\"], \"rightanswer\": \"BOOLEAN\"}, {\"question\": \"Which of the following is not a valid SQL clause?\", \"answers\": [\"SELECT\", \"WHERE\", \"ORDER BY\", \"DELETE\"], \"rightanswer\": \"DELETE\"}, {\"question\": \"Which of the following is not a valid SQL operator?\", \"answers\": [\"=\", \">\", \"<\", \"DELETE\"], \"rightanswer\": \"DELETE\"}, {\"question\": \"Which of the following is not a valid SQL join?\", \"answers\": [\"INNER JOIN\", \"LEFT JOIN\", \"RIGHT JOIN\", \"DELETE JOIN\"], \"rightanswer\": \"DELETE JOIN\"}, {\"question\": \"Which of the following is not a valid SQL constraint?\", \"answers\": [\"PRIMARY KEY\", \"FOREIGN KEY\", \"UNIQUE\", \"DELETE\"], \"rightanswer\": \"DELETE\"}, {\"question\": \"Which of the following is not a valid SQL statement?\", \"answers\": [\"SELECT\", \"UPDATE\", \"DELETE\", \"CREATE\"], \"rightanswer\": \"CREATE\"}, {\"question\": \"Which of the following is not a valid SQL function?\", \"answers\": [\"COUNT\", \"SUM\", \"AVG\", \"DELETE\"], \"rightanswer\": \"DELETE\"}, {\"question\": \"Which of the following is not a valid SQL data type?\", \"answers\": [\"INTEGER\", \"VARCHAR\", \"FLOAT\", \"DELETE\"], \"rightanswer\": \"DELETE\"}]', 'xz078ew23q', 1, '2023-08-09 15:39:35'),
(3, 'Software Developer', 'python', 'Django developer', '[{\"question\": \"What is Django?\", \"answers\": [\"A web framework\", \"A programming language\", \"A database\"], \"rightanswer\": \"A web framework\"}, {\"question\": \"What is the purpose of Django?\", \"answers\": [\"To create web applications quickly and easily\", \"To create mobile applications\", \"To create desktop applications\"], \"rightanswer\": \"To create web applications quickly and easily\"}, {\"question\": \"What is the syntax for creating a view in Django?\", \"answers\": [\"def view_name(request):\", \"def view_name():\", \"def view_name(request, args):\"], \"rightanswer\": \"def view_name(request):\"}, {\"question\": \"What is the purpose of the Django ORM?\", \"answers\": [\"To create and manage database tables\", \"To create and manage web applications\", \"To create and manage database queries\"], \"rightanswer\": \"To create and manage database queries\"}, {\"question\": \"What is the purpose of the Django template language?\", \"answers\": [\"To create HTML pages\", \"To create web applications\", \"To create database queries\"], \"rightanswer\": \"To create HTML pages\"}, {\"question\": \"What is the purpose of the Django admin interface?\", \"answers\": [\"To create and manage web applications\", \"To create and manage database tables\", \"To create and manage user accounts\"], \"rightanswer\": \"To create and manage user accounts\"}, {\"question\": \"What is the purpose of the Django forms library?\", \"answers\": [\"To create and manage web forms\", \"To create and manage database tables\", \"To create and manage user accounts\"], \"rightanswer\": \"To create and manage web forms\"}, {\"question\": \"What is the purpose of the Django middleware?\", \"answers\": [\"To process requests and responses\", \"To create and manage web applications\", \"To create and manage user accounts\"], \"rightanswer\": \"To process requests and responses\"}, {\"question\": \"What is the purpose of the Django signals library?\", \"answers\": [\"To create and manage web applications\", \"To create and manage database tables\", \"To send and receive signals between different parts of the application\"], \"rightanswer\": \"To send and receive signals between different parts of the application\"}, {\"question\": \"What is the purpose of the Django test framework?\", \"answers\": [\"To create and manage web applications\", \"To create and manage database tables\", \"To write and run automated tests\"], \"rightanswer\": \"To write and run automated tests\"}]', '9ux66sa4o8', 1, '2023-08-09 15:56:52'),
(4, 'Software Developer', 'dot net', 'dot net developer', '[{\"question\": \"What is the .NET Framework?\", \"answers\": [\"A programming language\", \"A library of pre-written code\", \"A platform for developing applications\"], \"rightanswer\": \"A platform for developing applications\"}, {\"question\": \"What is the purpose of the Common Language Runtime (CLR)?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To provide a platform for developing applications\"], \"rightanswer\": \"To provide a secure environment for executing code\"}, {\"question\": \"What is the purpose of the .NET Framework Class Library (FCL)?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To provide a platform for developing applications\"], \"rightanswer\": \"To provide a library of pre-written code\"}, {\"question\": \"What is the purpose of the .NET Framework SDK?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To provide a platform for developing applications\"], \"rightanswer\": \"To provide a platform for developing applications\"}, {\"question\": \"What is the purpose of the .NET Framework Version Compatibility?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To ensure that applications written for one version of the .NET Framework will work on another version\"], \"rightanswer\": \"To ensure that applications written for one version of the .NET Framework will work on another version\"}, {\"question\": \"What is the purpose of the .NET Framework Configuration Tool?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To configure the .NET Framework on a computer\"], \"rightanswer\": \"To configure the .NET Framework on a computer\"}, {\"question\": \"What is the purpose of the .NET Framework Security Model?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To provide a platform for developing applications\"], \"rightanswer\": \"To provide a secure environment for executing code\"}, {\"question\": \"What is the purpose of the .NET Framework Global Assembly Cache (GAC)?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To store shared assemblies\"], \"rightanswer\": \"To store shared assemblies\"}, {\"question\": \"What is the purpose of the .NET Framework Code Access Security (CAS)?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To provide a platform for developing applications\"], \"rightanswer\": \"To provide a secure environment for executing code\"}, {\"question\": \"What is the purpose of the .NET Framework Common Language Specification (CLS)?\", \"answers\": [\"To provide a secure environment for executing code\", \"To provide a library of pre-written code\", \"To ensure that code written in different languages can interact with each other\"], \"rightanswer\": \"To ensure that code written in different languages can interact with each other\"}]', '2a1diigaxw', 1, '2023-08-10 10:54:14'),
(5, 'Software Engineer', 'python', 'IT Project Manager', '[{\"question\": \"What is the primary role of a Project Manager?\", \"answers\": [\"Leading the project team\", \"Developing project plans\", \"Managing project budget\", \"Monitoring project progress\"], \"rightanswer\": \"Leading the project team\"}, {\"question\": \"What is the most important skill for a Project Manager?\", \"answers\": [\"Leadership\", \"Organizational skills\", \"Communication skills\", \"Problem-solving skills\"], \"rightanswer\": \"Leadership\"}, {\"question\": \"What is the most important factor for successful project management?\", \"answers\": [\"Clear objectives\", \"Effective communication\", \"Time management\", \"Risk management\"], \"rightanswer\": \"Clear objectives\"}, {\"question\": \"What is the most important document for a project manager?\", \"answers\": [\"Project charter\", \"Project plan\", \"Project budget\", \"Project timeline\"], \"rightanswer\": \"Project charter\"}, {\"question\": \"What is the most important tool for a project manager?\", \"answers\": [\"Project management software\", \"Spreadsheet software\", \"Presentation software\", \"Word processing software\"], \"rightanswer\": \"Project management software\"}, {\"question\": \"What is the most important quality for a project manager?\", \"answers\": [\"Leadership\", \"Organizational skills\", \"Communication Skills\", \"Problem-solving Skills\"], \"rightanswer\": \"Leadership\"}, {\"question\": \"What is the most important factor for successful project completion?\", \"answers\": [\"Clear objectives\", \"Effective communication\", \"Time management\", \"Risk management\"], \"rightanswer\": \"Time management\"}, {\"question\": \"What is the most important document for a project manager to create?\", \"answers\": [\"Project charter\", \"Project plan\", \"Project budget\", \"Project timeline\"], \"rightanswer\": \"Project plan\"}, {\"question\": \"What is the most important tool for a project manager to use?\", \"answers\": [\"Project management software\", \"Spreadsheet software\", \"Presentation software\", \"Word processing software\"], \"rightanswer\": \"Project management software\"}, {\"question\": \"What is the most important quality for a project manager to possess?\", \"answers\": [\"Leadership\", \"Organizational skills\", \"Communication Skills\", \"Problem-solving Skills\"], \"rightanswer\": \"Communication Skills\"}]', 'aynrwbtpht', 1, '2023-08-10 12:12:19');

-- --------------------------------------------------------

--
-- Table structure for table `jobprofile`
--

CREATE TABLE `jobprofile` (
  `jid` int(11) NOT NULL,
  `job_titles` varchar(100) DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `sub_category` varchar(100) NOT NULL,
  `experience` varchar(10) NOT NULL,
  `skills` mediumtext NOT NULL,
  `description` mediumtext NOT NULL,
  `jd_path` varchar(200) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobprofile`
--

INSERT INTO `jobprofile` (`jid`, `job_titles`, `category`, `sub_category`, `experience`, `skills`, `description`, `jd_path`, `created_at`) VALUES
(1, 'Software Engineer', 'python', 'Django developer', '2-5', 'html, css, javascript, jquery, ui/ux, python, basic knowlege of data analysis, django, flask, rest api', '<h2>Software Engineer (Python/Django Developer) - Unicornis AI Solutions</h2><p><strong>Job Description:</strong></p><p>We are looking for an experienced Software Engineer (Python/Django Developer) to join our team at Unicornis AI Solutions. The ideal candidate should have 2-5 years of experience in developing web applications using HTML, CSS, JavaScript, jQuery, UI/UX, Python, basic knowledge of data analysis, Django, Flask, and REST API.</p><p><strong>Responsibilities:</strong></p><ul><li>Develop web applications using HTML, CSS, JavaScript, jQuery, UI/UX, Python, basic knowledge of data analysis, Django, Flask, and REST API.</li><li>Design, develop, and maintain web applications.</li><li>Troubleshoot and debug applications.</li><li>Write clean, maintainable, and efficient code.</li><li>Integrate user-facing elements into applications.</li><li>Develop and implement security measures.</li><li>Collaborate with other developers to integrate systems.</li><li>Test and debug applications.</li><li>Stay up-to-date with the latest technologies.</li></ul><p><strong>Requirements:</strong></p><ul><li>2-5 years of experience in developing web applications using HTML, CSS, JavaScript, jQuery, UI/UX, Python, basic knowledge of data analysis, Django, Flask, and REST API.</li><li>Strong knowledge of web development technologies.</li><li>Experience with databases and object-relational mapping.</li><li>Excellent problem-solving and communication skills.</li><li>Ability to work independently and as part of a team.</li><li>Ability to work in a fast-paced environment.</li></ul>', 'media/jd_files_53850/sample.txt', '2023-08-09 15:26:27'),
(2, 'Software Engineer', 'php', 'laravel developer', '2-5', 'php, laravel, html, css, javascript', '<h3>Software Engineer (PHP/Laravel Developer) - Unicornis AI Solutions</h3><p>We are looking for an experienced Software Engineer (PHP/Laravel Developer) to join our team at Unicornis AI Solutions. The ideal candidate should have 2-5 years of experience in developing web applications using PHP, Laravel, HTML, CSS, and JavaScript.</p><p><strong>Responsibilities:</strong></p><ul><li>Develop web applications using PHP, Laravel, HTML, CSS, and JavaScript.</li><li>Design, develop, and maintain web applications.</li><li>Troubleshoot and debug applications.</li><li>Write clean, maintainable, and efficient code.</li><li>Integrate data storage solutions.</li><li>Ensure the best possible performance, quality, and responsiveness of applications.</li><li>Identify bottlenecks and bugs, and devise solutions to these problems.</li><li>Help maintain code quality, organization, and automation.</li></ul><p><strong>Requirements:</strong></p><ul><li>2-5 years of experience in developing web applications using PHP, Laravel, HTML, CSS, and JavaScript.</li><li>Strong knowledge of web application development processes, from the layout/user interface to relational database structures.</li><li>Experience with version control systems such as Git.</li><li>Excellent communication and problem-solving skills.</li><li>Ability to work independently and as part of a team.</li></ul>', 'media/jd_files_12363/sample.txt', '2023-08-09 15:26:59'),
(3, 'Network engineer', 'Network', 'Network assistant engineer', '5+', 'networking, rounting configure, lan, wan, cyber security knowledge', '<h2>Network Assistant Engineer - Unicornis AI Solutions</h2><p>We are looking for an experienced Network Engineer to join our team at Unicornis AI Solutions. The ideal candidate should have 5+ years of experience in networking, routing configuration, LAN, WAN, and cyber security knowledge.</p><h3>Responsibilities:</h3><ul><li>Design, install, configure, and maintain network systems.</li><li>Monitor and troubleshoot network performance.</li><li>Analyze network traffic and identify potential security threats.</li><li>Develop and implement network security policies.</li><li>Provide technical support to users.</li><li>Perform regular system maintenance and upgrades.</li><li>Document network configurations and procedures.</li></ul><h3>Requirements:</h3><ul><li>5+ years of experience in network engineering.</li><li>Expertise in routing configuration, LAN, WAN, and cyber security.</li><li>Strong problem-solving and analytical skills.</li><li>Excellent communication and interpersonal skills.</li><li>Ability to work independently and as part of a team.</li></ul>', 'media/jd_files_2866/sample.txt', '2023-08-09 15:28:40'),
(12, 'Database Engineer', 'Database', 'Database administrator', '5+', 'sql, mysql ,plsql', '<h2>Database Engineer - Unicornis AI Solutions</h2><p>We are looking for an experienced Database Engineer to join our team at Unicornis AI Solutions. The ideal candidate should have 5+ years of experience in database administration, with a strong background in SQL, MySQL, and PL/SQL.</p><h3>Responsibilities:</h3><ul><li>Design, develop, and maintain databases.</li><li>Optimize database performance and troubleshoot any issues.</li><li>Ensure data integrity and security.</li><li>Develop and implement database backup and recovery procedures.</li><li>Monitor database performance and capacity.</li><li>Provide technical support for database-related issues.</li><li>Create and maintain database documentation.</li></ul><h3>Requirements:</h3><ul><li>5+ years of experience in database administration.</li><li>Strong knowledge of SQL, MySQL, and PL/SQL.</li><li>Experience with database design and development.</li><li>Excellent problem-solving and troubleshooting skills.</li><li>Good communication and interpersonal skills.</li></ul>', 'media/jd_files_18871/sample.txt', '2023-08-09 16:35:48'),
(13, 'Software Developer', 'Python', 'django developer', '2-5', 'html, css, javascript, django, flask ,python, ', '<h3>Software Developer (Python/Django) - Unicornis AI Solutions</h3><p>We are looking for an experienced Software Developer (Python/Django) to join our team at Unicornis AI Solutions. The ideal candidate should have 2-5 years of experience in developing software applications using Python, Django, HTML, CSS, JavaScript, and Flask.</p><p><strong>Responsibilities:</strong></p><ul><li>Develop software applications using Python, Django, HTML, CSS, JavaScript, and Flask.</li><li>Design, develop, and maintain web applications.</li><li>Analyze user requirements and develop software solutions.</li><li>Troubleshoot and debug applications.</li><li>Write and maintain documentation.</li><li>Collaborate with other developers and stakeholders.</li></ul><p><strong>Requirements:</strong></p><ul><li>2-5 years of experience in software development.</li><li>Proficiency in Python, Django, HTML, CSS, JavaScript, and Flask.</li><li>Knowledge of databases and SQL.</li><li>Excellent problem-solving and communication skills.</li><li>Ability to work independently and as part of a team.</li></ul>', 'media/jd_files_45105/sample.txt', '2023-08-09 21:01:25'),
(14, 'Software Developer', 'php', 'php developer', '2-5', 'php, wordpress, laravel', '<p><strong>Software Developer (PHP Developer) - Unicornis AI Solutions</strong></p><p>We are looking for an experienced Software Developer (PHP Developer) to join our team at Unicornis AI Solutions. The ideal candidate should have 2-5 years of experience in developing software using PHP, WordPress, and Laravel.</p><p>Responsibilities:</p><ul><li>Develop software applications using PHP, WordPress, and Laravel.</li><li>Analyze user requirements and develop software solutions.</li><li>Design and develop database structures.</li><li>Test and debug software applications.</li><li>Maintain and improve existing software applications.</li><li>Provide technical support to users.</li></ul><p>Requirements:</p><ul><li>2-5 years of experience in software development.</li><li>Proficiency in PHP, WordPress, and Laravel.</li><li>Knowledge of HTML, CSS, and JavaScript.</li><li>Excellent problem-solving and communication skills.</li><li>Ability to work independently and as part of a team.</li></ul>', 'media/jd_files_85331/sample.txt', '2023-08-09 22:06:37'),
(15, 'Software Developer', 'java', 'Java FullStack Developer', '5+', 'core java, fullstack, web developement, backend', '<h3>Software Developer (Java FullStack Developer) - Unicornis AI Solutions</h3><p><strong>Job Description:</strong></p><p>We are looking for an experienced Software Developer (Java FullStack Developer) to join our team at Unicornis AI Solutions. The ideal candidate should have 5+ years of experience in developing software applications using Core Java, FullStack, Web Development, and Backend technologies.</p><p><strong>Responsibilities:</strong></p><ul><li>Develop software applications using Core Java, FullStack, Web Development, and Backend technologies.</li><li>Analyze user requirements and develop software solutions.</li><li>Design, develop, and maintain software applications.</li><li>Troubleshoot and debug software applications.</li><li>Test and deploy software applications.</li><li>Provide technical support for software applications.</li></ul><p><strong>Requirements:</strong></p><ul><li>5+ years of experience in software development.</li><li>Expertise in Core Java, FullStack, Web Development, and Backend technologies.</li><li>Strong problem-solving and analytical skills.</li><li>Excellent communication and interpersonal skills.</li><li>Ability to work independently and as part of a team.</li></ul>', 'media/jd_files_42079/sample.txt', '2023-08-09 23:05:09'),
(16, 'Software Developer', 'Dot net', 'dot net developer', '2-5', 'dot net ', '<h3>Software Developer (Dot Net) - Unicornis AI Solutions</h3><p>We are looking for an experienced Software Developer (Dot Net) to join our team at Unicornis AI Solutions. The ideal candidate should have 2-5 years of experience in developing software applications using Dot Net technologies.</p><p><strong>Responsibilities:</strong></p><ul><li>Develop software applications using Dot Net technologies</li><li>Design, code, test, debug, and document software applications</li><li>Analyze user requirements and develop software solutions</li><li>Integrate software components into a fully functional software system</li><li>Develop software verification plans and quality assurance procedures</li><li>Troubleshoot, debug and upgrade existing systems</li><li>Deploy programs and evaluate user feedback</li><li>Comply with project plans and industry standards</li></ul><p><strong>Requirements:</strong></p><ul><li>2-5 years of experience in developing software applications using Dot Net technologies</li><li>Proficiency in HTML, CSS, JavaScript, and other web technologies</li><li>Knowledge of object-oriented programming and design patterns</li><li>Familiarity with databases, web services, and UI/UX design</li><li>Excellent problem-solving and communication skills</li><li>Ability to work independently and as part of a team</li></ul>', 'media/jd_files_32953/sample.txt', '2023-08-10 10:48:50'),
(17, 'IT Project Manager', 'Information Technology', 'IT Project Manager', '5+', 'IT Project Manager', '<h2>IT Project Manager - Unicornis AI Solutions</h2><p>We are looking for an experienced IT Project Manager to join our team at Unicornis AI Solutions. The ideal candidate will have 5+ years of experience in the IT field, with a focus on project management.</p><h3>Responsibilities:</h3><ul><li>Develop and manage project plans, timelines, and budgets</li><li>Lead project teams to ensure successful completion of projects</li><li>Identify and manage project risks and issues</li><li>Monitor project progress and provide regular updates to stakeholders</li><li>Ensure projects are completed on time and within budget</li><li>Develop and maintain relationships with stakeholders</li><li>Provide technical guidance and support to project teams</li></ul><h3>Requirements:</h3><ul><li>5+ years of experience in IT project management</li><li>Strong understanding of project management principles and methodologies</li><li>Excellent communication and interpersonal skills</li><li>Ability to work independently and as part of a team</li><li>Proficiency in MS Office and project management software</li><li>Ability to manage multiple projects simultaneously</li></ul>', 'media/jd_files_62380/sample.txt', '2023-08-10 12:10:03');

-- --------------------------------------------------------

--
-- Table structure for table `result_test`
--

CREATE TABLE `result_test` (
  `result_id` int(11) NOT NULL,
  `candidate_id` int(10) NOT NULL,
  `test_id` int(11) NOT NULL,
  `test_score` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `result_test`
--

INSERT INTO `result_test` (`result_id`, `candidate_id`, `test_id`, `test_score`, `created_at`) VALUES
(1, 2, 2, 8, '2023-08-09 15:43:55'),
(2, 1, 1, 7, '2023-08-09 15:53:40'),
(3, 3, 3, 10, '2023-08-09 17:45:41'),
(4, 14, 4, 8, '2023-08-10 11:37:59'),
(5, 15, 5, 3, '2023-08-10 12:13:19');

-- --------------------------------------------------------

--
-- Table structure for table `resumes_ranker`
--

CREATE TABLE `resumes_ranker` (
  `rid` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `score` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resumes_ranker`
--

INSERT INTO `resumes_ranker` (`rid`, `job_id`, `candidate_id`, `created_at`, `score`) VALUES
(13, 12, 6, '2023-08-09 20:41:01', '0'),
(14, 12, 7, '2023-08-09 20:41:04', '0.75'),
(15, 12, 6, '2023-08-09 22:04:32', '8.5'),
(16, 12, 6, '2023-08-09 22:20:08', '8.5'),
(17, 14, 10, '2023-08-09 22:24:55', '0'),
(18, 13, 8, '2023-08-09 22:25:15', '0'),
(19, 12, 6, '2023-08-09 22:25:27', '8.5'),
(20, 12, 7, '2023-08-09 22:25:29', '0'),
(21, 12, 6, '2023-08-09 22:40:14', '0'),
(22, 12, 7, '2023-08-09 22:40:16', '0.75'),
(23, 13, 8, '2023-08-09 22:40:26', '0'),
(24, 14, 10, '2023-08-09 22:40:34', '0'),
(25, 12, 6, '2023-08-09 22:44:15', '0'),
(26, 12, 7, '2023-08-09 22:44:17', '0'),
(27, 14, 10, '2023-08-09 22:44:26', '0'),
(28, 13, 8, '2023-08-09 22:44:40', '0'),
(29, 14, 10, '2023-08-09 22:46:17', '0'),
(30, 14, 10, '2023-08-09 22:46:51', '0'),
(31, 14, 10, '2023-08-09 22:49:39', '0'),
(32, 14, 10, '2023-08-09 22:54:34', '0'),
(33, 14, 10, '2023-08-09 22:56:36', '0'),
(34, 13, 8, '2023-08-09 22:57:02', '0'),
(35, 13, 8, '2023-08-09 22:58:23', '8'),
(36, 12, 6, '2023-08-09 22:58:46', '8.5'),
(37, 12, 7, '2023-08-09 22:58:48', '8'),
(38, 14, 10, '2023-08-09 22:59:50', '0'),
(39, 13, 8, '2023-08-09 23:00:26', '8'),
(40, 15, 11, '2023-08-09 23:07:21', '0'),
(41, 15, 12, '2023-08-09 23:07:23', '0'),
(42, 13, 8, '2023-08-09 23:13:04', '8'),
(43, 13, 13, '2023-08-09 23:13:07', '0'),
(44, 12, 6, '2023-08-09 23:15:54', '8.5'),
(45, 12, 7, '2023-08-09 23:15:56', '8'),
(46, 14, 10, '2023-08-09 23:16:49', '0'),
(47, 13, 8, '2023-08-09 23:19:18', '8'),
(48, 13, 13, '2023-08-09 23:19:22', '0'),
(49, 14, 10, '2023-08-09 23:19:31', '8'),
(50, 15, 11, '2023-08-09 23:19:47', '8.5'),
(51, 15, 12, '2023-08-09 23:19:49', '8.5'),
(52, 13, 8, '2023-08-09 23:21:07', '8'),
(53, 13, 13, '2023-08-09 23:21:09', '0'),
(54, 16, 14, '2023-08-10 10:58:40', '8'),
(55, 16, 14, '2023-08-10 10:59:12', '8'),
(56, 17, 15, '2023-08-10 12:13:45', '8.5');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `jobtitle` varchar(50) NOT NULL,
  `opoid` varchar(12) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(16) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `jobtitle`, `opoid`, `username`, `password`, `created_at`, `modified_at`) VALUES
(1, 'Adarsh', 'Admane', 'Software Developer', 'opo106021', 'adarsh55', 'Pass@12345', '2023-08-04 13:37:08', '2023-08-04 13:37:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `candidate`
--
ALTER TABLE `candidate`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `createtest`
--
ALTER TABLE `createtest`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `jobprofile`
--
ALTER TABLE `jobprofile`
  ADD PRIMARY KEY (`jid`);

--
-- Indexes for table `result_test`
--
ALTER TABLE `result_test`
  ADD PRIMARY KEY (`result_id`);

--
-- Indexes for table `resumes_ranker`
--
ALTER TABLE `resumes_ranker`
  ADD PRIMARY KEY (`rid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `candidate`
--
ALTER TABLE `candidate`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `createtest`
--
ALTER TABLE `createtest`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jobprofile`
--
ALTER TABLE `jobprofile`
  MODIFY `jid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `result_test`
--
ALTER TABLE `result_test`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `resumes_ranker`
--
ALTER TABLE `resumes_ranker`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
