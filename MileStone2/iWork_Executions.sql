GO
USE iWork;

---- ##### ##### ##### ##### ##### ##### ##### #####  Amr Start  ##### ##### ##### #####  ##### ##### ##### ##### -----

---- “As a regular employee, I should be able to ...”

---- Number 1
GO
EXEC viewMyAssignedProjects 'Regular1'

---- Number 2
GO
EXEC viewMyAssignedTasksInAProject 'Regular5', 'First Project'

---- Number 3
-- GO
-- SELECt * FROM Tasks
GO
EXEC FinishedTask 'Regular7', 'AssignedAmr''sTask', 'Second Project'
GO
EXEC FinishedTask 'Regular7', 'FixedAmr''sTask', 'Second Project'
GO
EXEC FinishedTask 'Regular7', 'AssignedAmr''sTaskAfterDeadline', 'Second Project'
-- SELECt * FROM Tasks

---- Number 4

GO -- Deadline Did NOT Pass and Wasn't REVIEWED ie. Will be changed
EXEC ChangeTaskStatus 'Regular7', 'Number4Case1', 'Second Project'
GO -- Deadline Did NOT Pass and Was REVIEWED ie. Will NOT be changed
EXEC ChangeTaskStatus 'Regular7', 'Number4Case2', 'Second Project'
GO -- Deadline Passed ie. Will NOT be changed
EXEC ChangeTaskStatus 'Regular7', 'Number4Case3', 'Second Project'

-- SELECT * FROM Tasks

--------$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$----------------

---- “As a manager, I should be able to ...”

---- Number 1
GO
SELECT * FROM Requests

GO -- HR Manager Views All Request
EXEC ViewNewRequests 'YasmeenHRTestingAmr'


GO -- NOT HR Manager Views All Request except HR Req
EXEC ViewNewRequests 'YasmeenNOTHRTestingAmr'


---- Number 2
GO  -- Manager OutSide of my Department
EXEC ReviewRequest 'ShadiBarghash', '2018-01-01', 'AmrHR', 0, ''

GO  -- Manager InSide my Department and NOT HR Req.
EXEC ReviewRequest 'YasmeenHRTestingAmr', '2018-01-01', 'AmrNOTHrBUTReg', 0, 'BAD Timing'

GO  -- Manager InSide my Department and NOT HR Req.
EXEC ReviewRequest 'YasmeenHRTestingAmr', '2018-01-01', 'AmrHR', 1, ''



---- Number 3

GO
EXEC ViewApplication 'YasmeenHRTestingAmr', 'Software Engineering Manager'

---- Number 4
GO
EXEC ReviewApplication 'YasmeenHRTestingAmr', 8, 1

GO
EXEC ReviewApplication 'ShadiBarghash', 7, 1


---- Number 5
GO
EXEC CreateNewProject 'YasmeenHRTestingAmr', 'Creating third new Project', '2017/11/15'  , '2017/11/17'


---- Number 6
GO -- Will be added 
EXEC AddEmployeeToProject 'YasmeenHRTestingAmr', 'Creating third new Project', 'Regular7'

GO -- will not be added
EXEC AddEmployeeToProject 'YasmeenHRTestingAmr', 'Second Project', 'Regular7'



---- Number 7
GO -- WILL be removed
EXEC RemoveEmployeeFromProject 'YasmeenHRTestingAmr', 'First Project', 'RegEmpWithNoTasks'

GO -- WILL NOT be removed
EXEC RemoveEmployeeFromProject 'YasmeenHRTestingAmr', 'First Project', 'Regular7'

-- SELECT * FROM Project_Assignments


GO
EXEC CreateNewTask 'YasmeenHRTestingAmr', '10th Task', 'The easy task', '2017/11/27' , 'Creating third new Project'
-- SELECT * FROM Tasks
-- SELECT * FROM Project_Assignments