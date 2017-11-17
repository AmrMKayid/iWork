USE iWork
GO

-------- EXTRA PROCEDURES USED BY OUR PROCEDURES -------- Ended by "-- END OF EXTRA PROCEDURES --"

-- Apply_for_Request_CHECKS :
-- Checks and validates the parameters needed to make a data entry in any of the request tables.
-- However, this does not create a new entry. It just returns two outputs:
-- @valid BIT OUTPUT: Indicates whether the input is valid according to this Procedures
-- @staff_category VARCHAR(10) OUTPUT: Returns 'HR', 'Mang' or 'RegE' to indicate the category of (both) staff members.
CREATE PROC Apply_for_Request_CHECKS
@staff_username VARCHAR(50), @username_replacing VARCHAR(50), @start_date DATE, @end_date DATE, @valid BIT OUTPUT, @staff_category VARCHAR(10) OUTPUT
AS BEGIN

	SET @valid = 1
	SET @staff_category = NULL

	-- Check that end_date is after start date
	IF @end_date < @start_date BEGIN
		SET @valid = 0
		PRINT 'Please check the start and end dates.'
		--------     [ 7aga zayy break;	aw return; ] ?
	END

	-- Check that replacing username is not the same as the requesting username, and he's in the same department -- company
	IF @staff_username = @username_replacing OR @username_replacing IN (
		SELECT S2.username FROM Staff_Members S1 INNER JOIN Staff_Members S2
		ON S1.username = @staff_username AND S1.company = S2.company AND S1.department = S2.department)
	BEGIN
		SET @valid = 0
		PRINT 'The staff member replacing you in your leave has to be someone else in the same department. You will find someone. :)'
	END
	ELSE BEGIN

		-- Check that they are both Regular Employees, both Managers or both HR Employees,
		-- Type of A is T -> Type of B is T
		-- and Get that type to use it later
		IF @staff_username IN (SELECT username FROM Hr_Employees) AND @username_replacing IN (SELECT username FROM Hr_Employees)
			SET @staff_category = 'HR'
		ELSE IF @staff_username IN (SELECT username FROM Managers) AND @username_replacing IN (SELECT username FROM Managers)
			SET @staff_category = 'Mang'
		ELSE IF @staff_username IN (SELECT username FROM Regular_Employees) AND @username_replacing IN (SELECT username FROM Regular_Employees)
			SET @staff_category = 'RegE'

		IF @staff_category IS NULL BEGIN
			SET @valid = 0
			PRINT 'The requesting and the replacing staff members must be both HR Employees, Regular Employees or Managers.'
		END
		ELSE BEGIN

			-- Check the number of annual leaves left for the requesting staff member
			DECLARE @annual_leaves INT
			SET @annual_leaves = NULL

			SELECT @annual_leaves = annual_leaves
			FROM Staff_Members
			WHERE username = @staff_username

			IF @annual_leaves = 0 BEGIN
				SET @valid = 0
				PRINT 'Sorry, you exceeded your allowed number of allowed leaves.'
			END

			-- Check that the new request is not overlaping with a request I applied or the replacing Staff Member applied for.
			IF EXISTS (SELECT * FROM Requests WHERE ((username = @staff_username OR username = @username_replacing) AND
									((start_date BETWEEN @start_date AND @end_date)
									OR (end_date BETWEEN @start_date and @end_date)))) BEGIN
				SET @valid = 0
				PRINT 'You or the staff member you chose replace you is having a request in that date range.'
			END

		END
	END
END
GO

-- GET the request I have created that are in the review process. Used for deletion.
CREATE FUNCTION Get_my_Pending_Requests (@username VARCHAR(50)) RETURNS TABLE
AS RETURN
	SELECT * FROM Requests WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING')
GO
-------- END OF EXTRA PROCEDURES --------


-- As a staff member, I should be able to ..

-- [4]
-- Apply for requests of both types: leave requests or business trip requests,
-- by supplying all the needed information for the request.
-- As a staff member, I can not apply for a leave if I exceeded the number of annual leaves allowed.
-- If I am a manager applying for a request, the request does not need to be approved, but it only needs to be kept track of.
-- Also, I can not apply for a request when it’s applied period overlaps with another request.
CREATE PROC Apply_for_Leave_Request
@staff_username VARCHAR(50), @username_replacing VARCHAR(50), @start_date DATE, @end_date DATE, @leave_type VARCHAR(50)
AS BEGIN

	DECLARE @valid BIT
	DECLARE @staff_category VARCHAR(10)

	EXEC Apply_for_Request_CHECKS @staff_username, @username_replacing, @start_date, @end_date,
		@valid OUTPUT, @staff_category OUTPUT

	-- Check that leave_type is one of ('sick', 'accidental', 'annual')
	IF @leave_type NOT IN ('sick', 'accidental', 'annual') BEGIN
		SET @valid = 0
		PRINT 'Leave requests are either "sick", "accidental" or "annual" leaves.'
	END

	IF @valid = 1 BEGIN

		INSERT INTO Requests (start_date, end_date, request_date, username)
		VALUES (@start_date, @end_date, GETDATE(), @staff_username)

		INSERT INTO Leave_Requests VALUES (@start_date, @staff_username, @leave_type)

		IF @staff_category = 'HR'
			INSERT INTO Request_Hr_Replace VALUES (@start_date, @staff_username, @username_replacing)
		ELSE IF @staff_category = 'Mang'
			INSERT INTO Request_Manager_Replace VALUES (@start_date, @staff_username, @username_replacing)
		ELSE IF @staff_category = 'RegE'
			INSERT INTO Request_Regular_Employee_Replace VALUES (@start_date, @staff_username, @username_replacing)

		PRINT 'Leave Request added'

	END
END
GO

CREATE PROC Apply_for_Business_Trip
@staff_username VARCHAR(50), @username_replacing VARCHAR(50), @start_date DATE, @end_date DATE, @destination VARCHAR(50), @purpose VARCHAR(50)
AS BEGIN

	DECLARE @valid BIT
	DECLARE @staff_category VARCHAR(10)

	EXEC Apply_for_Request_CHECKS @staff_username, @username_replacing, @start_date, @end_date,
		@valid OUTPUT, @staff_category OUTPUT

	IF @valid = 1 BEGIN

		INSERT INTO Requests (start_date, end_date, request_date, username)
		VALUES (@start_date, @end_date, GETDATE(), @staff_username)

		INSERT INTO Business_Trips VALUES (@start_date, @staff_username, @destination, @purpose)

		IF @staff_category = 'HR'
			INSERT INTO Request_Hr_Replace VALUES (@start_date, @staff_username, @username_replacing)
		ELSE IF @staff_category = 'Mang'
			INSERT INTO Request_Manager_Replace VALUES (@start_date, @staff_username, @username_replacing)
		ELSE IF @staff_category = 'RegE'
			INSERT INTO Request_Regular_Employee_Replace VALUES (@start_date, @staff_username, @username_replacing)

		PRINT 'Business Trip Request added'

	END
END
GO

--EXEC Apply_for_Leave_Request 'AmrMKayid', 'YasmeenKhaled', '2017-12-11', '2017-12-01', 'annual'
--EXEC Apply_for_Leave_Request 'AmrMKayid', 'AmrMKayid', '2017-12-11', '2017-12-01', 'annual'
--EXEC Apply_for_Leave_Request 'AmrMKayid', 'Amr', '2017-12-01', '2017-12-11', 'annual'
--EXEC Apply_for_Leave_Request 'AmrMKayid', 'YasmeenKhaled', '2017-12-01', '2017-12-11', 'salamo3aleikoo'
--EXEC Apply_for_Leave_Request 'AmrMKayid', 'ShadiBarghash', '2017-12-12', '2017-12-12', 'annual'

--EXEC Apply_for_Business_Trip 'ShadiBarghash', 'AmrMKayid', '2017-12-27', '2017-01-10', 'Athens, Greece', 'MDC'
--EXEC Apply_for_Business_Trip 'ShadiBarghash', 'AmrMKayid', '2017-12-27', '2018-01-10', 'Athens, Greece', 'MDC'

--EXEC Apply_for_Business_Trip 'ShadiBarghash', 'YasmeenKhaled', '2018-06-01', '2018-07-01', 'Seattle, WA, USA', 'Imagine Cup 2016'
--EXEC Apply_for_Leave_Request'YasmeenKhaled', 'ShadiBarghash', '2018-06-29', '2018-07-10', 'annual'

-- [5] View the status of all requests I applied for before (HR employee and manager responses)
CREATE PROC Show_my_Requests
@username VARCHAR(50)
AS
	SELECT R.start_date, end_date, request_date, R.manager_status, MR.reason, MR.mang_username, hr_status, hr_username
	FROM Requests R LEFT OUTER JOIN Manager_Request_Reviews MR
	ON R.start_date = MR.start_date AND R.username = MR.username
	WHERE R.username = @username
GO

--EXEC Show_my_Requests 'ShadiBarghash'
--EXEC Show_my_Requests 'YasmeenKhaled'
--EXEC Show_my_Requests 'AmrMKayid'

-- [6] Delete any request I applied for as long as it is still in the review process.
CREATE PROC Delete_my_Pending_Requests
@username VARCHAR(50)
AS BEGIN

	-- If a Manager review was added, remove it
	DELETE FROM Manager_Request_Reviews
	WHERE username = @username

	-- Remove the staff replace entry
	DELETE FROM Request_Hr_Replace
	WHERE username = @username AND start_date IN (SELECT start_date FROM dbo.Get_my_Pending_Requests(@username))

	DELETE FROM Request_Manager_Replace
	WHERE username = @username AND start_date IN (SELECT start_date FROM dbo.Get_my_Pending_Requests(@username))

	DELETE FROM Request_Regular_Employee_Replace
	WHERE username = @username AND start_date IN (SELECT start_date FROM dbo.Get_my_Pending_Requests(@username))

	-- Delete from Leave requests and from Business Trips (it should be in one of them only)
	DELETE FROM Leave_Requests
	WHERE username = @username AND start_date IN (SELECT start_date FROM dbo.Get_my_Pending_Requests(@username))

	DELETE FROM Business_Trips
	WHERE username = @username AND start_date IN (SELECT start_date FROM dbo.Get_my_Pending_Requests(@username))

	-- Finally, delete the request entirely
	DELETE FROM Requests
	WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING')

END
GO

-- EXEC Delete_my_Pending_Requests 'ShadiABarghash'

--  TODO: [7] Send emails to staff members in my company.

-- @email_id: IF provided, it just sends that existing email.
--			  IF NULL, it creates a new Email message with provided @subject and @body and sends it
--CREATE PROC Send_Email
--@sender VARCHAR(50), @recipient VARCHAR(50), @subject VARCHAR(50), @body VARCHAR(max), @email_id INT = NULL
--AS BEGIN
--	IF @recipient IN (SELECT S2.username FROM Staff_Members S1 INNER JOIN Staff_Members S2
--						ON S1.username = @sender AND S1.company = S2.company) BEGIN
--		IF @email_id IS NULL BEGIN
--			INSERT INTO Emails VALUES (@subject, @body)
			
--		END
--	END
--END
--GO

-- [8] View emails sent to me by other staff members of my company.
CREATE PROC View_my_inbox_Emails
@username VARCHAR(50)
AS SELECT time_stamp, sender_username, subject, body
	FROM Emails INNER JOIN Staff_send_Email SEND
	ON Emails.id = SEND.email_id AND SEND.receiver_username = @username
	WHERE Send.sender_username IN (SELECT SM2.username FROM Staff_Members SM1 INNER JOIN Staff_Members SM2
									ON SM1.company = SM2.company AND SM1.username = @username)
	ORDER BY Emails.time_stamp DESC
GO

-- TODO: Test with EXEC after testing [7]

-- [9] TODO: Reply to an email sent to me, while the reply would be saved in the database as a new email record.
--CREATE PROC Reply_to_Email
--@email_id INT

-- [10] View announcements related to my company within the past 20 days.
CREATE PROC Announcements_of_my_Company
@username VARCHAR(50), @days INT = 20
AS
	IF @days < 0
		PRINT 'Sorry, we can''t get the announcements of the future.'
	ELSE IF @username IS NULL
		PRINT 'You have to enter a username.'
	ELSE IF @username NOT IN (SELECT username FROM Staff_Members)
		PRINT 'You have to be working in a company to view the announcements.'
	ELSE BEGIN
		SELECT * FROM Announcements
		WHERE hr_username IN (SELECT SM2.username FROM Staff_Members SM1 INNER JOIN Staff_Members SM2
								ON SM1.company = SM2.company AND SM1.username = @username)
			AND DATEDIFF(d, date, GETDATE()) <= @days
	END
GO

-- TODO: Test with EXEC, need some Announcements to be put first;
-- at least two, where one is before 20 days and one is today for example.
--EXEC Announcements_of_my_Company 'ShadiBarghash'

-- As an HR Employee, I should be able to ..

-- TODO: [1] Add a new job that belongs to my department,
-- including all the information needed about the job and its interview questions along with their model answers.
-- The title of the added job should contain at the beginning the role that will be assigned to the job seeker if he/she was
-- accepted in this job; for example: “Manager - Junior Sales Manager”.

-- TODO: [2] View information about a job in my department.
--CREATE PROC View_Job
--@job_title VARCHAR(50), @department VARCHAR(50), @company VARCHAR(50)

-- TODO: [3] Edit the information of a job in my department.

-- [4] View new applications for a speci?c job in my department.
-- For each application, I should be able to check information about the job seeker, job & the score s/he got while applying.
CREATE PROC View_new_Applications_for_Job_title_in_my_Department
@hr_username VARCHAR(50), @job_title VARCHAR(50)
AS
	-- Make sure username is an HR employee
	IF @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'Sorry, you have to be an HR employee to check the new Job Applications in the department.'
	-- Make sure job title is offered by his/her department
	ELSE IF @job_title NOT IN (SELECT title FROM Jobs J WHERE EXISTS (SELECT * FROM Staff_Members S WHERE username = @hr_username
																AND S.company = J.company AND S.department = J.department))
		PRINT 'That job title is not offered in your department.'
	-- Then, just get the needed info where HR status is PENDING and job title is the one I'm looking for
	ELSE
		SELECT J.*, A.id, A.score, JS.username, JS.first_name, JS.middle_name, JS.last_name, JS.email, JS.age, JS.birth_date, JS.years_of_experience
		FROM Jobs J INNER JOIN Applications A ON A.job_title = J.title AND A.department = J.department AND A.company = J.company
					INNER JOIN Users JS ON A.app_username = JS.username
		WHERE A.job_title = @job_title AND A.hr_status = 'PENDING' AND EXISTS (SELECT * FROM Staff_Members S WHERE
						S.username = @hr_username AND S.company = J.company AND S.department = J.department)
GO

-- TODO: Test with some EXEC, needs some fresh Applications

-- [5] Accept or reject applications for jobs in my department.
-- @accept: 'TRUE' or 1 for ACCEPT. 'FALSE' or 0 for REJECT.
CREATE PROC Respond_to_Job_Application_in_my_Department
@hr_username VARCHAR(50), @app_id INT, @accept BIT
AS
	-- Make sure username is an HR employee
	IF @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'Sorry, you have to be an HR employee to respond to the new Job Applications in the department.'
	-- Check that the Job Appplication exist
	ELSE IF @app_id NOT IN (SELECT id FROM Applications)
		PRINT 'There is no Job Application made with this Id'
	-- Check that the id referenced by @app_id is for a Job in the department that @hr_username works in
	ELSE IF NOT EXISTS (SELECT * FROM Staff_Members SM INNER JOIN Applications A
					ON SM.department = A.department AND SM.company = A.company
						AND SM.username = @hr_username AND A.id = @app_id)
		PRINT 'The Application you are trying to review is not in your Department'
	ELSE BEGIN
		DECLARE @new_status VARCHAR(50)
		IF @accept = 1
			SET @new_status = 'ACCEPTED'
		ELSE IF @accept = 0
			SET @new_status = 'REJECTED'
		ELSE
			PRINT 'Application not changed'

		IF @new_status IS NOT NULL BEGIN
			UPDATE Applications
			SET hr_status = @new_status, hr_username = @hr_username
			WHERE id = @app_id

			PRINT 'HR Status of the Application is updated.'
		END
	END

-- TODO: Test with EXEC