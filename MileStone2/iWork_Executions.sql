USE iWork;

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
EXEC Create_Email 'Finished my part', 'I''ve just finished my part from Windows-iOS P2P comm.', @email1_id OUT
EXEC Send_Email_in_Company 'shadi.barghash', 'nesrine.anwarr', @email1_id
EXEC Send_Email_in_Company 'shadi.barghash', 'danial.ashraf', @email1_id

DECLARE @email2_id INT
EXEC Create_Email 'Finished my part, too', 'I''ve just finished my part from Windows-iOS P2P comm.', @email2_id OUT
EXEC Send_Email_in_Company 'danial.ashraf', 'nesrine.anwarr', @email2_id

DECLARE @email3_id INT
EXEC Create_Email 'Summer Vacation', 'Please approve the leave request for my annual summer vacation.', @email3_id OUT
EXEC Send_Email_in_Company 'shadi.barghash', 'nourAli', @email3_id

DECLARE @email4_id INT
EXEC Create_Email 'Shadi requested Vacation', 'Shadi asked me to accept his summer vacation.', @email4_id OUT
EXEC Send_Email_in_Company 'nourAli', 'nesrine.anwarr', @email4_id

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

-- [HELPER] Get unchanged data from old job
DECLARE @short_desc VARCHAR(100)
DECLARE @detail_desc VARCHAR(max)
DECLARE @deadline DATETIME

SELECT @short_desc = short_description, @detail_desc = detailed_description, @deadline = deadline FROM Jobs
WHERE title = 'Regular Employee - Android Programmer' AND company = 'runtastic.com' AND department = 'AppDev'

-- >>> Edit the job, with some new data and some copied from the original entry. In the end, the whole job is updated.
EXEC Edit_Job_in_Department 'nourAli', 'Regular Employee - Android Programmer', @short_desc, @detail_desc,
							4, 6, 4000, @deadline, 1

-- [4] View new applications for a specific job in my department.
EXEC View_new_Applications_for_Job_in_Department 'shadwa-barghash', 'HR Employee - Motivation'

-- [5] Accept or reject applications for jobs in my department.
EXEC Respond_to_Job_Application_HR 'shadwa-barghash', 9, 'TRUE' -- TODO: Make sure it is the correct ID
EXEC Respond_to_Job_Application_HR 'shadwa-barghash', 10, 'FALSE' -- TODO: Make sure it is the correct ID

-- [6] Post announcements related to my company to inform staff members about new updates.
EXEC Post_Announcement 'shadwa-barghash', 'Employee Birthday', 'Surprise birthday', 'As you all know, Shadi is my twin brother, and one of the best programmers in Runtastic, so we want to make him a surprise birthday party. Please join, he''s Gemini and he''ll like it.'

-- [7] View requests of staff members working with me in the same department that were approved by a manager only.
EXEC View_Requests_approved_by_Manager_only 'nourAli'

-- [8] Accept or reject requests of staff members working with me in the same department that were approved by a manager.
EXEC Respond_to_Request_HR 'nourAli', '2018-01-01', 'danial.ashraf', 'TRUE'
EXEC Respond_to_Request_HR 'nourAli', '2018-01-20', 'shadi.barghash', 'FALSE'

-- [9] View attendance records of a staff member in my department
EXEC View_Attendance_of_Staff_Member 'Regular1', '2017-11-22', '2017-11-24', 'Ahmed'

---- ##### ##### ##### ##### ##### ##### ##### #####  Amr Start  ##### ##### ##### #####  ##### ##### ##### ##### -----

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
GO
SELECT * FROM Requests

GO -- HR Manager Views All Request
EXEC ViewNewRequests 'YasmeenHRTestingAmr'


GO -- NOT HR Manager Views All Request except HR Req
EXEC ViewNewRequests 'YasmeenNOTHRTestingAmr'


---- Number 2
GO  -- Manager OutSide of my Department
EXEC ReviewRequest 'ShadiBarghash', '2018-01-01', 'AmrHR', 0, ''

GO  -- Manager InSide my Department and NOT HR Req.
EXEC ReviewRequest 'YasmeenHRTestingAmr', '2018-01-01', 'AmrNOTHrBUTReg', 0, 'BAD Timing'

GO  -- Manager InSide my Department and NOT HR Req.
EXEC ReviewRequest 'YasmeenHRTestingAmr', '2018-01-01', 'AmrHR', 1, ''



---- Number 3

GO
EXEC ViewApplication 'YasmeenHRTestingAmr', 'Software Engineering Manager'

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
EXEC RemoveEmployeeFromProject 'YasmeenHRTestingAmr', 'First Project', 'Regular7'

-- SELECT * FROM Project_Assignments


GO
EXEC CreateNewTask 'YasmeenHRTestingAmr', '10th Task', 'The easy task', '2017/11/27' , 'Creating third new Project'
-- SELECT * FROM Tasks
-- SELECT * FROM Project_Assignments