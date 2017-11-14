CREATE DATABASE iWork

CREATE TABLE Companies (
   domain VARCHAR(50) PRIMARY KEY,
   name VARCHAR(50),
   email VARCHAR(50), 
   address VARCHAR(100),
   type VARCHAR(50),
   vision VARCHAR(50), 
   specialization VARCHAR(50)
)

CREATE TABLE Company_Phones (
  phone VARCHAR(50),
  company VARCHAR(50) REFERENCES Companies(domain),
  PRIMARY KEY(company, phone)
)

CREATE TABLE Departments (
  code INT,
  name VARCHAR(50),
  company VARCHAR(50) REFERENCES Companies(domain),
  PRIMARY KEY(code, company)
)


CREATE TABLE Jobs(
  title VARCHAR(50),
  short_description VARCHAR(100),
  detailed_description VARCHAR(max),
  working_hours INT, 
  min_years_of_experience INT,
  salary DECIMAL,
  vacancy INT,
  deadline DATETIME,
  department INT,
  company VARCHAR(50),
  ------- >>>>>> hr_username varchar(50) REFERENCES Hr_Employees(username),
  PRIMARY KEY(title, department, company),
  FOREIGN KEY(department, company) REFERENCES Departments(code, company)
) 

CREATE TABLE Questions (
  question_number INT PRIMARY KEY,
  question VARCHAR(50),
  answer VARCHAR(150),
)

CREATE TABLE Job_Has_Questions (
  title VARCHAR(50),
  department INT,
  company VARCHAR(50),
  question INT REFERENCES Questions(question_number),
  PRIMARY KEY(title, department, company, question),
  FOREIGN KEY(title, department, company) REFERENCES Jobs(title, department, company)
)

CREATE TABLE Users (
  username VARCHAR(50) PRIMARY KEY,
  password VARCHAR(50),
  email VARCHAR(50),
  birth_date DATETIME,
  age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
  first_name VARCHAR(50),
  middle_name VARCHAR(50),
  last_name VARCHAR(50),
  years_of_experience INT
)

CREATE TABLE User_prevouis_job_titles (
  title VARCHAR(50),
  username VARCHAR(50) REFERENCES Users(username),
  PRIMARY KEY(title, username)
)

CREATE TABLE Staff_Members (
  username VARCHAR(50) PRIMARY KEY REFERENCES Users(username),
  company_email VARCHAR(50),
  salary DECIMAL,
  day_off DATETIME,
  annual_leaves INT,
  title VARCHAR(50),
  department INT,
  company VARCHAR(50),
  FOREIGN KEY(title, department, company) REFERENCES Jobs(title, department, company)
)

CREATE TABLE Attendances (
  attendance_date DATETIME,
  time_of_start TIME, --<<<<----- NOT SURE
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
  sender_username VARCHAR(50)  REFERENCES Staff_Members(username)
  PRIMARY KEY(id, receiver_username)
)

CREATE TABLE Hr_Employees (
  username VARCHAR(50) PRIMARY KEY REFERENCES Staff_Members(username)
)

CREATE TABLE Managers (
  username VARCHAR(50) PRIMARY KEY REFERENCES Staff_Members(username), 
  type VARCHAR(50)
)

CREATE TABLE Regular_Employees (
  username VARCHAR(50) PRIMARY KEY REFERENCES Staff_Members(username)
)

   
CREATE TABLE Applicants (
  username VARCHAR(50) PRIMARY KEY REFERENCES Users(username)
)

CREATE TABLE Applications (
  id INT PRIMARY KEY,
  score INT,
  hr_status VARCHAR(50),
  manager_status VARCHAR(50),
  title VARCHAR(50),
  department INT,
  company VARCHAR(50),
  app_username VARCHAR(50) REFERENCES Applicants(username),
  hr_username VARCHAR(50) REFERENCES Hr_Employees(username),
  manager_username VARCHAR(50) REFERENCES Managers(username),
  FOREIGN KEY(title, department, company) REFERENCES Jobs(title, department, company)
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