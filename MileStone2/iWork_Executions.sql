GO
USE iWork;
--search by company name
go
exec searchbyCname 'go Ogle' --exists
go
exec searchbyCname 'k'       --doesnt exist


--search by addresss
go
exec searchbyCaddress 'seattle'
go
exec searchbyCaddress 'california'


--search by type
go
exec searchbyCtype 'National'
go
exec searchbyCtype 'International'

--#############################################################--

--view all companies
go
exec viewallcompanies

--############################################################--
--view certain company and its departments
go
exec viewcertaincompany 'google.com'

--###########################################################--

--view departments of comapnies with jobs that have vacancies in it
go
exec viewcertaindepartment 'google.com','Android_OS'

--#########################################################--

--registering and entering previous job entries after he register
go
exec register @username='balabizo',@password='5679',@birthdate='1998/07/10',@firstname='sameh',@lastname='wagih'--to test it sets default values
go
exec register @username='balabizo',@password='5679',@birthdate='1998/07/10',@firstname='sameh',@lastname='wagih' --prints username already in use 
go
exec previousjobsentery @pjob='software engineer at ibm',@username='balabizo' --enters a record for a perivious job tittle of balabizo
go
exec previousjobsentery @pjob='software engineer at ibm',@username='balabizo' --prints you already entered this job tittle
go
exec previousjobsentery @pjob='ceo of ggg',@username='balabizo' --enters a record for a perivious job tittle of balabizo

--#########################################################--

--search for jobs that have vacancies in them with string contained in their tittle or short desc
go
exec searchforjob 'hr'
go
exec searchforjob 'software'
--new insertions for vacancy 0 and short description

--#########################################################--
go
exec highestavgsalaries

--#########################################################--
--login
go
exec loginweb 'AmrMKayid','Hello, World!' --registed manager
go
exec loginweb 'AmrMKayid25','Hello, World!'--wrong username
go
exec loginweb 'AmrMKayid','Hello, World!25'--correct user name wrong password
go
exec loginweb 'Maza','Hello, World*' --registered job seeker
go
exec loginweb 'Adel','Hello, World0'--registered hr

--add an execution for regular employees

--#########################################################--
--view all user info
go
exec Viewuserinfo 'Adel'
go
exec Viewuserinfo 'Sabry'
go
exec Viewuserinfo null --register or login message

--#########################################################--
--user info editing
go
exec editusername 'editingtrial','Adel' --Adel is the name of another registered user so username in use will be displayed
go
exec editusername 'editingtrial','crazy'--successfully changed
go
exec edituserpassword 'crazy','heyyou'
go
exec edituseremail 'crazy','crazy@yahoo.com'
go
exec edituserfn 'crazy','crazy'
go
exec editusermn 'crazy','crazy'
go
exec edituserln 'crazy','crazy'
go
exec edituserbd 'crazy','1968/8/8'
go
exec edituseryofe 'crazy',25 --years of experience

--##########################################################--
--Apply for job
go
exec Applyforjob 'Maza','Hr-Android HR','Android_OS','google.com',30 --first time to apply for a job
go
exec Applyforjob 'Maza','Hr-Android HR','Android_OS','google.com',30 --still in reviewing process
go
exec Applyforjob 'Maza2','Hr-Android HR','Android_OS','google.com',90 --already applied before and got accepted

--save score

--questions 
--##########################################################--
--view my job applications status
go
exec viewapplicationstatus 'Maza'
go
exec viewapplicationstatus 'Maza2'

--##########################################################--
--choose a job i got accepted in
go
exec chooseajob 2,'Maza2','Hr-Android HR','Android_OS','google.com',sunday

--##########################################################--
--delete job application
go
exec deletejobapp 5,'Maza1' --will be deleted ie in pending at hr
go
exec deletejobapp 6,'Maza1' -- accepted by hr but manager pending

--###########################################################--
--check in proc the takes user name and the current time stamp from website
go
exec checkin 'Adel' --dayoff sunday
go
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
go
exec checkout  'Adel'
go
exec checkout  'Adel'



--###########################################################--
--user checks attendance 
go
exec checkmyattendance 'Adel' ,'2017/10/18','2017/10/20'

--###########################################################--
--##############################################################yasmeen's end######################################################--


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
EXEC ViewApplication 'YasmeenHRTestingAmr', 'Manager-Software Engineering Manager'

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