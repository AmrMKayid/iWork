CREATE DATABASE iWork

-- Company
CREATE TABLE Companies (
   domain VARCHAR(50) PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   email VARCHAR(50),
   address VARCHAR(max),
   type VARCHAR(50),
   vision VARCHAR(max),
   specialization VARCHAR(max)
)

-- Company's phone_number(s)
CREATE TABLE Company_Phones (
  phone VARCHAR(50),
  company VARCHAR(50) REFERENCES Companies(domain) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(company, phone)
)

-- Department (weak entity)
CREATE TABLE Departments (
  code VARCHAR(50),
  company VARCHAR(50) REFERENCES Companies(domain) ON DELETE CASCADE ON UPDATE CASCADE,
  name VARCHAR(50),
  PRIMARY KEY(code, company)
)

-- User
CREATE TABLE Users (
  username VARCHAR(50) PRIMARY KEY,
  password VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR(50),
  last_name VARCHAR(50) NOT NULL,
  birth_date DATE NOT NULL,
  age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
  years_of_experience INT
)

-- User's previous job title(s)
CREATE TABLE User_Previous_Job_Titles (
  title VARCHAR(50),
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
  FOREIGN KEY(department, company) REFERENCES Departments(code, company) ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE Staff_Members (
  username VARCHAR(50) PRIMARY KEY REFERENCES Users(username) ON DELETE CASCADE ON UPDATE CASCADE,
  company_email VARCHAR(100), -- can we use a function (in table creation file) to derive the company_email?
  salary DECIMAL,
  --day_off DATETIME, -- day off, i.e. youm el agaza -- is not DATETIME
  day_off VARCHAR(9) CHECK(day_off in ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')),
  annual_leaves INT,
  job_title VARCHAR(50),
  department VARCHAR(50),
  company VARCHAR(50),
  FOREIGN KEY(job_title, department, company) REFERENCES Jobs(title, department, company) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ----->>>>--- FOREIGN KEY(department, company) REFERENCES Departments(code, company) ON UPDATE CASCADE
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
  hr_username VARCHAR(50) NOT NULL REFERENCES Hr_Employees(username) ON DELETE NO ACTION ON UPDATE CASCADE,
  PRIMARY KEY(job_title, department, company),
  FOREIGN KEY(job_title, department, company) REFERENCES Jobs(title, department, company) ON DELETE CASCADE ON UPDATE CASCADE
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
  manager_username VARCHAR(50) REFERENCES Managers(username)ON DELETE NO ACTION ON UPDATE NO ACTION, --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< TODOOO
  FOREIGN KEY(job_title, department, company) REFERENCES Jobs(title, department, company) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Attendance_Records ( -- can we just call it "Attendance" or other plural than "AttendanceS"?
  attendance_date DATETIME,
  time_of_start TIME, --<<<<--- Amr: NOT SURE .. Shadi: 3adi, bass momken nekhalli "attendance_date" DATE not DATETIME (mesh moskela)
  time_of_leave TIME,
  username VARCHAR(50) REFERENCES Staff_Members(username),
  PRIMARY KEY(attendance_date, username)
)

CREATE TABLE Emails (
  id INT PRIMARY KEY,
  subject VARCHAR(50),
  body VARCHAR(max),
  time_stamp TIMESTAMP
)
CREATE TABLE Staff_Send_Email_Staff (
  id INT,
  receiver_username VARCHAR(50)  REFERENCES Staff_Members(username),
  sender_username VARCHAR(50)  REFERENCES Staff_Members(username),
  PRIMARY KEY(id, receiver_username)
)

CREATE TABLE Announcements (
  id INT PRIMARY KEY,
  title VARCHAR(50),
  date DATETIME,
  type VARCHAR(50),
  description VARCHAR(max),
  hr_username VARCHAR(50) REFERENCES Hr_Employees(username)
)

CREATE TABLE Requests (
  start_date DATETIME,
  request_date DATETIME,
  end_date DATETIME,
  leave_days AS (start_date - end_date),
  hr_status VARCHAR(50),
  manager_status VARCHAR(50),
  username  VARCHAR(50)  REFERENCES Staff_Members(username),
  hr_username VARCHAR(50) REFERENCES Hr_Employees(username),
  PRIMARY KEY(start_date, username)
)

CREATE TABLE Business_Trips (
  destination VARCHAR(50),
  purpose VARCHAR(50),
  start_date DATETIME,
  username  VARCHAR(50),
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username)
)

CREATE TABLE Leaves (
  type VARCHAR(50),
  start_date DATETIME,
  username  VARCHAR(50),
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username)
)

CREATE TABLE Request_Hr_Replace (
  start_date DATETIME,
  username  VARCHAR(50),
  username_replacing VARCHAR(50) REFERENCES Hr_Employees(username)
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username)
)

CREATE TABLE Request_Manganger_Replace (
  start_date DATETIME,
  username  VARCHAR(50),
  username_replacing VARCHAR(50) REFERENCES Managers(username)
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username)
)

CREATE TABLE Request_Regular_Employee_Replace (
  start_date DATETIME,
  username  VARCHAR(50),
  username_replacing VARCHAR(50) REFERENCES Regular_Employees(username)
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username)
)


CREATE TABLE Manager_Request_Reviews (
  reason VARCHAR(50),
  manager_status VARCHAR(50),
  start_date DATETIME,
  username  VARCHAR(50),
  mang_username VARCHAR(50) REFERENCES Managers(username),
  PRIMARY KEY(start_date, username),
  FOREIGN KEY(start_date, username) REFERENCES Requests(start_date, username)
)


CREATE TABLE Projects (
  name varchar(50),
  company VARCHAR(50) REFERENCES Companies(domain),
  start_date DATETIME,
  end_date DATETIME,
  mananger_define_username VARCHAR(50) REFERENCES Managers(username),
  PRIMARY KEY(name, company)
)

CREATE TABLE Project_Assignments (
  project_name varchar(50),
  company VARCHAR(50),
  regular_employee_username VARCHAR(50) REFERENCES Regular_Employees(username),
  mananger_username VARCHAR(50) REFERENCES Managers(username),
  PRIMARY KEY(project_name, company, regular_employee_username),
  FOREIGN KEY(project_name, company) REFERENCES Projects(name, company)
)
CREATE TABLE Tasks (
  name varchar(50),
  description varchar(max),
  status varchar(50),
  deadline DATETIME,
  project_name varchar(50),
  company VARCHAR(50),
  regular_employee_username VARCHAR(50) REFERENCES Regular_Employees(username),
  mananger_username VARCHAR(50) REFERENCES Managers(username),
  PRIMARY KEY(name, project_name, company),
  FOREIGN KEY(project_name, company) REFERENCES Projects(name, company)
)

CREATE TABLE Comments (
  id INT,
  content varchar(50),
  task varchar(50),
  project_name varchar(50),
  company VARCHAR(50),
  username VARCHAR(50) REFERENCES Staff_Members(username),
  PRIMARY KEY(id, task, project_name, company),
  FOREIGN KEY(task, project_name, company) REFERENCES Tasks(name, project_name, company)
)