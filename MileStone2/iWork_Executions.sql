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
-- GO
-- SELECT * FROM Requests

GO -- HR Manager Views All Request
EXEC ViewNewRequests 'YasmeenHRTestingAmr'


GO -- NOT HR Manager Views All Request except HR Req
EXEC ViewNewRequests 'YasmeenNOTHRTestingAmr'


---- Number 2
GO  -- Manager OutSide of my Department
EXEC ReviewRequest 'ShadiBarghash', '2018-01-01', 'AmrHR', 0, ''

GO  -- Manager InSide my Department and NOT HR Req.
EXEC ReviewRequest 'YasmeenHRTestingAmr', '2018-01-01', 'AmrNOTHrBUTReg', 0, 'BAD Timing'

GO  -- Manager InSide my Department and HR Req.
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
EXEC RemoveEmployeeFromProject 'YasmeenHRTestingAmr', 'Second Project', 'Regular7'

-- SELECT * FROM Project_Assignments


---- Number 8
GO
EXEC CreateNewTask 'YasmeenHRTestingAmr', '10th Task', 'The easy task', '2017/12/27' , 'Creating third new Project'


---- Number 9
GO  -- Will be Assigned to the task as he working on the same project of the task
EXEC AssignTask 'YasmeenHRTestingAmr', '10th Task', 'Creating third new Project', 'Regular7'

GO  -- Will NOT be Assigned to the task as he working on the same project of the task
EXEC AssignTask 'YasmeenHRTestingAmr', '10th Task', 'Creating third new Project', 'Regular1'


---- Number 10
GO
EXEC AddEmployeeToProject 'YasmeenHRTestingAmr', 'Creating third new Project', 'Regular8'

GO -- Will be changed
EXEC ChangeTaskEmployee 'YasmeenHRTestingAmr', 'Creating third new Project', '10th Task', 'Regular7', 'Regular8'

GO -- Will NOT be changed
EXEC ChangeTaskEmployee 'YasmeenHRTestingAmr', 'Creating third new Project', '10th Task', 'Regular7', 'Regular5'


---- Number 11
EXEC ViewProjectTasks 'YasmeenHRTestingAmr', 'Creating third new Project', 'Assigned' 


---- Number 12

-- Accepting the Task
GO
EXEC FinishedTask 'Regular8', '10th Task', 'Creating third new Project'
GO
EXEC ReviewTask 'YasmeenHRTestingAmr', 'Creating third new Project', '10th Task', 1, NULL


-- Rejecting the task
GO
EXEC CreateNewTask 'YasmeenHRTestingAmr', '11th Task', 'The easy task', '2017/12/27' , 'Creating third new Project'
GO
EXEC AssignTask 'YasmeenHRTestingAmr', '11th Task', 'Creating third new Project', 'Regular8'
GO
EXEC FinishedTask 'Regular8', '11th Task', 'Creating third new Project'
GO
EXEC ReviewTask 'YasmeenHRTestingAmr', 'Creating third new Project', '11th Task', 0, '2018/01/01'