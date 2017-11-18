USE iWork;

---- ##### ##### ##### ##### ##### ##### ##### #####  Yasmeen Start  ##### ##### ##### #####  ##### ##### ##### ##### -----
--search by company name
GO
create proc searchbyCname
@name varchar(50)
as 
declare @count int
select @count=count(*)
from Companies
where replace(Companies.name,' ','')=replace(@name,' ','')
if(@count=0)
print ('No Companies are found')
else 
select *
from Companies 
where replace(Companies.name,' ','')=replace(@name,' ','' ) --to be able to search without being space sensitive 

select phone
from Company_Phones
where Company_Phones.company=replace(@name,' ','' )+'.com'

--drop proc searchbyCname


--search by addresss
GO
create proc searchbyCaddress
@address varchar(max)
as
select*
from Companies
where address like '%'+@address+'%'


--search by type
GO
create proc searchbyCtype
@type varchar(50)
as 
declare @count int
select @count=count(*)
from Companies
where Companies.type=@type 
if(@count=0)
print ('No Companies are found')
else 
select *
from Companies
where Companies.type=@type 


--####################################################--
--view all companies
GO
create proc viewallcompanies
as
Select *
from Companies



--####################################################--

--view certain company and its departments
GO
create procedure viewcertaincompany
@name varchar(50)
as
select c.*
from Companies c
where c.name=@name
select p.phone
from Company_Phones p
where p.company=replace(@name,' ','')+'.com'
select d.code,d.name 
from Departments d
where d.company=replace(@name,' ','')+'.com' --making sure no white spaces between letters or words

--drop proc viewcertaincompany


--######################################################--

--view departments of comapnies with jobs that have vacancies in it
GO
create proc viewcertaindepartment
@domain varchar(50),@code  varchar(50)
as
select d.*
from Departments d
where d.code=@code and d.company=@domain

select j.*
from Jobs j
where j.company=@domain and  j.department=@code and j.vacancy>0



--###################################################--
--register
GO
create proc register
@username varchar(50)  ,@password varchar(50) ,@email varchar(50)='N/A'  ,@firstname varchar(50) ,@middlename varchar(50)='N/A',@lastname varchar(50) ,@birthdate date ,@yearsofexp int =0 
as
if(exists(select *
          from Users
		  where Users.username=@username))
print 'Username already in use'
else
if(@username is null)
 print 'please fill all starred parts'
else
if (@password is null)
 print 'please fill all starred parts'
else
if(@firstname is null)
 print 'please fill all starred parts'
else if(@lastname is null)
 print 'please fill all starred parts'
 else if(@birthdate is null )
 print 'please fill all starred parts'
else
begin
insert into Users values(@username,@password,@email,@firstname,@middlename,@lastname,@birthdate,@yearsofexp);
insert into Applicants values(@username);
end

--drop proc register

--after registering he will be able to enter his previous jobs or if he is an already registered an wants to add p-jobs
GO
create proc previousjobsentery
@username varchar(50),@pjob varchar(100)
as
if(exists(select *
   from Users
   where Users.username=@username))
 begin
 if (exists( select *
   from User_Previous_Job_Titles
   where User_Previous_Job_Titles.username=@username and User_Previous_Job_Titles.title=@pjob))
   print 'you already entered this job tittle'
   else
   insert into User_Previous_Job_Titles values(@pjob,@username)
   end
--drop proc previousjobsentery

--####################################################################--

--search for jobs that have vacancies in them with string contained in their tittle or short desc
GO
create proc searchforjob
@word varchar(max)
as 
select *
from Jobs
where (title like '%'+@word+'%' or @word like '%'+title+'%' or short_description like '%'+@word+'%' ) and vacancy>0


--#####################################################################--
GO
create proc highestavgsalaries
as
select c.name, avg(salary)
from Companies c
Inner join Staff_Members s on c.domain=s.company
group by c.name
order by avg(s.salary) desc

--drop proc highestavgsalaries


--#####################################################################--
GO
create proc loginweb
@username varchar(50),@password varchar(50)
as
if(exists(select *
        from Users 
		where Users.username=@username
		))
		begin
		if(@password=(select Users.password
		             from Users
					 where Users.username=@username
					 ))
					 begin
					 if(exists(select *
                     from Applicants 
		             where Applicants.username=@username
		             ))
					 print 'Job Seeker'
					 else if(exists(select *
                     from Regular_Employees 
		             where Regular_Employees.username=@username
		             )) 
					 print 'Regular Employee'
					 else if(exists(select *
                     from Hr_Employees 
		             where Hr_Employees.username=@username
		             )) 
					 print 'HR Employee'
					  else if(exists(select *
                     from Managers 
		             where Managers.username=@username
		             ))
					 print 'Manager'
					 end
					 else
					 print 'wrong password'
			end
			else print 'wrong username'


--#########################################################################--

--view all user info
GO
create proc Viewuserinfo
@username varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  select *
		  from Users
		  where Users.username=@username
		  end
else 
print 'Register or log in'
--drop proc Viewuserinfo



--##########################################################################--
-- edit info
GO
create proc editusername
@username varchar(50),@newusername varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  if(exists(select *
          from Users
		  where Users.username=@newusername))
		  print 'username in use'
		  else
		  begin
		  update Users
		  set username=@newusername
		  where Users.username=@username
		  print 'username successfully changed'
		  end
		  end
	else
	print 'Register or login'
--drop proc editusername

GO
create proc edituserpassword
@username varchar(50),@newpassword varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  update Users
		  set password=@newpassword
		  where Users.username=@username
		  print 'password successfully changed'
		  end
	else
	print 'Register or login'


GO
create proc edituseremail
@username varchar(50),@newemail varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  update Users
		  set email=@newemail
		  where Users.username=@username
		  print 'email successfully changed'
		  end
	else
	print 'Register or login'

GO
create proc edituserfn
@username varchar(50),@newfn varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  update Users
		  set first_name=@newfn
		  where Users.username=@username
		  print 'first name successfully changed'
		  end
	else
	print 'Register or login'

GO
create proc editusermn
@username varchar(50),@newmn varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  update Users
		  set middle_name=@newmn
		  where Users.username=@username
		  print 'middle name successfully changed'
		  end
	else
	print 'Register or login'

GO
create proc edituserln
@username varchar(50),@newln varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  update Users
		  set last_name=@newln
		  where Users.username=@username
		  print 'last name successfully changed'
		  end
	else
	print 'Register or login'

GO
create proc edituserbd
@username varchar(50),@newbd varchar(50)
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  update Users
		  set birth_date=@newbd
		  where Users.username=@username
		  print 'Birth date successfully changed'
		  end
	else
	print 'Register or login'

GO
create proc edituseryofe
@username varchar(50),@newyofe int
as
if(exists(select *
          from Users
		  where Users.username=@username))
		  begin
		  update Users
		  set years_of_experience=@newyofe
		  where Users.username=@username
		  print 'years of experience successfully changed'
		  end
	else
	print 'Register or login'

--######################################################################--

--Apply for a job
GO
create proc Applyforjob
@username varchar(50),@jobtitle varchar(50) ,@dep varchar(50),@comp varchar(50),@score int
as 
declare @neededyears int
declare @useryears int
if(exists(select *
          from Applicants
		  where Applicants.username=@username))	 
		  begin
		set @neededyears=  (select j.min_years_of_experience
		  from Jobs j
		  where j.title=@jobtitle and j.department=@dep and j.company=@comp)

		  set @useryears =(select y.years_of_experience
		                   from Users y
						   where y.username=@username)
		 if(@useryears>=@neededyears)
		 begin 
		 if(exists(select a.*
		   from Applications a
		   where @username=a.app_username and @jobtitle=a.job_title and @dep=a.department and @comp=a.company and ((a.hr_status='pending' or a.hr_status='accepted') and a.manager_status='pending')))
		   print 'you already applied for this job and it id in the reviewing process'

		else
		if(exists(select a.*
		   from Applications a
		   where @username=a.app_username and @jobtitle=a.job_title and @dep=a.department and @comp=a.company and a.manager_status='accepted'))
		   print 'you already got accepted int this job'
		 else
		 begin
		 declare @scoreout int
		 -- exex savescore @score ,@scoreout output
        insert into Applications (score,hr_status,manager_status,job_title,department,company,app_username)values(@scoreout,'pending','pending',@jobtitle ,@dep ,@comp,@username);
		 end
		 end
		 end


--view questions
GO
create proc viewquestions
@jobtitle varchar(50),@dep varchar(50),@comp varchar(50)
as 
select c.question
from Job_has_Questions q
inner join Questions c on c.id=q.question
where q.title=@jobtitle and q.department=@dep and q.company=@comp



--save score
GO
create proc savescore --will be used in applyforjob procedure above to provide it with the value of the score 
@score int ,@scoreout int output  /* I see that the creation of an application record should be done after the score is calculated not before it to avoid the existance of application records whose users for 
example clicked apply so the interview questions appeared ,however he closed the website and didnt submit his answers , so a reocrd will be saved when it shouldnt be , therefore the scenario i am doing is that 
when apply is clicked interview questions should appear , then user solves them clicks submit the website calculates the score and calls Apply for job procedure to insert an application record with the score*/
as
set @scoreout=@score

declare @out int
-- exex savescore 12, @out output
print @out
--#################################################################--

--view my job applications status
GO
create proc viewapplicationstatus
@username varchar(50)
as
select a.company,a.department,a.job_title,a.manager_status,a.score
from Applications a
where a.app_username=@username

-- exex viewapplicationstatus 'Maza'
-- exex viewapplicationstatus 'Maza2'


--##################################################################--

--choose a job i got accepted in
GO
create proc chooseajob
@appid int,@username varchar(50),@jobtitle varchar(50), @dep varchar(50),@comp varchar(50),@dayoff varchar(8) 
as
if(exists(select a.* 
          from Applications a
		  where a.id= @appid and a.app_username=@username and a.job_title=@jobtitle and a.department=@dep and a.company=@comp and a.manager_status='accepted'))
		  begin
		  declare @salary decimal
		  set @salary =(select j.salary
		               from Jobs j
					   where j.title=@jobtitle and j.company=@comp and j.department=@dep)
          if(@dayoff ='friday')
		  print 'select a day other than Friday'
		  else
		  begin
		  insert into Staff_Members values(@username,@salary,@dayoff ,30,@jobtitle,@dep, @comp);
		  update Jobs
		  set vacancy=vacancy-1
		  where title=@jobtitle and department=@dep and company=@comp

end
end

-- exex chooseajob 2,'Maza2','Android HR','Android_OS','google.com',sunday

--#######################################################################--
--delete job application
GO
create proc deletejobapp
@id int ,@username varchar(50)
as
if(exists (select a.*
          from Applications a
		  where a.id=@id and a.app_username=@username and a.hr_status='pending'))
		  begin
		  DELETE FROM Applications
		  where id=@id
		  end
else 
print'you can not delete this application'

-- exex deletejobapp 5,'Maza1' --will be deleted ie in pending at hr
-- exex deletejobapp 6,'Maza1' --connot be deleted as it got accepted by hr
--#######################################################################--
--check in proc the takes user name and the current time stamp from website

-- a function to extract the date from date time
GO
create function getthedate
(@timestamp datetime)
returns date
as
begin
declare @date date
set @date= CONVERT(date, @timestamp)
return @date
end

--a function to extract the time from date time
GO
create function getthetime
(@timestamp datetime)
returns time
as
begin
declare @time time
set @time= CONVERT(time, @timestamp)
return @time
end

GO
create proc checkin
@username varchar(50)
as 
if(exists(select s.*
            from Staff_Members s
			where s.username=@username))
begin
declare @timestamp datetime ,@date date,@starttime time ,@day varchar(8)
set @timestamp =CURRENT_TIMESTAMP
set @date =dbo.getthedate(@timestamp)
set @starttime=dbo.getthetime(@timestamp)
set @day=datename(dw,@timestamp)
if(exists(select a.*
            from Attendance_Records a
			where a.attendance_date=@date and a.username=@username))
			print 'you can not check in twice a day'
			else
			if(@day =(select s.day_off
			          from Staff_Members s
					  where s.username=@username))
					  print 'you can not check in on your day off'
			else
			Insert into Attendance_Records(username,attendance_date,time_of_start) values(@username,@date,@starttime)
end
else 
print 'you arenot a staff member'


-- exex checkin 'Adel' --dayoff sunday
-- exex checkin 'AmrMKayid'
--do for all days 



---########################################################--
GO
create proc checkout 
@username varchar(50)
as 
if(exists(select s.*
            from Staff_Members s
			where s.username=@username))
begin
declare @timestamp datetime ,@date date,@leavetime time ,@day varchar(8),@jobhours int ,@durationhour int,@starttime time,@missinghours decimal,@durationminute decimal ,@duration decimal(4,2)
set @timestamp =CURRENT_TIMESTAMP
set @date =dbo.getthedate(@timestamp)
set @leavetime=dbo.getthetime(@timestamp)
set @day=datename(dw,@timestamp)
if(exists(select a.*
            from Attendance_Records a
			where a.attendance_date=@date and a.username=@username and a.time_of_leave is not null))
			print 'you can not check out twice a day'
			else if(@day =(select s.day_off
			          from Staff_Members s
					  where s.username=@username))
					  print 'you can not check out on your day off'
					  else
					  begin
					  set @jobhours=(select j.working_hours
					                 from Staff_Members s
									 inner join Jobs j on j.title=s.job_title and j.department=s.department and j.company=s.company
									 where s.username=@username) --getting the the jobhours of the job the staff is working in
                        set @starttime= (select a.time_of_start
						                 from Attendance_Records a
										 where a.username=@username)
						if(datepart(MINUTE,@leavetime)<datepart(MINUTE,@starttime) )--like start 3:45 and end 4:30
						begin
						set @durationhour=datepart(hour,@leavetime)-1- datepart(hour,@starttime) --4-1-3=0 as he didnt complete a full hour
                        set @durationminute =datepart(MINUTE,@leavetime)+60-datepart(MINUTE,@starttime)
						end
						else
						begin
						set @durationhour=datepart(hour,@leavetime)- datepart(hour,@starttime)--like 3:45 and 4:50 the result here will be 1
						 set @durationminute =datepart(MINUTE,@leavetime)-datepart(MINUTE,@starttime)
						
						end
						set @duration=@durationhour+(@durationminute/60)--will get hours and minutes in terms of hours ex: 15 min will be 0.25 hours
						if(@jobhours-@duration)>0
						set @missinghours=@jobhours-@duration
						else
						set @missinghours=0
						
						update Attendance_Records
						set time_of_leave= @leavetime,duration=@duration,missing_hours=@missinghours
						where username=@username and attendance_date=@date
						end
						end
-- exex checkout 'AmrMKayid'
-- exex checkout  'Adel'
-- exex checkout  'Adel'

-- create function duration
-- (@ duration decimal)
-- returns decimal
-- declare 
-- begin
-- 		  set @jobhours=(select j.working_hours
-- 					                 from Staff_Members s
-- 									 inner join Jobs j on j.title=s.job_title and j.department=s.department and j.company=s.company
-- 									 where s.username=@username) --getting the the jobhours of the job the staff is working in
--                         set @starttime= (select a.time_of_start
-- 						                 from Attendance_Records a
-- 										 where a.username=@username)
-- 						if(datepart(MINUTE,@leavetime)<datepart(MINUTE,@starttime) )--like start 3:45 and end 4:30
-- 						begin
-- 						set @durationhour=datepart(hour,@leavetime)-1- datepart(hour,@starttime) --4-1-3=0 as he didnt complete a full hour
--                         set @durationminute =datepart(MINUTE,@leavetime)+60-datepart(MINUTE,@starttime)
-- 						end
-- 						else
-- 						begin
-- 						set @durationhour=datepart(hour,@leavetime)- datepart(hour,@starttime)--like 3:45 and 4:50 the result here will be 1
-- 						 set @durationminute =datepart(MINUTE,@leavetime)-datepart(MINUTE,@starttime)
						
-- 						end
-- 						set @duration=@durationhour+(@durationminute/60)--will get hours and minutes in terms of hours ex: 15 min will be 0.25 hours
-- end

--##############################################################--
--user checks attendance 

GO
create proc checkmyattendance
@username varchar(50),@startdate date ,@enddate date
as
select * 
from Attendance_Records
where username=@username and attendance_date between @startdate and @enddate 

-- exex checkmyattendance 'Adel' ,'2017/10/18','2017/10/20'

---- ##### ##### ##### ##### ##### ##### ##### #####  Yasmeen END  ##### ##### ##### #####  ##### ##### ##### ##### -----


---- ##### ##### ##### ##### ##### ##### ##### #####  Shadi Start  ##### ##### ##### #####  ##### ##### ##### ##### -----
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
-- Also, I can not apply for a request when it�s applied period overlaps with another request.
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
	IF @username IS NULL
		PRINT 'You have to enter a username.'
	ELSE IF @username NOT IN (SELECT username FROM Staff_Members)
		PRINT 'You have to be working in a company to view the announcements.'
	ELSE IF @days IS NULL
		PRINT 'Please provide the number of days'
	ELSE IF @days < 0
		PRINT 'Sorry, we can''t get the announcements of the future.'
	ELSE
		SELECT * FROM Announcements
		WHERE hr_username IN (SELECT SM2.username FROM Staff_Members SM1 INNER JOIN Staff_Members SM2
								ON SM1.company = SM2.company AND SM1.username = @username)
			AND DATEDIFF(d, date, GETDATE()) <= @days
GO

-- TODO: Test with EXEC, need some Announcements to be put first;
-- at least two, where one is before 20 days and one is today for example.
--EXEC Announcements_of_my_Company 'ShadiBarghash'

-- As an HR Employee, I should be able to ..

-- TODO: [1] Add a new job that belongs to my department,
-- including all the information needed about the job and its interview questions along with their model answers.
-- The title of the added job should contain at the beginning the role that will be assigned to the job seeker if he/she was
-- accepted in this job; for example: �Manager - Junior Sales Manager�.

-- [2] View information about a job in my department.
CREATE PROC View_Job_in_my_Department
@hr_username VARCHAR(50), @job_title VARCHAR(50)
AS
	IF @hr_username IS NULL OR @job_title IS NULL
		PRINT 'You have to provide a valid HR username and a valid job title'
	ELSE IF @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'This is not an HR employee' -- Is this necessary?
	ELSE IF @job_title NOT IN (SELECT Jobs.title FROM Jobs INNER JOIN Staff_Members
								ON Jobs.department = Staff_Members.department AND Jobs.company = Staff_Members.company
								AND Staff_Members.username = @hr_username)
		PRINT 'This job is not offered by your department.'
	ELSE
		SELECT J.* FROM Jobs J INNER JOIN Staff_Members SM
		ON J.department = SM.department AND J.company = SM.company AND SM.username = @hr_username
		WHERE J.title = @job_title
GO

--EXEC View_Job_in_my_Department 'Adel', 'Web Development HR'
--EXEC View_Job_in_my_Department 'Adel', 'Windows App Developer'
--EXEC View_Job_in_my_Department 'Adel', 'Artificial Intelligence Manager'
--EXEC View_Job_in_my_Department NULL, 'Artificial Intelligence Manager'

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
			SET hr_status = @new_status, hr_username = @hr_username, manager_status = 'PENDING'
			WHERE id = @app_id

			PRINT 'HR Status of the Application is updated. Pending Manager''s response.'
		END
	END
GO

-- TODO: Test with EXEC

-- [6] Post announcements related to my company to inform staff members about new updates.
CREATE PROC Post_Announcement
@hr_username VARCHAR(50), @type VARCHAR(50), @title VARCHAR(50), @description VARCHAR(max)
AS
	-- Make sure user is an HR
	IF @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'You have to be an HR Employee to post announcements to your company'
	-- Make sure the HR makes a title for the announcement
	-- Let's say the title can be descriptive so description is not required
	ELSE IF @title IS NULL
		PRINT 'Please put a title for the announcement as a headline.'
	ELSE
		INSERT INTO Announcements VALUES (@title, GETDATE(), @type, @description, @hr_username)
GO

-- TODO: Test with EXEC

-- [7] View requests of staff members working with me in the same department that were approved by a manager only.
CREATE PROC View_Requests_in_my_Department_approved_by_Manager_only
@hr_username VARCHAR(50)
AS SELECT R.*, MR.manager_status, MR.mang_username FROM Requests R INNER JOIN Staff_Members SM ON R.username = SM.username AND R.hr_status = 'PENDING' AND R.manager_status = 'ACCEPTED'
							INNER JOIN Staff_Members HR ON HR.username = @hr_username AND HR.department = SM.department AND HR.company = SM.company
							INNER JOIN Manager_Request_Reviews MR ON MR.username = R.username AND MR.start_date = R.start_date
GO

-- TODO: [8] Accept or reject requests of staff members working with me in the same department that were approved by a manager.
-- My response decides the ?nal status of the request, therefore the annual leaves of the applying staff member should be
-- updated in case the request was accepted.
-- Take into consideration that if the duration of the request includes the staff member�s weekly day-off and/or Friday,
-- they should not be counted as annual leaves.

-- [9] View attendance records of a staff member in my department (check-in time, check-out time, duration, missing hours)
-- within a certain period of time.

CREATE PROC View_Attendance_of_Staff_Member
@staff_username VARCHAR(50), @from DATETIME, @to DATETIME, @hr_username VARCHAR(50)
AS
	IF @hr_username IS NULL OR @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'You have to be an HR employee to check attendance records of other staff members in your department.'
	ELSE IF @staff_username IS NULL
		PRINT 'Please specify the Staff Member you want to check his/her username.'
	ELSE IF @staff_username NOT IN (SELECT SM.username FROM Staff_Members SM INNER JOIN Staff_Members HR
									ON SM.company = HR.company AND SM.department = HR.department
									AND HR.username = @hr_username)
		PRINT 'That username is not a Staff Member in your department.'
	ELSE IF @from IS NULL OR @to IS NULL
		PRINT 'Please provide a date range to get attendance for.'
	ELSE
		SELECT A.* FROM Staff_Members SM INNER JOIN Attendance_Records A
		ON SM.username = @staff_username AND SM.username = A.username
		WHERE A.attendance_date BETWEEN @from AND @to
GO

-- TODO: Test with EXEC, needs some Attendance records

-- TODO: [10] View the total number of hours for any staff member in my department in each month of a certain year.

-- TODO: [11] View names of the top 3 high achievers in my department.
-- A high achiever is a regular employee who stayed the longest hours in the company for a certain month
-- and all tasks assigned to him/her with deadline within this month are fixed.

---- ##### ##### ##### ##### ##### ##### ##### #####  Shadi END  ##### ##### ##### #####  ##### ##### ##### ##### -----


---- ##### ##### ##### ##### ##### ##### ##### #####  Amr Start  ##### ##### ##### #####  ##### ##### ##### ##### -----


-- “As a regular employee, I should be able to ...”

-- View the Assigned Project for a specific employee 
-- by getting them from Project_Assignments and Projects

-- >>>>>> DROP Procedure ChangeTaskStatus
GO
Create Procedure viewMyAssignedProjects
(
@username VARCHAR(50)
)
As
Begin
     SELECT P.*
     FROM Project_Assignments PA, Projects P
     WHERE PA.regular_employee_username = @username AND
           (PA.project_name = P.name AND PA.company = P.company) -- FOREIGN KEY
End

GO
-- EXEC viewMyAssignedProjects 'Regular'

GO
Create Procedure viewMyAssignedTasksInAProject
(
@username VARCHAR(50), @project varchar(50)
)
As
Begin
     SELECT T.*
     FROM Tasks T, Projects P
     WHERE T.regular_employee_username = @username AND
           T.project = P.name AND T.company = P.company  -- FOREIGN KEY
End

GO
-- EXEC viewMyAssignedTasksInAProject 'Regular', 'First Project'

GO
Create Procedure FinishedTask
(
@username VARCHAR(50), @task varchar(50), @project varchar(50)
)
As
Begin
    UPDATE Tasks
    SET [status] = 'Fixed'
    WHERE SYSDATETIME() < deadline 
          AND name = @task 
          AND regular_employee_username = @username
          AND project = @project
End

GO
-- EXEC FinishedTask 'Regular', 'First Task', 'First Project'

GO
Create Procedure ChangeTaskStatus
(
@username VARCHAR(50), @task varchar(50), @project varchar(50)
)
As
Begin
    UPDATE Tasks
    SET [status] = 'Assigned'
    WHERE SYSDATETIME() < deadline 
          AND name = @task 
          AND regular_employee_username = @username
          AND [status] <> 'Closed'
          AND project = @project
End

GO
-- EXEC ChangeTaskStatus 'Regular', 'First Task', 'First Project'

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- “As a manager, I should be able to ...”

GO
Create Procedure ViewNewRequests
(
@manager VARCHAR(50)
)
As
Begin
   SELECT * FROM Requests R
   WHERE EXISTS(SELECT * FROM Managers M, Staff_Members S1
        where M.username = @manager AND S1.username = @manager AND ((M.[type] = 'HR'
        AND EXISTS(
          SELECT * FROM Staff_Members S2, Hr_Employees HR
          WHERE S2.department = S1.department AND R.username = S2.username AND S2.username = HR.username)) 
        OR EXISTS(
        SELECT * FROM Staff_Members S2
        WHERE S2.department = S1.department AND R.username = S2.username)) )
End

GO
Create Procedure ReviewRequest
(
@manager VARCHAR(50), @start_date DATE, @username VARCHAR(50), @isAccepted BIT, @reason VARCHAR(max)
)
As
Begin
   IF(@isAccepted = 1)
   BEGIN
   UPDATE Manager_Request_Reviews
   SET manager_status = 'Accepted'
   WHERE username = @username AND start_date = @start_date AND
        EXISTS(SELECT * FROM Managers M, Staff_Members S1
        where M.username = @manager AND S1.username = @manager
        AND EXISTS(
          SELECT * FROM Staff_Members S2
          WHERE  S2.username = @username AND S2.department = S1.department))
   END
   ELSE
   BEGIN
   UPDATE Manager_Request_Reviews
   SET manager_status = 'Rejected', reason = @reason
   WHERE username = @username AND start_date = @start_date AND
        EXISTS(SELECT * FROM Managers M, Staff_Members S1
        where M.username = @manager AND S1.username = @manager
        AND EXISTS(
                SELECT * FROM Staff_Members S2
                WHERE  S2.username = @username AND S2.department = S1.department))
   END

End


GO
Create Procedure ViewApplication
(
@manager VARCHAR(50), @job_title varchar(50)
)
As
-- IF EXISTS(SELECT * FROM Managers
--         where Managers.username = @manager)
Begin
     SELECT *
     FROM Applications A, Jobs J
     WHERE A.job_title = J.title AND EXISTS (SELECT * FROM Managers M
                                                where M.username = @manager 
                                                AND A.manager_username = M.username 
                                                AND A.department = M.username 
                                                AND A.hr_status = 'Approved')
End


GO
Create Procedure ReviewApplication
(
@manager VARCHAR(50), @id INT, @username VARCHAR(50), @isAccepted BIT
)
As
Begin
   IF(@isAccepted = 1)
   BEGIN
   UPDATE Applications
   SET manager_status = 'Accepted'
   WHERE app_username = @username AND hr_status = 'Approved' AND
        EXISTS(SELECT * FROM Managers M, Staff_Members S1
        where M.username = @manager AND S1.username = @manager
        AND EXISTS(
          SELECT * FROM Staff_Members S2
          WHERE  S2.username = @username AND S2.department = S1.department))
   END
   ELSE
   BEGIN
   UPDATE Applications
   SET manager_status = 'Rejected'
   WHERE app_username = @username AND hr_status = 'Approved' AND
        EXISTS(SELECT * FROM Managers M, Staff_Members S1
        where M.username = @manager AND S1.username = @manager
        AND EXISTS(
          SELECT * FROM Staff_Members S2
          WHERE  S2.username = @username AND S2.department = S1.department))
   END

End

GO
Create Procedure CreateNewProject
(
@manager VARCHAR(50), @name varchar(50), @company VARCHAR(50),
@start_date DATETIME, @end_date DATETIME
)
As
IF EXISTS(SELECT * FROM Managers
        where Managers.username = @manager)
Begin
   INSERT INTO Projects 
   VALUES (@name, @company, @start_date, @end_date , @manager)
End

GO
-- EXEC CreateNewProject 'Eyad3', 'Creating third new Project', 'apple.com', '2017/11/15'  , '2017/11/17'

GO
Create Procedure AddEmployeeToProject
(
@manager VARCHAR(50), @project varchar(50), @company varchar(50), @regular_employee varchar(50)
)
As
IF EXISTS(SELECT * FROM Managers M, Staff_Members S1
        where M.username = @manager AND S1.username = @manager
        AND EXISTS(
          SELECT * FROM Regular_Employees E, Staff_Members S2
          WHERE E.username = @regular_employee AND S2.username = @regular_employee AND S2.department = S1.department
        )
)
IF EXISTS(
  SELECT count(regular_employee_username)
  FROM Tasks
  WHERE regular_employee_username = @regular_employee 
  HAVING count(regular_employee_username) < 2
)
Begin
    INSERT INTO Project_Assignments 
    VALUES(@project, @company, @regular_employee, @manager)
End

-- EXEC AddEmployeeToProject 'Eyad3', 'First Project', 'apple.com', 'Regular2'

-- SELECT * FROM Project_Assignments

GO
Create Procedure RemoveEmployeeFromProject
(
@manager VARCHAR(50), @project varchar(50), @regular_employee varchar(50)
)
As
IF EXISTS(SELECT * FROM Managers
        where Managers.username = @manager)
Begin
    DELETE Project_Assignments
    WHERE project_name = @project 
          AND regular_employee_username = @regular_employee 
          AND @regular_employee NOT IN (
            SELECT regular_employee_username
            FROM Tasks
          )
End

-- EXEC RemoveEmployeeFromProject 'Eyad3', 'First Project', 'Regular2'

GO
Create Procedure CreateAndAssignNewTask
(
@manager VARCHAR(50), @name varchar(50), @description varchar(max), 
@deadline DATETIME, @project varchar(50), @company VARCHAR(50),
@regular_employee_username VARCHAR(50)
)
As
IF EXISTS(SELECT * FROM Managers
        where Managers.username = @manager)
IF EXISTS(SELECT * FROM Project_Assignments
        where Project_Assignments.mananger_username = @manager 
              AND Project_Assignments.project_name = @project
              AND Project_Assignments.regular_employee_username = @regular_employee_username)
Begin
   INSERT INTO Tasks 
   VALUES (@name, @description, 'Open', @deadline , @project, @company, @regular_employee_username , @manager)
End

-- EXEC CreateAndAssignNewTask 'Eyad3', '5th Task by Proc', 'The easy task', '2017/11/17' , 'First Project', 'apple.com', 'Regular'

-- SELECT * FROM Tasks

GO
Create Procedure ChangeTaskEmployee
(
@manager VARCHAR(50), @project varchar(50), @task varchar(50),
@regular_employee varchar(50), @regular_employee_replacing varchar(50)
)
As
IF EXISTS(SELECT * FROM Managers
        where Managers.username = @manager)
Begin
    UPDATE Tasks
    SET regular_employee_username = @regular_employee_replacing
    WHERE name = @task 
          AND regular_employee_username = @regular_employee 
          AND [status] = 'Assigned'
End

-- EXEC ChangeTaskEmployee 'Eyad3', 'First Project', 'Assigned Task', 'Regular2', 'Regular'

GO
Create Procedure ViewProjectTasks
(
@manager VARCHAR(50), @project varchar(50), @status varchar(50)
)
As
IF EXISTS(SELECT * FROM Managers
        where Managers.username = @manager)
Begin
     SELECT *
     FROM Tasks
     WHERE mananger_username = @manager AND
           project = @project AND
           [status] = @status
End

-- EXEC ViewProjectTasks 'Eyad3', 'First Project', 'Pending' 

GO
Create Procedure ReviewTask
(
@manager VARCHAR(50), @project varchar(50), @task varchar(50),
@isAccepted varchar(50),  @newDeadline DATETIME
)
As
Begin
   IF(@isAccepted = 1)
   BEGIN
   UPDATE Tasks
   SET status = 'Closed'
   WHERE mananger_username = @manager 
        AND project = @project 
        AND name = @task
   END
   ELSE
   BEGIN
   UPDATE Tasks
   SET status = 'Assigned', deadline = @newDeadline
   WHERE mananger_username = @manager 
        AND project = @project 
        AND name = @task
   END

End
---- ##### ##### ##### ##### ##### ##### ##### #####  Amr END  ##### ##### ##### #####  ##### ##### ##### ##### -----