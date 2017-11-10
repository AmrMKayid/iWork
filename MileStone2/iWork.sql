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

CREATE TABLE User_prevouis_job_title (
  title varchar(50),
  username varchar(100) REFERENCES Users(username),
  PRIMARY KEY(title, username)
)
   
CREATE TABLE Applicant (
  username varchar(100) REFERENCES Users(username)
)

CREATE TABLE Application (
  id INT,
  score INT,
  hr_status varchar(50),
  job_id INT REFERENCES Jobs(job_id),
  app_username varchar(100), -- >>> APPLICATION.AppUsername references APPLICANT.username,
  hr_username varchar(100), -- >>> APPLICATION.HrUsername references HREMPLOYEE.username
  PRIMARY KEY(ID, job_id, app_username, hr_username)

)


-- ACCEPTED(ID, jobID, AppUsername, MangUsername, managerStatus) ACCEPTED.MangUsername references MANAGER.username,
-- ACCEPTED.(ID, jobID, AppUsername) references APPLICATION,
-- Constraint: ACCEPTED is an Attribute defined relation: APPLICATION.HRStatus
-- REJECTED(ID, jobID, AppUsername)
-- REJECTED.(ID, jobID, AppUsername) references APPLICATION
-- Constraint: REJECTED is an Attribute defined relation: APPLICATION.HRStatus

--  STAFFMEMBER(username, code, domain, companyEmail, salary, dayOff,
-- annualLeaves)
-- STAFFMEMBER.username references USER.username, STAFFMEMBER.(code, domain) references DEPARTMENT
-- A T T E N D A N C E ( username, date, timeOfStart, timeOfLeave) ATTENDANCE.username references STAFFMEMBER.username
-- E M A I L ( ID, subject, body, timeStamp)
-- SEND(ID, usernameReceiver, usernameSender) SEND.ID references EMAIL.ID
-- SEND.usernameSender references STAFFMEMBER.username, SEND.usernameReceiver references STAFFMEMBER.username
-- REQUEST(ReqNum, username, HrUsername, requestDate, startDate, endDate,
-- leaveDays, HRStatus, managerStatus)
-- REQUEST.username references STAFFMEMBER.username, REQUEST.HrUsername references HREMPLOYEE.username,
-- Where REQUEST.leaveDays = REQUEST.endDate - REQUEST.startDate
-- MANAGERREQUESTREVIEW(ReqNum, username, MangUsername, reason) MANAGERREQUESTREVIEW.(ReqNum, username) references REQUEST, MANAGERREQUESTREVIEW.MangUsername references MANAGER.username
-- BUSINESSTRIP(ReqNum, username, destination, purpose) BUSINESSTRIP.(ReqNum, username) references REQUEST
-- LEAVE(ReqNum, username, type) LEAVE.(ReqNum, username) references REQUEST
-- HREMPLOYEE(username)
-- HREMPLOYEE.username references STAFFMEMBER.username
-- REQUESTHRREPLACE(ReqNum, username, usernameReplacing) REQUESTHRREPLACE.(ReqNum, username ) references REQUEST, REQUESTHRREPLACE.usernameReplacing references HREMPLOYEE.username
-- A N N O U N C E M E N T ( ID, HrUsername, title, date, type, description) ANNOUNCEMENT.HrUsername references HREMPLOYEE.username

-- MANAGER(username, type)
-- MANAGER.username references STAFFMEMBER.username
-- REQUESTMANGREPLACE(ReqNum, username, usernameReplacing) REQUESTMANGREPLACE.(ReqNum, username ) references REQUEST, REQUESTMANGREPLACE.usernameReplacing references MANAGER.username
-- R E G U L A R E M P L O Y E E ( username) REGULAREMPLOYEE.username references STAFFMEMBER.username
-- REQUESTREGEREPLACE(ReqNum, username, usernameReplacing) REQUESTREGEREPLACE.(ReqNum, username) references REQUEST, REQUESTREGEREPLACE.usernameReplacing references REGULAREMPLOYEE.username
-- PROJECT(name, MangDefineUsername, startDate, endDate) PROJECT.MangDefineUsername references MANAGER.username
-- PROJECTASSIGNMENT(projName, RegEUsername, MangUsername) PROJECTASSIGNMENT.projName references PROJECT.name, PROJECTASSIGNMENT.MangUsername references MANAGER.username, PROJECTASSIGNMENT.RegEUsername references REGULAREMPLOYEE.username
-- T A S K ( name, projectName, RegEUsername, MangUsername, description, status,
-- deadline)
-- TASK.projectName references PROJECT.name, TASK.MangUsername references MANAGER.username, TASK.RegEUsername references REGULAREMPLOYEE.username
-- COMMENT(ID, name, projectName, username, content) COMMENT.(name, projectName) references TASK, COMMENT.username references STAFFMEMBER.username