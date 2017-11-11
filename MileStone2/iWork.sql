CREATE DATABASE iWork

CREATE TABLE Companies (
   domain varchar(100) PRIMARY KEY,
   name varchar(50), ------- <<<<<<
   email varchar(50), 
   address varchar(100), ------- <<<<<<
   type varchar(50), ------- <<<<<<
   vision varchar(50), 
   specialization varchar(50)
)

CREATE TABLE Company_Phones (
  phone varchar(100),
  domain varchar(100) REFERENCES Companies(domain),
  PRIMARY KEY(domain, phone)
)

CREATE TABLE Departments (
  code INT,
  name varchar(50),
  domain varchar(100) REFERENCES Companies(domain),
  PRIMARY KEY(code, domain)
)


CREATE TABLE Jobs(
  job_id INT PRIMARY KEY,
  title varchar(50),
  short_description varchar(100),
  detailed_description varchar(250),
  working_hours INT, 
  min_years_of_experience INT,
  salary DECIMAL,
  vacancy INT,
  deadline DATETIME,
  code INT REFERENCES Departments(code),
  domain varchar(100) REFERENCES Departments(domain),
  hr_username varchar(50) -- >>> JOB.HrUsername references HREMPLOYEE.username
) 

CREATE TABLE Interviews (
  question varchar(100), 
  answer varchar(100),
  job_id INT REFERENCES Jobs(job_id),
  PRIMARY KEY(question, job_id)
)

CREATE TABLE Users (
  username varchar(100) PRIMARY KEY,
  password varchar(100),
  email varchar(50),
  birth_date DATETIME,
  age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
  first_name varchar(50),
  middle_name varchar(50),
  last_name varchar(50),
  years_of_experience INT
)

CREATE TABLE User_prevouis_job_titles (
  title varchar(50),
  username varchar(100) REFERENCES Users(username),
  PRIMARY KEY(title, username)
)
   
CREATE TABLE Applicants (
  username varchar(100) PRIMARY KEY REFERENCES Users(username)
)

CREATE TABLE Applications (
  id INT,
  score INT,
  hr_status varchar(50),
  job_id INT REFERENCES Jobs(job_id),
  app_username varchar(100), -- >>> APPLICATION.AppUsername references APPLICANT.username,
  hr_username varchar(100), -- >>> APPLICATION.HrUsername references HREMPLOYEE.username
  PRIMARY KEY(id, job_id, app_username, hr_username)

)


CREATE TABLE Accepted (
  manager_status varchar(50),
  id INT REFERENCES Application(id),
  job_id INT REFERENCES Application(job_id),
  app_username varchar(100) REFERENCES Application(app_username), 
  mang_username varchar(100),  -- >>> ACCEPTED.MangUsername references MANAGER.username,
  PRIMARY KEY(id, job_id, app_username)
) 

CREATE TABLE Rejected (   ------- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  id INT REFERENCES Application(id),
  job_id INT REFERENCES Application(job_id),
  app_username varchar(100) REFERENCES Application(app_username), 
)

CREATE TABLE Staff_Members (
  username varchar(100) PRIMARY KEY REFERENCES Users(username),
  -- code,    <<<<<<<<< Change with job_id ???????!!!!
  -- domain,
  company_email varchar(50),
  salary DECIMAL,
  day_off DATETIME,
  annual_leaves INT
)

CREATE TABLE Attendances (
  date DATETIME,
  username varchar(100)  REFERENCES Staff_Member(username),  
  time_of_start TIME, ------- NOT SURE
  time_of_leave TIME,
  PRIMARY KEY(username, date)
)
CREATE TABLE Emails (
  id INT PRIMARY KEY,
  subject varchar(50),
  body varchar(max),
  time_stamp TIMESTAMP
)
CREATE TABLE Sends (
  id INT,
  username_receiver varchar(100)  REFERENCES Staff_Member(username),
  username_sender varchar(100)  REFERENCES Staff_Member(username)
  PRIMARY KEY(id, username_receiver)
)
    
CREATE TABLE Requests (
  req_num INT,
  request_date DATETIME,
  start_date DATETIME,
  end_date DATETIME,
  leave_days AS (start_date - end_date),
  hr_status varchar(50),
  manager_status varchar(50),
  username  varchar(100)  REFERENCES Staff_Member(username),
  hr_username varchar(100), -- >>>> REQUEST.HrUsername references HREMPLOYEE.username,
  PRIMARY KEY(req_num, username)
)

CREATE TABLE Manager_Request_Reviews (
  req_num INT  REFERENCES Request(req_num),
  username  varchar(100)  REFERENCES Request(username),
  reason varchar(100),
  mang_username varchar(100),  -- >>> MANAGERREQUESTREVIEW.MangUsername references MANAGER.username
  PRIMARY KEY(req_num, username)
) 
CREATE TABLE Business_Trips (
  req_num INT REFERENCES Request(req_num),
  username  varchar(100)  REFERENCES Request(username),
  destination varchar(100),
  purpose varchar(100),
  PRIMARY KEY(req_num, username)
)

CREATE TABLE Leaves (
  req_num INT REFERENCES Request(req_num),
  username  varchar(100)  REFERENCES Request(username),
  type varchar(100),
  PRIMARY KEY(req_num, username)
)

CREATE TABLE Hr_Employees (
  username varchar(100) PRIMARY KEY REFERENCES Staff_Member(username)
)

CREATE TABLE Request_Hr_Replace (
  req_num INT REFERENCES Request(req_num),
  username  varchar(100)  REFERENCES Request(username),
  username_replacing varchar(100) REFERENCES Hr_Employees(username)
  PRIMARY KEY(req_num, username)
) 

CREATE TABLE Announcements ( 
  id INT PRIMARY KEY,
  title varchar(50),
  date DATETIME,
  type varchar(50),
  description varchar(max),
  hr_username varchar(100) REFERENCES Hr_Employees(username)
)

CREATE TABLE Managers (
  username varchar(100) PRIMARY KEY REFERENCES Staff_Member(username), 
  type varchar(100)
)

CREATE TABLE Request_Mang_Replace (
  req_num INT REFERENCES Request(req_num),
  username  varchar(100)  REFERENCES Request(username),
  username_replacing varchar(100) REFERENCES Managers(username)
  PRIMARY KEY(req_num, username)
)

CREATE TABLE Regular_Employees (
  username varchar(100) PRIMARY KEY REFERENCES Staff_Member(username)
)

CREATE TABLE Request_RegE_Replace (
  req_num INT REFERENCES Request(req_num),
  username  varchar(100)  REFERENCES Request(username),
  username_replacing varchar(100) REFERENCES Regular_Employees(username)
  PRIMARY KEY(req_num, username)
)

CREATE TABLE Projects (
  name varchar(50), ---- <<<<<<< PRIMARY KEY MODIFYYYYYY
  mang_define_username varchar(100) REFERENCES Managers(username),
  start_date DATETIME,
  end_date DATETIME
)

CREATE TABLE Project_Assignments (
  project_name varchar(50) REFERENCES Projects(name),
  regE_username varchar(100) REFERENCES Regular_Employees(username),
  mang_username varchar(100) REFERENCES Managers(username),
  PRIMARY KEY(project_name, regE_username) ---- <<<<<<< PRIMARY KEY MODIFYYYYYY
) 
CREATE TABLE Tasks (
  name varchar(50),
  description varchar(max),
  status varchar(50),
  deadline DATETIME,
  project_name varchar(50) REFERENCES Projects(name),
  regE_username varchar(100) REFERENCES Regular_Employees(username),
  mang_username varchar(100) REFERENCES Managers(username),
  PRIMARY KEY(name, project_name) ---- <<<<<<< PRIMARY KEY MODIFYYYYYY
)

CREATE TABLE Comments (
  id INT,
  content varchar(50),
  name varchar(50) REFERENCES Tasks(name),
  project_name varchar(50) REFERENCES Tasks(project_name),
  username varchar(100) REFERENCES Staff_Member(username),
  PRIMARY KEY(id, name, project_name) ---- <<<<<<< PRIMARY KEY MODIFYYYYYY
) 