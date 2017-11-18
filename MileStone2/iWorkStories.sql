USE iWork


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