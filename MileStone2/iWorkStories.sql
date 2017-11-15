USE iWork

-- As a staff member, I should be able to ..

-- [4]
-- Apply for requests of both types: leave requests or business trip requests,
-- by supplying all the needed information for the request.
-- As a staff member, I can not apply for a leave if I exceeded the number of annual leaves allowed.
-- If I am a manager applying for a request, the request does not need to be approved, but it only needs to be kept track of.
-- Also, I can not apply for a request when it’s applied period overlaps with another request.

GO

-- Apply_for_Request_CHECKS :
-- Checks and validates the parameters needed to make a data entry in any of the request tables.
-- However, this does not create a new entry. It returns two outputs:
-- @valid BIT OUTPUT: Indicates whether the input is valid according to this Procedures
-- @staff_category VARCHAR(10) OUTPUT: Returns 'HR', 'Mang' or 'RegE' to indicate the category of staff members.
-- REMARK: The requesting StaffMember and the replacing one must be one and the same one of these.
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

	-- Check that replacing username is not the same as the requesting username
	IF @staff_username = @username_replacing BEGIN
		SET @valid = 0
		PRINT 'The staff member replacing you in your leave has to be someone else. You will find someone.'
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

GO

-- The actual procedure for applying for a leave request
CREATE PROC Apply_for_Leave_Request
@staff_username VARCHAR(50), @username_replacing VARCHAR(50), @start_date DATE, @end_date DATE, @leave_type VARCHAR(50)
AS BEGIN

	DECLARE @valid BIT
	DECLARE @staff_category VARCHAR(10)

	SET @valid = 1
	SET @staff_category = NULL

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

GO

-- The actual procedure for applying for a business trip request
CREATE PROC Apply_for_Business_Trip
@staff_username VARCHAR(50), @username_replacing VARCHAR(50), @start_date DATE, @end_date DATE, @destination VARCHAR(50), @purpose VARCHAR(50)
AS BEGIN

	DECLARE @valid BIT
	DECLARE @staff_category VARCHAR(10)

	SET @valid = 1
	SET @staff_category = NULL

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

GO

-- [5]
-- View the status of all requests I applied for before (HR employee and manager responses)
CREATE PROCEDURE Show_my_Requests
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

GO

-- [6]
-- Delete any request I applied for as long as it is still in the review process.
CREATE PROC Delete_my_Pending_Requests
@username VARCHAR(50)
AS BEGIN

-- TODO: Get the start_dates of the requests by this username, where hr_status or manager_status is 'PENDING'
SELECT start_date
FROM Requests
WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING')

DELETE FROM Manager_Request_Reviews
WHERE username = @username AND manager_status = 'PENDING'

DELETE FROM Request_Hr_Replace
WHERE username = @username AND start_date IN (
	SELECT start_date FROM Requests
	WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING'))

DELETE FROM Request_Manager_Replace
WHERE username = @username AND start_date IN (
	SELECT start_date FROM Requests
	WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING'))

DELETE FROM Request_Regular_Employee_Replace
WHERE username = @username AND start_date IN (
	SELECT start_date FROM Requests
	WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING'))

DELETE FROM Leave_Requests
WHERE username = @username AND start_date IN (
	SELECT start_date FROM Requests
	WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING'))

DELETE FROM Business_Trips
WHERE username = @username AND start_date IN (
	SELECT start_date FROM Requests
	WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING'))

DELETE FROM Requests
WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING')

END

GO