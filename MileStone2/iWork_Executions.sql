USE iWork;

--search by company name
--registered 1
exec searchbyCname 'go Ogle' --exists

exec searchbyCname 'k'       --doesnt exist


--search by addresss

exec searchbyCaddress 'seattle'

exec searchbyCaddress 'california'


--search by type

exec searchbyCtype 'National'

exec searchbyCtype 'International'

--#############################################################--

--view all companies
--2

exec viewallcompanies

--############################################################--
--view certain company and its departments

exec viewcertaincompany 'google.com'

--###########################################################--

--view departments of comapnies with jobs that have vacancies in it

exec viewcertaindepartment 'google.com','Android_OS'

--#########################################################--

--registering and entering previous job entries after he register

exec register @username='balabizo',@password='5679',@birthdate='1998/07/10',@firstname='sameh',@lastname='wagih'--to test it sets default values

exec register @username='balabizo',@password='5679',@birthdate='1998/07/10',@firstname='sameh',@lastname='wagih' --prints username already in use 

exec previousjobsentery @pjob='software engineer at ibm',@username='balabizo' --enters a record for a perivious job tittle of balabizo

exec previousjobsentery @pjob='software engineer at ibm',@username='balabizo' --prints you already entered this job tittle

exec previousjobsentery @pjob='ceo of ggg',@username='balabizo' --enters a record for a perivious job tittle of balabizo

--#########################################################--

--search for jobs that have vacancies in them with string contained in their tittle or short desc

exec searchforjob 'hr'

exec searchforjob 'software'

exec searchforjob 'motivates'
--#########################################################--

exec highestavgsalaries

--#########################################################--
--login

exec loginweb 'AmrMKayid','Hello, World!' --registed manager

exec loginweb 'AmrMKayid25','Hello, World!'--wrong username

exec loginweb 'AmrMKayid','Hello, World!25'--correct user name wrong password

exec loginweb 'Maza','Hello, World*' --registered job seeker

exec loginweb 'Adel','Hello, World0'--registered hr

exec loginweb 'Regular1','Hello, World2'--registered Regular

--#########################################################--
--view all user info

exec Viewuserinfo 'Adel'

exec Viewuserinfo 'shadi.barghash'

exec Viewuserinfo null --register or login message

--#########################################################--
--user info editing

exec editusername 'editingtrial','Adel' --Adel is the name of another registered user so username in use will be displayed

exec editusername 'editingtrial','crazy'--successfully changed

exec edituserpassword 'crazy','heyyou'

exec edituseremail 'crazy','crazy@yahoo.com'

exec edituserfn 'crazy','crazy'

exec editusermn 'crazy','crazy'

exec edituserln 'crazy','crazy'

exec edituserbd 'crazy','1968/8/8'

exec edituseryofe 'crazy',25 --years of experience

--##########################################################--
--Apply for job

exec Applyforjob 'Maza7','Hr-Android HR','Android_OS','google.com',30 --first time to apply for a job

exec Applyforjob 'Maza','Hr-Android HR','Android_OS','google.com',30 --still in reviewing process

exec Applyforjob 'Maza2','Hr-Android HR','Android_OS','google.com',90 --already applied before and got accepted

--save score

--questions 
Exec viewquestions 'Hr-Web Development HR', 'Web_Dev', 'facebook.com'
--
declare @scoreout int
Exec calculateanswer 1,1,@scoreout output
--##########################################################--
--view my job applications status

exec viewapplicationstatus 'Maza'

exec viewapplicationstatus 'Maza2'

--##########################################################--
--choose a job i got accepted in

exec chooseajob 2,'Maza2',sunday--was a jobseeker
exec chooseajob 3,'Maza2',Monday--became a staff member and chose another job so he is going to be a staff member in it


--##########################################################--
--delete job application

exec deletejobapp 5,'Maza1' --will be deleted ie in pending at hr

exec deletejobapp 6,'Maza1' -- accepted by hr but manager pending

--###########################################################--
--check in proc the takes user name and the current time stamp from website

exec checkin 'Adel' --dayoff sunday

exec checkin 'AmrMKayid'

--############################################################--
-- a function to extract the date from date time
go
select dbo.getthedate(CURRENT_TIMESTAMP)  

--############################################################--

--a function to extract the time from date time
go
select dbo.getthetime(CURRENT_TIMESTAMP)

--############################################################--
--check out execution
go
exec checkout 'AmrMKayid'

exec checkout  'Adel'

exec checkout  'Adel'


--###########################################################--
--user checks attendance 

exec checkmyattendance 'Adel' ,'2017/10/18','2017/10/20'

--###########################################################--
--##############################################################yasmeen's end######################################################--
-- As a staff member, I should be able to ..

-- [4] Apply for requests of both types: leave requests or business trip requests.

-- Leave request
EXEC Apply_for_Leave_Request 'danial.ashraf', 'shadi.barghash', '2017-11-21', '2017-11-22', 'sick'
EXEC Apply_for_Leave_Request 'shadi.barghash', 'danial.ashraf', '2017-11-23', '2017-11-24', 'sick'
EXEC Apply_for_Leave_Request 'shadi.barghash', 'danial.ashraf', '2018-06-05', '2018-06-28', 'annual'

-- Business Trip
EXEC Apply_for_Business_Trip 'shadi.barghash', 'danial.ashraf', '2018-01-04', '2018-01-08', 'Cairo, Egypt', 'Microsoft Dev Conf'

-- [5] View the status of all requests I applied for before (HR employee and manager responses)
EXEC Show_my_Requests 'shadi.barghash'

-- [6] Delete any request I applied for as long as it is still in the review process.
EXEC Delete_my_Pending_Requests 'danial.ashraf'

-- [7] Send emails to staff members in my company.
DECLARE @email1_id INT
EXEC Create_Email 'Finished my part, too.', 'I''ve just finished my part from Windows-iOS P2P comm.', @email1_id OUT
EXEC Send_Email_in_Company 'danial.ashraf', 'nesrine.anwarr', @email1_id

-- [8] View emails sent to me by other staff members of my company.
EXEC View_my_inbox_Emails 'nesrine.anwarr'

-- [9] Reply to an email sent to me, while the reply would be saved in the database as a new email record.
EXEC Reply_to_Email 1, 'nesrine.anwarr', 'shadi.barghash', 'Bravo!', 'Bravo ya Amar :)'

-- [10] View announcements related to my company within the past 20 days.
EXEC Announcements_of_Company 'danial.ashraf'

-- As an HR Employee, I should be able to ..

-- [1] Add a new job that belongs to my department.

-- [HELPER] Add questions first
DECLARE @question1 INT
EXEC Create_Question 'The Capital of Egypt is Cairo.', 1, @question1 OUT
DECLARE @question2 INT
EXEC Create_Question 'The Capital of Saudi Arabia is Riyadh.', 1, @question2 OUT

-- >>> Add Job
EXEC Add_Job 'nourAli', 'Regular Employee - Android Programmer', 'AppDev', 'runtastic.com',
			'Program the Andorid App.', 'Program the Android App bardo :D', 5, 4, 3000, '2017-12-21', 2

-- Add questions to Job
EXEC Add_Job_Question_to_Job 2, 'Regular Employee - Android Programmer', 'AppDev', 'runtastic.com'
EXEC Add_Job_Question_to_Job 1, 'Regular Employee - Android Programmer', 'AppDev', 'runtastic.com'

-- [2] View information about a job in my department.
EXEC View_Job_in_Department 'nourAli', 'Regular Employee - Windows App Programmer'

-- NOT SURE: [3] Edit the information of a job in my department.

-- >>> Edit the job, with some new data and some copied from the original entry. In the end, the whole job is updated.
EXEC Edit_Job_in_Department 'nourAli', 'Regular Employee - Android Programmer',
							'Program the Andorid App.', 'Program the Android App bardo :D',
							4, 6, 4000, '2017-12-21', 1

-- [4] View new applications for a specific job in my department.
EXEC View_new_Applications_for_Job_in_Department 'shadwa-barghash', 'HR Employee - Motivation'

-- [5] Accept or reject applications for jobs in my department.
EXEC Respond_to_Job_Application_HR 'shadwa-barghash', 9, 'TRUE'
EXEC Respond_to_Job_Application_HR 'shadwa-barghash', 10, 'FALSE'

-- [6] Post announcements related to my company to inform staff members about new updates.
EXEC Post_Announcement 'shadwa-barghash', 'Employee Birthday', 'Surprise birthday', 'As you all know, Shadi is my twin brother, and one of the best programmers in Runtastic, so we want to make him a surprise birthday party. Please join, he''s Gemini and he''ll like it.'

-- [7] View requests of staff members working with me in the same department that were approved by a manager only.
EXEC View_Requests_approved_by_Manager_only 'nourAli'

-- [8] Accept or reject requests of staff members working with me in the same department that were approved by a manager.
EXEC Respond_to_Request_HR 'nourAli', '2018-01-01', 'danial.ashraf', 'TRUE'
EXEC Respond_to_Request_HR 'nourAli', '2018-01-20', 'shadi.barghash', 'FALSE'

-- [9] View attendance records of a staff member in my department
EXEC View_Attendance_of_Staff_Member 'Regular1', '2017-11-22', '2017-11-24', 'Ahmed'

-- [10] View the total number of hours for any staﬀ member in my department in each month of a certain year.
exec  view_totalhours_of_staff @hr='Ahmed',@staff='Regular1',@year=2017

-- [11] View names of the top 3 high achievers in my department.
-- A high achiever is a regular employee who stayed the longest hours in the company for a certain month
-- and all tasks assigned to him/her with deadline within this month are fixed.
exec top_3_achievers 'Ahmed' , 11,2017

---- ##### ##### ##### ##### ##### ##### ##### #####  Start of Amr's Executions  ##### ##### ##### #####  ##### ##### ##### ##### -----

---- “As a regular employee, I should be able to ...”

---- Number 1
GO
EXEC viewMyAssignedProjects 'Regular1'

---- Number 2
GO
EXEC viewMyAssignedTasksInAProject 'Regular5', 'First Project'

---- Number 3
-- GO
-- SELECt * FROM Tasks
GO
EXEC FinishedTask 'Regular7', 'AssignedAmr''sTask', 'Second Project'
GO
EXEC FinishedTask 'Regular7', 'FixedAmr''sTask', 'Second Project'
GO
EXEC FinishedTask 'Regular7', 'AssignedAmr''sTaskAfterDeadline', 'Second Project'
-- SELECt * FROM Tasks

---- Number 4

GO -- Deadline Did NOT Pass and Wasn't REVIEWED ie. Will be changed
EXEC ChangeTaskStatus 'Regular7', 'Number4Case1', 'Second Project'
GO -- Deadline Did NOT Pass and Was REVIEWED ie. Will NOT be changed
EXEC ChangeTaskStatus 'Regular7', 'Number4Case2', 'Second Project'
GO -- Deadline Passed ie. Will NOT be changed
EXEC ChangeTaskStatus 'Regular7', 'Number4Case3', 'Second Project'

-- SELECT * FROM Tasks

--------$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$----------------

---- “As a manager, I should be able to ...”

---- Number 1
-- GO
-- SELECT * FROM Requests

GO -- HR Manager Views All Request
EXEC ViewNewRequests 'YasmeenHRTestingAmr'


GO -- NOT HR Manager Views All Request except HR Req
EXEC ViewNewRequests 'YasmeenNOTHRTestingAmr'


---- Number 2
GO  -- Manager OutSide of my Department
EXEC ReviewRequest 'ShadiBarghash', '2018-01-01', 'AmrHR', 0, ''

GO  -- Manager InSide my Department and NOT HR Req.
EXEC ReviewRequest 'YasmeenHRTestingAmr', '2018-01-01', 'AmrNOTHrBUTReg', 0, 'BAD Timing'

GO  -- Manager InSide my Department and HR Req.
EXEC ReviewRequest 'YasmeenHRTestingAmr', '2018-01-01', 'AmrHR', 1, ''



---- Number 3

GO
EXEC ViewApplication 'YasmeenHRTestingAmr', 'Manager-Junior Software Engineering Manager'

---- Number 4
GO
EXEC ReviewApplication 'YasmeenHRTestingAmr', 8, 1

GO
EXEC ReviewApplication 'ShadiBarghash', 7, 1


---- Number 5
GO
EXEC CreateNewProject 'YasmeenHRTestingAmr', 'Creating third new Project', '2017/11/15'  , '2017/11/17'


---- Number 6
GO -- Will be added 
EXEC AddEmployeeToProject 'YasmeenHRTestingAmr', 'Creating third new Project', 'Regular7'

GO -- will not be added
EXEC AddEmployeeToProject 'YasmeenHRTestingAmr', 'Second Project', 'Regular7'



---- Number 7
GO -- WILL be removed
EXEC RemoveEmployeeFromProject 'YasmeenHRTestingAmr', 'First Project', 'RegEmpWithNoTasks'

GO -- WILL NOT be removed
EXEC RemoveEmployeeFromProject 'YasmeenHRTestingAmr', 'Second Project', 'Regular7'

-- SELECT * FROM Project_Assignments


---- Number 8
GO
EXEC CreateNewTask 'YasmeenHRTestingAmr', '10th Task', 'The easy task', '2017/12/27' , 'Creating third new Project'


---- Number 9
GO  -- Will be Assigned to the task as he working on the same project of the task
EXEC AssignTask 'YasmeenHRTestingAmr', '10th Task', 'Creating third new Project', 'Regular7'

GO  -- Will NOT be Assigned to the task as he working on the same project of the task
EXEC AssignTask 'YasmeenHRTestingAmr', '10th Task', 'Creating third new Project', 'Regular1'


---- Number 10
GO
EXEC AddEmployeeToProject 'YasmeenHRTestingAmr', 'Creating third new Project', 'Regular8'

GO -- Will be changed
EXEC ChangeTaskEmployee 'YasmeenHRTestingAmr', 'Creating third new Project', '10th Task', 'Regular7', 'Regular8'

GO -- Will NOT be changed
EXEC ChangeTaskEmployee 'YasmeenHRTestingAmr', 'Creating third new Project', '10th Task', 'Regular7', 'Regular5'


---- Number 11
EXEC ViewProjectTasks 'YasmeenHRTestingAmr', 'Creating third new Project', 'Assigned' 


---- Number 12

-- Accepting the Task
GO
EXEC FinishedTask 'Regular8', '10th Task', 'Creating third new Project'
GO
EXEC ReviewTask 'YasmeenHRTestingAmr', 'Creating third new Project', '10th Task', 1, NULL


-- Rejecting the task
GO
EXEC CreateNewTask 'YasmeenHRTestingAmr', '11th Task', 'The easy task', '2017/12/27' , 'Creating third new Project'
GO
EXEC AssignTask 'YasmeenHRTestingAmr', '11th Task', 'Creating third new Project', 'Regular8'
GO
EXEC FinishedTask 'Regular8', '11th Task', 'Creating third new Project'
GO
EXEC ReviewTask 'YasmeenHRTestingAmr', 'Creating third new Project', '11th Task', 0, '2018/01/01'

---- ##### ##### ##### ##### ##### ##### ##### ##### End of Amr's Executions  ##### ##### ##### #####  ##### ##### ##### ##### -----