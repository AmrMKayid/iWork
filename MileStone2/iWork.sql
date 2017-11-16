CREATE DATABASE iWork
GO

USE iWork

CREATE TABLE Companies (
   domain VARCHAR(50) PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   email VARCHAR(50),
   address VARCHAR(max),
   type VARCHAR(50),
   vision VARCHAR(max),
   specialization VARCHAR(max)
)

CREATE TABLE Company_Phones (
  phone VARCHAR(50),
  company VARCHAR(50) REFERENCES Companies(domain) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(company, phone)
)

CREATE TABLE Departments (
  code VARCHAR(50),
  company VARCHAR(50) REFERENCES Companies(domain) ON UPDATE CASCADE, -- ON DELETE NO ACTION
  name VARCHAR(50),
  PRIMARY KEY(code, company)
)

CREATE TABLE Users (
  username VARCHAR(50) PRIMARY KEY,
  password VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR(50),
  last_name VARCHAR(50) NOT NULL,
  birth_date DATE NOT NULL,
  age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
  years_of_experience INT CHECK (years_of_experience >= 0)
)

CREATE TABLE User_Previous_Job_Titles (
  title VARCHAR(50), -- Increase title length or add 'at_company' field
  username VARCHAR(50) REFERENCES Users(username) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(title, username)
)

CREATE TABLE Jobs (
  title VARCHAR(50),
  department VARCHAR(50),
  company VARCHAR(50),
  short_description VARCHAR(100),
  detailed_description VARCHAR(max),
  working_hours INT,
  min_years_of_experience INT,
  salary DECIMAL,
  vacancy INT,
  deadline DATETIME,
  PRIMARY KEY(title, department, company),
  FOREIGN KEY(department, company) REFERENCES Departments(code, company) ON UPDATE CASCADE
)

CREATE TABLE Questions (
  id INT PRIMARY KEY,
  question VARCHAR(50) NOT NULL,
  answer VARCHAR(150),
)

CREATE TABLE Job_has_Questions (
  title VARCHAR(50),
  department VARCHAR(50),
  company VARCHAR(50),
  question INT REFERENCES Questions(id) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(title, department, company, question),
  FOREIGN KEY(title, department, company) REFERENCES Jobs(title, department, company) ON DELETE CASCADE ON UPDATE CASCADE
)

GO
CREATE FUNCTION form_staff_company_email(@username VARCHAR(50), @company_domain VARCHAR(50)) RETURNS VARCHAR(100)
AS BEGIN
	RETURN @username + '@' + @company_domain
END
GO

CREATE TABLE Staff_Members (
  username VARCHAR(50) PRIMARY KEY REFERENCES Users(username) ON DELETE CASCADE ON UPDATE CASCADE,
  company_email AS dbo.form_staff_company_email(username, company),
  salary DECIMAL,
  day_off VARCHAR(9) CHECK(day_off in ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')),
  annual_leaves INT,
  job_title VARCHAR(50),
  department VARCHAR(50),
  company VARCHAR(50),
  FOREIGN KEY(job_title, department, company) REFERENCES Jobs(title, department, company) ON UPDATE CASCADE,
  CONSTRAINT day_off_options CHECK(day_off in ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'))
)

CREATE TABLE Hr_Employees (
  username VARCHAR(50) PRIMARY KEY REFERENCES Staff_Members(username) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Managers (
  username VARCHAR(50) PRIMARY KEY REFERENCES Staff_Members(username) ON DELETE CASCADE ON UPDATE CASCADE,
  type VARCHAR(50)
)

CREATE TABLE Regular_Employees (
  username VARCHAR(50) PRIMARY KEY REFERENCES Staff_Members(username) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Hr_Employee_creates_Job (
  job_title VARCHAR(50),
  department VARCHAR(50),
  company VARCHAR(50),
  hr_username VARCHAR(50) NOT NULL REFERENCES Hr_Employees(username) ON UPDATE CASCADE,
  PRIMARY KEY(job_title, department, company),
  FOREIGN KEY(job_title, department, company) REFERENCES Jobs(title, department, company) ON DELETE CASCADE
)

-- JOB SEEKERS :'D
CREATE TABLE Applicants (
  username VARCHAR(50) PRIMARY KEY REFERENCES Users(username) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Applications (
  id INT PRIMARY KEY,
  score INT,
  hr_status VARCHAR(50),
  manager_status VARCHAR(50),
  job_title VARCHAR(50),
  department VARCHAR(50),
  company VARCHAR(50),
  app_username VARCHAR(50) NOT NULL REFERENCES Applicants(username) ON DELETE CASCADE ON UPDATE CASCADE,
  hr_username VARCHAR(50) REFERENCES Hr_Employees(username) ON DELETE NO ACTION ON UPDATE NO ACTION, --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< TODOOO
  manager_username VARCHAR(50) REFERENCES Managers(username) ON DELETE NO ACTION ON UPDATE NO ACTION, --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< TODOOO
  FOREIGN KEY(job_title, department, company) REFERENCES Jobs(title, department, company)
)

-- TODO: ^^ HR_reviews_Application (hr_status, hr_username) -- putting status here is to ensure that no one just changes the Application status; instead you have to put that review record in the review table and a username OF AN HR IS NOT NULL
-- TODO: ^^ Manager_reviews_Application (manager_status, manager_username) -- same ^^

CREATE TABLE Attendance_Records (
  attendance_date DATETIME,
  time_of_start TIME, --<<<<--- Amr: NOT SURE .. Shadi: 3adi, bass momken nekhalli "attendance_date" DATE not DATETIME (mesh moskela)
  time_of_leave TIME,
  username VARCHAR(50) REFERENCES Staff_Members(username) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(attendance_date, username)
)

CREATE TABLE Emails (
  id INT PRIMARY KEY,
  subject VARCHAR(50),
  body VARCHAR(max),
  time_stamp AS CURRENT_TIMESTAMP --TIMESTAMP NOT NULL -- CURRENT_TIMESTAMP?
)

CREATE TABLE Staff_send_Email (
 id INT FOREIGN KEY REFERENCES Emails(id) ON DELETE CASCADE,
 receiver_username VARCHAR(50) REFERENCES Staff_Members(username),
 sender_username VARCHAR(50) NOT NULL REFERENCES Staff_Members(username),
 PRIMARY KEY(id, receiver_username)
)

CREATE TABLE Announcements (
  id INT PRIMARY KEY,
  title VARCHAR(50),
  date DATETIME NOT NULL, -- just to make sure we know when an announcement was made
  type VARCHAR(50),
  description VARCHAR(max),
  hr_username VARCHAR(50) NOT NULL REFERENCES Hr_Employees(username) ON UPDATE CASCADE
)

CREATE TABLE Requests (
  start_date DATE, 
  request_date DATETIME,
  end_date DATE,
  leave_days AS DATEDIFF(d, start_date, end_date),
  hr_status VARCHAR(50) DEFAULT 'PENDING',
  manager_status VARCHAR(50) DEFAULT 'PENDING',
  username  VARCHAR(50) REFERENCES Staff_Members(username) ON DELETE CASCADE ON UPDATE CASCADE,
  hr_username VARCHAR(50) REFERENCES Hr_Employees(username),
  PRIMARY KEY(start_date, username)
)

CREATE TABLE Business_Trips (
  start_date DATE,
  username VARCHAR(50),
  destination VARCHAR(50),
  purpose VARCHAR(50),
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username) ON DELETE CASCADE
)

CREATE TABLE Leave_Requests (
  start_date DATE,
  username  VARCHAR(50),
  type VARCHAR(50),
  CONSTRAINT leave_type_options CHECK (type in ('sick', 'accidental', 'annual')),
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username) ON DELETE CASCADE
)

CREATE TABLE Manager_Request_Reviews (
  start_date DATE,
  username VARCHAR(50),
  manager_status VARCHAR(50) NOT NULL,
  reason VARCHAR(50),
  mang_username VARCHAR(50) NOT NULL REFERENCES Managers(username),
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username)
)

CREATE TABLE Request_Hr_Replace (
   start_date DATE,
  username VARCHAR(50),
  username_replacing VARCHAR(50) REFERENCES Hr_Employees(username) ON UPDATE CASCADE
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username) ON DELETE CASCADE
)

CREATE TABLE Request_Manager_Replace (
   start_date DATE,
  username VARCHAR(50),
  username_replacing VARCHAR(50) REFERENCES Managers(username) ON UPDATE CASCADE
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username) ON DELETE CASCADE
)

CREATE TABLE Request_Regular_Employee_Replace (
  start_date DATE,
  username VARCHAR(50),
  username_replacing VARCHAR(50) REFERENCES Regular_Employees(username) ON UPDATE CASCADE
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username) ON DELETE CASCADE
)

CREATE TABLE Projects (
  name varchar(50),
  company VARCHAR(50) REFERENCES Companies(domain),
  start_date DATETIME,
  end_date DATETIME,
  mananger_define_username VARCHAR(50) NOT NULL REFERENCES Managers(username) ON UPDATE CASCADE,
  PRIMARY KEY(name, company)
)

CREATE TABLE Project_Assignments (
  project_name varchar(50),
  company VARCHAR(50),
  regular_employee_username VARCHAR(50) NOT NULL REFERENCES Regular_Employees(username),
  mananger_username VARCHAR(50) NOT NULL REFERENCES Managers(username),
  PRIMARY KEY(project_name, company, regular_employee_username),
  FOREIGN KEY(project_name, company) REFERENCES Projects(name, company)
)

CREATE TABLE Tasks (
  name varchar(50),
  description varchar(max),
  status varchar(50),
  deadline DATETIME,
  project varchar(50),
  company VARCHAR(50),
  regular_employee_username VARCHAR(50) NOT NULL REFERENCES Regular_Employees(username),
  mananger_username VARCHAR(50) NOT NULL REFERENCES Managers(username),
  PRIMARY KEY(name, project, company),
  FOREIGN KEY(project, company) REFERENCES Projects(name, company) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Comments (
  id INT,
  task VARCHAR(50),
  project VARCHAR(50),
  company VARCHAR(50),
  content VARCHAR(150),
  username VARCHAR(50) NOT NULL REFERENCES Staff_Members(username) ON DELETE CASCADE,
  PRIMARY KEY(id, task, project, company),
  FOREIGN KEY(task, project, company) REFERENCES Tasks(name, project, company) ON UPDATE CASCADE
)