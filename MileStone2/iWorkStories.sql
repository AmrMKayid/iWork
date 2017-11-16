USE iWork


-- “As a regular employee, I should be able to ...”
GO
Create Procedure viewMyAssignedProjects
(
@username VARCHAR(50)
)
As
Begin
     SELECT Projects.*
     FROM Project_Assignments, Projects
     WHERE regular_employee_username = @username and
           Project_Assignments.project_name = Projects.name
End

GO
EXEC viewMyAssignedProjects 'Regular'

GO
Create Procedure viewMyAssignedTasksInAProject
(
@username VARCHAR(50), @project varchar(50)
)
As
Begin
     SELECT *
     FROM Tasks
     WHERE regular_employee_username = @username and
           Tasks.project = @project
End

GO
EXEC viewMyAssignedTasksInAProject 'Regular', 'First Project'


GO
Create Procedure FinishedTask
(
@username VARCHAR(50), @task varchar(50)
)
As
Begin
    UPDATE Tasks
    SET [status] = 'Fixed'
    WHERE SYSDATETIME() < deadline 
          AND Tasks.name = @task 
          AND Tasks.regular_employee_username = @username
End

GO
EXEC FinishedTask 'Regular', 'First Task'


GO
Create Procedure ChangeTaskStatus
(
@username VARCHAR(50), @task varchar(50)
)
As
Begin
    UPDATE Tasks
    SET [status] = 'Assigned'
    WHERE SYSDATETIME() < deadline 
          AND Tasks.name = @task 
          AND Tasks.regular_employee_username = @username
          AND Tasks.[status] <> 'Closed'
End

GO
EXEC FinishedTask 'Regular', 'First Task'

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- “As a manager, I should be able to ...”

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
EXEC CreateNewProject 'Eyad3', 'Creating third new Project', 'apple.com', '2017/11/15'  , '2017/11/17'

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

EXEC AddEmployeeToProject 'Eyad3', 'First Project', 'apple.com', 'Regular2'

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

EXEC RemoveEmployeeFromProject 'Eyad3', 'First Project', 'Regular2'

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

EXEC CreateAndAssignNewTask 'Eyad3', '5th Task by Proc', 'The easy task', '2017/11/17' , 'First Project', 'apple.com', 'Regular'

SELECT * FROM Tasks

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

EXEC ChangeTaskEmployee 'Eyad3', 'First Project', 'Assigned Task', 'Regular2', 'Regular'

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

EXEC ViewProjectTasks 'Eyad3', 'First Project', 'Pending' 


-- GO
-- Create Procedure ReviewTask
-- (
-- @manager VARCHAR(50), @project varchar(50), @task varchar(50), @review varchar(50)
-- )
-- As
-- IF EXISTS(SELECT * FROM Managers
--         where Managers.username = @manager)
-- IF EXISTS(SELECT * FROM Tasks
--         where name = @task AND [status] = 'Fixed')
-- Begin
--     IF(@review = 'Accept')
--         UPDATE Tasks SET status = 'Closed' WHERE name = @task 
--     ELSE
--         UPDATE Tasks SET status = 'Assigned', deadline = 'TODO' WHERE name = @task 
-- End
