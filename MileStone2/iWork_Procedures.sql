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
		   print 'you already applied for this job and it is in the reviewing process'

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


-- As a staff member, I should be able to ..

-- [4]
-- Apply for requests of both types: leave requests or business trip requests,
-- by supplying all the needed information for the request.
-- As a staff member, I can not apply for a leave if I exceeded the number of annual leaves allowed.
-- If I am a manager applying for a request, the request does not need to be approved, but it only needs to be kept track of.
-- Also, I can not apply for a request when it�s applied period overlaps with another request.

-- [HELPER] Apply_for_Request_CHECKS :
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

	-- TODO: (extra) Check that the start_date is later than today (request_date)

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

-- >>> Apply for a "Leave" Request for a certain Staff Member
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

	END
END
GO

-- >>> Apply for a "Business Trip" Request for a certain Staff Member
CREATE PROC Apply_for_Business_Trip
@staff_username VARCHAR(50), @username_replacing VARCHAR(50), @start_date DATE, @end_date DATE, @destination VARCHAR(50), @purpose VARCHAR(50)
AS BEGIN

	DECLARE @valid BIT
	DECLARE @staff_category VARCHAR(10)

	EXEC Apply_for_Request_CHECKS @staff_username, @username_replacing, @start_date, @end_date, @valid OUT, @staff_category OUT

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

-- [HELPER] GET the requests I have created that are in the review process. Used for deletion.
CREATE FUNCTION Get_my_Pending_Requests (@username VARCHAR(50)) RETURNS TABLE
AS RETURN
	SELECT * FROM Requests WHERE username = @username AND (hr_status = 'PENDING' OR manager_status = 'PENDING')
GO

 -- >>> Delete all the requests I have applied for and are currently in the review process
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

--  [7] Send emails to staff members in my company.

-- A procedure that creates an Email record, that can be a reply to another Email or not, and returns it's ID
CREATE PROC Create_Email
@subject VARCHAR(50), @body VARCHAR(max), @id INT OUT, @reply_to INT = NULL
AS
	-- Trying to avoid spam, prevent NULL or empty strings
	IF @subject IS NULL OR @subject = ''
		PRINT 'Please give a subject to your email.'
	ELSE IF @body IS NULL OR @body = ''
		PRINT 'Please write the body of your email.'
	ELSE IF @reply_to IS NOT NULL AND @reply_to NOT IN (SELECT id FROM Emails)
		PRINT 'The base email does not exist.'
	ELSE BEGIN
		INSERT INTO Emails VALUES (@subject, @body, @reply_to)

		SET @id = SCOPE_IDENTITY()
	END
GO

-- A procedure that sends an Email to someone
CREATE PROC Send_Email_in_Company
@sender VARCHAR(50), @receiver VARCHAR(50), @email_id INT
AS
	IF @email_id IS NULL
		PRINT 'This procedures must take as input the id of the email to be sent. Use ''Create_Email'' to create an Email and gets its ID.'
	ELSE IF @sender IS NULL OR @sender NOT IN (SELECT username FROM Staff_Members)
		PRINT 'A staff member must send the email'
	ELSE IF @receiver IS NULL
		PRINT 'You must send the Email to someone.'
	ELSE IF @receiver NOT IN (SELECT Sr.username FROM Staff_Members Ss INNER JOIN Staff_Members Sr
								ON Ss.username = @sender AND Ss.company = Sr.company)
		PRINT 'You can only send to a Staff Member in your company.'
	ELSE
		INSERT INTO Staff_send_Email VALUES (@email_id, @receiver, @sender)
GO

-- [8] View emails sent to me by other staff members of my company.
CREATE PROC View_my_inbox_Emails
@username VARCHAR(50)
AS SELECT time_stamp, sender_username, subject, body
	FROM Emails INNER JOIN Staff_send_Email S
	ON Emails.id = S.email_id AND S.receiver_username = @username
	WHERE S.sender_username IN (SELECT SM2.username FROM Staff_Members SM1 INNER JOIN Staff_Members SM2
									ON SM1.company = SM2.company AND SM1.username = @username)
	ORDER BY Emails.time_stamp DESC
GO

-- TODO: Test with EXEC after testing [7]

-- [9] Reply to an email sent to me, while the reply would be saved in the database as a new email record.
CREATE PROC Reply_to_Email
@orig_email INT, @reply_sender VARCHAR(50), @recipient VARCHAR(50), @subject VARCHAR(50), @body VARCHAR(max)
AS
	DECLARE @new_email INT
	EXEC Create_Email @subject, @recipient, @new_email, @orig_email
	EXEC Send_Email_in_Company @reply_sender, @recipient, @new_email
GO

-- [10] View announcements related to my company within the past 20 days.
CREATE PROC Announcements_of_Company
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

-- [1] Add a new job that belongs to my department,
-- including all the information needed about the job and its interview questions along with their model answers.
-- The title of the added job should contain at the beginning the role that will be assigned to the job seeker if he/she was
-- accepted in this job; for example: "Manager - Junior Sales Manager".

-- Add a new Job, without the questions, yet.
CREATE PROC Add_Job
@hr_username VARCHAR(50),
@title VARCHAR(50), @department VARCHAR(50), @company VARCHAR(50),
@short_desc VARCHAR(100), @detail_desc VARCHAR(max),
@working_hrs DECIMAL, @min_yrs_exp INT, @salary DECIMAL,
@deadline DATETIME, @vacancy INT = 1
AS BEGIN
	IF @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'You must be an HR Employee to add a new Job.'
	ELSE IF @hr_username NOT IN (SELECT username FROM Staff_Members WHERE company = @company AND department = @department)
		PRINT 'You can add new Jobs for your department only.'
	ELSE IF @working_hrs < 0 OR @working_hrs > 24
		PRINT 'Please provide valid working hours'
	ELSE IF @min_yrs_exp < 0
		PRINT 'Please provide valid minimum years of experience.'
	ELSE IF @salary < 0
		PRINT 'Please provide valid salary.'
	ELSE IF @vacancy < 0
		PRINT 'Please provide valid number of vacancies for this Job.'
	ELSE BEGIN
		INSERT INTO Jobs
		VALUES (@title, @department, @company, @short_desc, @detail_desc, @working_hrs, @min_yrs_exp, @salary, @vacancy, @deadline)

		INSERT INTO Hr_Employee_creates_Job VALUES (@title, @department, @company, @hr_username)
	END
END
GO

-- Create and store a question that can be reused in different Jobs.
-- Returns the id of the new question.
CREATE PROC Create_Question
@question VARCHAR(100), @answer BIT, @qid INT OUT
AS
	IF @question IS NULL
		PRINT 'Please enter the question as it will be shown to new job applicants.'
	ELSE BEGIN
		INSERT INTO Questions VALUES (@question, @answer)
		SET @qid = SCOPE_IDENTITY();
	END
GO

-- Add a question to a Job.
CREATE PROC Add_Job_Question_to_Job
@qid VARCHAR(50), @job_title VARCHAR(50), @department VARCHAR(50), @company VARCHAR(50)
AS
	IF @qid IS NULL
		PRINT 'You must not enter the question you want to add to this job.'
	ELSE IF @qid NOT IN (SELECT id FROM Questions)
		PRINT 'This question does not exist'
	ELSE IF @job_title NOT IN (SELECT title FROM Jobs WHERE company = @company AND department = @department)
		PRINT 'This job is not offered by this department.'
	ELSE
		INSERT INTO Job_has_Questions VALUES (@job_title, @department, @company, @qid)
GO

-- [2] View information about a job in my department.
CREATE PROC View_Job_in_Department
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

-- NOT SURE: [3] Edit the information of a job in my department.
CREATE PROC Edit_Job_in_Department
@hr_username VARCHAR(50), @job_title VARCHAR(50),
@short_desc VARCHAR(100), @detail_desc VARCHAR(max),
@working_hrs DECIMAL, @min_yrs_exp INT, @salary DECIMAL,
@deadline DATETIME, @vacancy INT = 1
AS BEGIN
	IF @hr_username IS NULL OR @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'You must be an HR to edit a Job.'
	ELSE IF @job_title NOT IN (SELECT J.title FROM Staff_Members HR, Jobs J
								WHERE J.company = HR.company AND J.department = HR.department AND HR.username = @hr_username)
		PRINT 'This job title is not offered in your department.'
	ELSE IF @working_hrs < 0 OR @working_hrs > 24
		PRINT 'Please enter valid working hours.'
	ELSE IF @min_yrs_exp < 0
		PRINT 'Please enter valid minimum years of experience.'
	ELSE IF @salary < 0
		PRINT 'Please enter valid salary.'
	ELSE IF @vacancy < 0
		PRINT 'Number of vacanies cannot be less then 0.'
	ELSE BEGIN
		DECLARE @department VARCHAR(50)
		DECLARE @company VARCHAR(50)

		SELECT @department = department, @company = @company FROM Staff_Members WHERE username = @hr_username

		UPDATE Jobs
		SET short_description = @short_desc, detailed_description = @detail_desc,
			working_hours = @working_hrs, min_years_of_experience = @min_yrs_exp, salary = @salary,
			deadline = @deadline, vacancy = @vacancy
		WHERE title = @job_title AND company = @company AND department = @department

	END
END
GO

-- [4] View new applications for a speci?c job in my department.
-- For each application, I should be able to check information about the job seeker, job & the score s/he got while applying.
CREATE PROC View_new_Applications_for_Job_in_Department
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
		WHERE A.job_title = @job_title AND A.hr_status = 'PENDING'
		AND EXISTS (SELECT * FROM Staff_Members S
					WHERE S.username = @hr_username AND S.company = J.company AND S.department = J.department)
GO

-- TODO: Test with some EXEC, needs some fresh Applications

-- [5] Accept or reject applications for jobs in my department.
-- @accept: 'TRUE' or 1 for ACCEPT. 'FALSE' or 0 for REJECT.
CREATE PROC Respond_to_Job_Application_HR
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
			IF @new_status = 'ACCEPTED'
				UPDATE Applications
				SET hr_status = @new_status, hr_username = @hr_username, manager_status = 'PENDING'
				WHERE id = @app_id
			ELSE IF @new_status = 'REJECTED'
				UPDATE Applications
				SET hr_status = @new_status, hr_username = @hr_username, manager_status = 'REJECTED'
				WHERE id = @app_id
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
CREATE PROC View_Requests_approved_by_Manager_only
@hr_username VARCHAR(50)
AS SELECT R.*, MR.manager_status, MR.mang_username FROM Requests R INNER JOIN Staff_Members SM ON R.username = SM.username AND R.hr_status = 'PENDING' AND R.manager_status = 'ACCEPTED'
							INNER JOIN Staff_Members HR ON HR.username = @hr_username AND HR.department = SM.department AND HR.company = SM.company
							INNER JOIN Manager_Request_Reviews MR ON MR.username = R.username AND MR.start_date = R.start_date
GO

-- [8] Accept or reject requests of staff members working with me in the same department that were approved by a manager.
-- My response decides the final status of the request, therefore the annual leaves of the applying staff member should be
-- updated in case the request was accepted.
-- Take into consideration that if the duration of the request includes the staff member's weekly day-off and/or Friday,
-- they should not be counted as annual leaves.

-- [HELPER] Decrement the annual leaves of a Staff Member by a certain number
CREATE PROC Dec_annual_leaves_by
@staff_username VARCHAR(50), @dec_by INT
AS
	IF @staff_username IS NULL OR @staff_username NOT IN (SELECT username FROM Staff_Members)
		PRINT 'Please provide a username of a Staff Member.'
	ELSE IF @dec_by IS NULL OR @dec_by < 0
		PRINT 'Please provide the number of days to decrement by'
	ELSE BEGIN
		DECLARE @old_annual_lvs INT
		SELECT @old_annual_lvs = annual_leaves FROM Staff_Members WHERE username = @staff_username

		DECLARE @new_annual_lvs INT
		SET @new_annual_lvs = @old_annual_lvs - @dec_by

		IF @new_annual_lvs < 0 BEGIN
			SET @new_annual_lvs = 0
			PRINT 'annual leaves remaining was less than zero, so raised up to zero.'
		END

		UPDATE Staff_Members
		SET annual_leaves = @new_annual_lvs
		WHERE username = @staff_username
	END
GO

-- [HELPER] Compute the number of leave days from start to end dates (inclusive),
-- but excluding 'Friday' and the staff member's day off from the calculation.
CREATE FUNCTION Get_leave_days (@start_date DATE, @end_date DATE, @day_off VARCHAR(9)) RETURNS INT
AS BEGIN

	-- Get the weekday equivelant of the day_off
	DECLARE @day_off_wk INT
	IF @day_off = 'Sunday'
		SET @day_off_wk = 1
	ELSE IF @day_off = 'Monday'
		SET @day_off_wk = 2
	ELSE IF @day_off = 'Tuesday'
		SET @day_off_wk = 3
	ELSE IF @day_off = 'Wednesday'
		SET @day_off_wk = 4
	ELSE IF @day_off = 'Thursday'
		SET @day_off_wk = 5
	ELSE IF @day_off = 'Saturday'
		SET @day_off_wk = 7

	-- Declare an accumulator to count the days in the range
	DECLARE @days INT
	SET @days = 0

	-- Start counting from the start date (till the end_date, inclusive)
	DECLARE @i_date DATE
	SET @i_date = @start_date

	-- Declare a variable that will be updated and used inside each iteration to store the weekday value of a DATE
	DECLARE @wk INT

	-- Start iterating from the start_date to the end_date inclusive, to count only the days that are not Friday or the day_off
	WHILE @i_date <= @end_date BEGIN
		
		-- Get the weekday equivelant of the date considered in this iteration
		SET @wk = DATEPART(WEEKDAY, @i_date)

		-- Only increment the counted days if the weekday is not Friday (6) or the day_off of the staff member.
		IF @wk <> 6 AND @wk <> @day_off_wk -- If not Friday or the day_off, count
			SET @days = @days + 1

		-- Update (increment) the current date to be considered in the next iteration
		SET @i_date = DATEADD(DAY, 1, @i_date)

	END

	RETURN @days
END
GO

--- >>> Accept or Reject a Request that a Manager has accepted.
CREATE PROC Respond_to_Request_HR
@hr_username VARCHAR(50), @req_start_date DATE, @req_username VARCHAR(50), @accept BIT
AS
	IF @hr_username IS NULL OR @hr_username NOT IN (SELECT username FROM Hr_Employees)
		PRINT 'The request must be reviewed by an HR employee.'
	ELSE IF NOT EXISTS (SELECT * FROM Requests WHERE username = @req_username AND start_date = @req_start_date
												AND manager_status = 'ACCEPTED')
		PRINT 'This request does not exist or has not been accepted by an HR Employee.'
	ELSE IF EXISTS (SELECT * FROM Requests WHERE username = @req_username AND start_date = @req_start_date
					AND hr_username IS NOT NULL)
		PRINT 'This request has already been accepted.'
	ELSE BEGIN

		DECLARE @status VARCHAR(50)
		IF @accept = 1
			SET @status = 'ACCEPTED'
		ELSE IF @accept = 0
			SET @status = 'REJECTED'

		IF @status IS NOT NULL BEGIN

			-- UPDATE the new status and the username of the HR employee who made that response
			UPDATE Requests
			SET hr_status = @status, hr_username = @hr_username
			WHERE username = @req_username AND start_date = @req_start_date

			DECLARE @req_end_date DATE
			SELECT @req_end_date = end_date FROM Requests
			WHERE username = @req_username AND start_date = @req_start_date

			DECLARE @staff_day_off VARCHAR(9)
			SELECT @staff_day_off = day_off FROM Staff_Members WHERE username = @req_username

			DECLARE @leave_days INT
			SET @leave_days = dbo.Get_leave_days(@req_start_date, @req_end_date, @staff_day_off)

			-- Decrement the annual leaves of this staff member by this number.
			EXEC Dec_annual_leaves_by @req_username, @leave_days
		END

	END
GO

--INSERT INTO Requests (username, request_date, start_date, end_date, manager_status, mang_username)
--VALUES ('Adel', '2017-11-01', '2017-11-05', '2017-11-19', 'ACCEPTED', 'Mohab')

--EXEC Respond_to_Request_HR 'Sabry', '2017-11-05', 'Adel', 1

--SELECT * FROM Requests

--SELECT * FROM Staff_Members WHERE username = 'Adel'

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