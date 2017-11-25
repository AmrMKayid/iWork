USE iWork;

INSERT INTO Companies
VALUES ('google.com', 'Google', 'ceo@google.com', 'Mountain View, Santa Clara County, California, United States', 'International', 'organize the world''s information and make it universally accessible and useful', 'Technology company')

INSERT INTO Companies
VALUES ('facebook.com', 'Facebook', 'ceo@facebook.com', 'Menlo Park, California, United States', 'International', 'Connecting the world', 'Social Network Company')

INSERT INTO Companies
VALUES ('apple.com', 'Apple', 'ceo@apple.com', 'Cupertino, California, United States', 'International', 'Apple designs Macs, the best personal computers in the world, along with OS X, iLife, iWork and professional software', 'Technology Company')

INSERT INTO Companies
VALUES ('amazon.com', 'Amazon', 'ceo@amazon.com', 'Seattle, Washington, United States', 'International', 'to be earth''s most customer centric company', 'Electronic Commerce Company')

INSERT INTO Companies
VALUES ('tesla.com', 'Tesla', 'ceo@tesla.com', 'Palo Alto, California, United States', 'International', 'to accelerate the advent of sustainable transport', 'Automaker company')

INSERT INTO Company_Phones VALUES ('(+1) 10000001', 'google.com')
INSERT INTO Company_Phones VALUES ('(+1) 10000002', 'facebook.com')
INSERT INTO Company_Phones VALUES ('(+1) 10000003', 'apple.com')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

INSERT INTO Departments VALUES ('Android_OS', 'google.com', 'Android_Department')
INSERT INTO Departments VALUES ('G_Research', 'google.com', 'Research_Department')
INSERT INTO Departments VALUES ('Web_Dev'   , 'google.com', 'Web_Department')

INSERT INTO Departments VALUES ('FAIR'      , 'facebook.com', 'Facebook AI Research')
INSERT INTO Departments VALUES ('Mobile_Dev', 'facebook.com', 'Mobile Development')
INSERT INTO Departments VALUES ('Web_Dev'   , 'facebook.com', 'Web_Department')

INSERT INTO Departments VALUES ('iOS'       , 'apple.com', 'iOS_Department')
INSERT INTO Departments VALUES ('macOS'     , 'apple.com', 'macOS_Department')
INSERT INTO Departments VALUES ('iTV'       , 'apple.com', 'TV_Department')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- Google's Jobs
INSERT INTO Jobs VALUES ('Manager-Junior Software Engineering Manager', 'G_Research', 'google.com', 'Managing software department ', ' ', 12, 3, 25732, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-Software Engineering HR', 'G_Research', 'google.com', ' ', ' ', 12, 1, 15023, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Regular-Software Engineering', 'G_Research', 'google.com', ' ', ' ', 12, 3, 5732, 3, '2017/11/20')


INSERT INTO Jobs VALUES ('Manager-Junior Android Software Manager', 'Android_OS', 'google.com', ' ', ' ', 10, 3, 98430, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-Android HR', 'Android_OS', 'google.com', ' ', ' ', 10, 1, 11000, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Manager-Junior Web Development Manager', 'Web_Dev', 'google.com', ' ', ' ', 8, 3, 38954, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-Web Development HR', 'Web_Dev', 'google.com', ' ', ' ', 7, 1, 28543, 3, '2017/11/20')

-- Facebook's Jobs
INSERT INTO Jobs VALUES ('Manager-Junior Machine Learning Manager', 'FAIR', 'facebook.com', ' ', ' ', 12, 3, 62043, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Manager-Junior Artificial Intelligence Manager', 'FAIR', 'facebook.com', ' ', ' ', 12, 3, 12387, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-Software Engineering HR', 'FAIR', 'facebook.com', ' ', ' ', 12, 1, 17398, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Manager-Junior Android Software Manager', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 3, 75950, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Manager-Junior iOS Software Manager', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 3, 83645, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-Android HR', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 1, 23839, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-iOS HR', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 1, 45267, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Manager-Junior Web Development Manager', 'Web_Dev', 'facebook.com', ' ', ' ', 8, 3, 150294, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-Web Development HR', 'Web_Dev', 'facebook.com', ' ', ' ', 7, 1, 54928, 3, '2017/11/20')

INSERT INTO Questions VALUES ('Did you pass highschool?',1);
INSERT INTO Job_has_Questions VALUES ('Hr-Web Development HR', 'Web_Dev', 'facebook.com', 1);

-- Apple's Jobs
INSERT INTO Jobs VALUES ('Manager-Junior iOS Manager', 'iOS', 'apple.com', ' ', ' ', 12, 3, 346792, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-iOS HR', 'iOS', 'apple.com', ' ', ' ', 12, 1, 135792, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Manager-Junior macOS Software Manager', 'macOS', 'apple.com', ' ', ' ', 10, 3, 563846, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-macOS HR', 'macOS', 'apple.com', ' ', ' ', 10, 1, 579340, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Manager-Junior TV Development Manager', 'iTV', 'apple.com', ' ', ' ', 8, 3, 987123, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Hr-TV Development HR', 'iTV', 'apple.com', ' ', ' ', 7, 1, 34682, 3, '2017/11/20')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- Google -- => Research_Department
INSERT INTO Users VALUES ('AmrMKayid'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('AmrMKayid'    , 25732   , 'Monday'     , 37, 'Manager-Junior Software Engineering Manager', 'G_Research', 'google.com')
INSERT INTO Managers VALUES('AmrMKayid', 'Software Engineering')

INSERT INTO Users VALUES ('YasmeenKhaled' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('YasmeenKhaled'     ,  25732   , 'Sunday'     , 47, 'Manager-Junior Software Engineering Manager', 'G_Research', 'google.com')
INSERT INTO Managers VALUES('YasmeenKhaled', 'Software Engineering')

INSERT INTO Users VALUES ('Ahmed'         , 'Hello, World3', 'Ahmed@gmail.com'  , 'Ahmed'   , 'Mohamed', 'Ahmed', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('Ahmed'     , 15023   , 'Monday'     , 27, 'Hr-Software Engineering HR', 'G_Research', 'google.com')
INSERT INTO Hr_Employees VALUES('Ahmed')

INSERT INTO Users VALUES ('Mohamed'       , 'Hello, World4', 'Mohamed@gmail.com', 'Mohamed' , 'Ahmed'  , 'Ali', '1997/02/01', 1)
INSERT INTO Staff_Members VALUES ('Mohamed'     , 15023   , 'Saturday'     , 55, 'Hr-Software Engineering HR', 'G_Research', 'google.com')
INSERT INTO Hr_Employees VALUES('Mohamed')

------------------------------------------------------------------------------------
-- Google -- => Android_Department
INSERT INTO Users VALUES ('ShadiBarghash' , 'Hello, World3', 'shadi@gmail.com'  , 'Shadi'   , 'Ayman'  , 'Barghash', '1997/06/17', 3)
INSERT INTO Staff_Members VALUES ('ShadiBarghash'    , 98430   , 'Monday'     , 50, 'Manager-Junior Android Software Manager', 'Android_OS', 'google.com')
INSERT INTO Managers VALUES('ShadiBarghash', 'Senior')

INSERT INTO Users VALUES ('Mahmoud'       , 'Hello, World5', 'Mahmoud@gmail.com', 'Mahmoud' , 'Mohamed', 'Ahmed', '1997/03/10', 1)
INSERT INTO Staff_Members VALUES ('Mahmoud'     , 98430   , 'Tuesday'     , 34, 'Manager-Junior Android Software Manager', 'Android_OS', 'google.com')
INSERT INTO Managers VALUES('Mahmoud', 'Junior')

INSERT INTO Users VALUES ('Ali'           , 'Hello, World6', 'Ali@gmail.com'    , 'Ali'     , 'Mohamed', 'Ahmed', '1997/04/10', 5)
INSERT INTO Staff_Members VALUES ('Ali'    , 11000   , 'Sunday'     , 27, 'Hr-Android HR', 'Android_OS', 'google.com')
INSERT INTO Hr_Employees VALUES('Ali')

INSERT INTO Users VALUES ('Mohsen'        , 'Hello, World7', 'Mohsen@gmail.com' , 'Mohsen'  , 'Mohamed', 'Ahmed', '1997/05/10', 4)
INSERT INTO Staff_Members VALUES ('Mohsen'     , 11000   , 'Monday'     , 87, 'Hr-Android HR', 'Android_OS', 'google.com')
INSERT INTO Hr_Employees VALUES('Mohsen')

------------------------------------------------------------------------------------
-- Google -- => Web_Department
INSERT INTO Users VALUES ('Eyad'          , 'Hello, World8', 'Eyad@gmail.com'   , 'Eyad'    , 'Mohamed', 'Ahmed', '1997/06/10', 5)
INSERT INTO Staff_Members VALUES ('Eyad'     , 38954   , 'Monday'     , 50, 'Manager-Junior Web Development Manager', 'Web_Dev', 'google.com')
INSERT INTO Managers VALUES('Eyad', 'Junior')

INSERT INTO Users VALUES ('Mohab'         , 'Hello, World9', 'Mohab@gmail.com'  , 'Mohab'   , 'Mohamed', 'Ahmed', '1997/07/10', 6)
INSERT INTO Staff_Members VALUES ('Mohab'     , 38954   , 'Monday'     , 20, 'Manager-Junior Web Development Manager', 'Web_Dev', 'google.com')
INSERT INTO Managers VALUES('Mohab', 'Junior')

INSERT INTO Users VALUES ('Adel'          , 'Hello, World0', 'Adel@gmail.com'   , 'Adel'    , 'Mohamed', 'Ahmed', '1997/08/10', 9)
INSERT INTO Staff_Members VALUES ('Adel'    , 28543   , 'Sunday'     , 15, 'Hr-Web Development HR', 'Web_Dev', 'google.com')
INSERT INTO Hr_Employees VALUES('Adel')

INSERT INTO Users VALUES ('Sabry'         , 'Hello, World*', 'Sabry@gmail.com'  , 'Sabry'   , 'Mohamed', 'Ahmed', '1997/09/10', 10)
INSERT INTO Staff_Members VALUES ('Sabry'     , 28543   , 'Sunday'     , 80, 'Hr-Web Development HR', 'Web_Dev', 'google.com')
INSERT INTO Hr_Employees VALUES('Sabry')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- Facebook -- => Facebook AI Research
INSERT INTO Users VALUES ('AmrMKayid2'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('AmrMKayid2'     , 62043   , 'Monday'     , 37, 'Manager-Junior Machine Learning Manager', 'FAIR', 'facebook.com')
INSERT INTO Managers VALUES('AmrMKayid2', 'Senior')

INSERT INTO Users VALUES ('YasmeenKhaled2' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('YasmeenKhaled2'    , 12387   , 'Sunday'     , 47, 'Manager-Junior Artificial Intelligence Manager', 'FAIR', 'facebook.com')
INSERT INTO Managers VALUES('YasmeenKhaled2', 'Senior')

INSERT INTO Users VALUES ('Ahmed2'         , 'Hello, World3', 'Ahmed2@gmail.com'  , 'Ahmed2'   , 'Mohamed', 'Ahmed2', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('Ahmed2'    , 17398   , 'Monday'     , 27, 'Hr-Software Engineering HR', 'FAIR', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Ahmed2')

INSERT INTO Users VALUES ('Mohamed2'       , 'Hello, World4', 'Mohamed2@gmail.com', 'Mohamed2' , 'Ahmed'  , 'Ali', '1997/02/01', 1)
INSERT INTO Staff_Members VALUES ('Mohamed2'     , 17398   , 'Saturday'     , 55, 'Hr-Software Engineering HR', 'FAIR', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Mohamed2')

------------------------------------------------------------------------------------
-- Facebook -- => Mobile Development
INSERT INTO Users VALUES ('ShadiBarghash2' , 'Hello, World3', 'shadi@gmail.com'  , 'Shadi'   , 'Ayman'  , 'Barghash', '1997/06/17', 3)
INSERT INTO Staff_Members VALUES ('ShadiBarghash2'    , 75950   , 'Monday'     , 50, 'Manager-Junior Android Software Manager', 'Mobile_Dev', 'facebook.com')
INSERT INTO Managers VALUES('ShadiBarghash2', 'Senior')

INSERT INTO Users VALUES ('Mahmoud2'       , 'Hello, World5', 'Mahmoud2@gmail.com', 'Mahmoud2' , 'Mohamed', 'Ahmed', '1997/03/10', 1)
INSERT INTO Staff_Members VALUES ('Mahmoud2'    , 83645   , 'Tuesday'     , 34, 'Manager-Junior iOS Software Manager', 'Mobile_Dev', 'facebook.com')
INSERT INTO Managers VALUES('Mahmoud2', 'Junior')

INSERT INTO Users VALUES ('Ali2'           , 'Hello, World6', 'Ali2@gmail.com'    , 'Ali2'     , 'Mohamed', 'Ahmed', '1997/04/10', 5)
INSERT INTO Staff_Members VALUES ('Ali2'    , 23839   , 'Sunday'     , 27, 'Hr-Android HR', 'Mobile_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Ali2')

INSERT INTO Users VALUES ('Mohsen2'        , 'Hello, World7', 'Mohsen2@gmail.com' , 'Mohsen2'  , 'Mohamed', 'Ahmed', '1997/05/10', 4)
INSERT INTO Staff_Members VALUES ('Mohsen2'     , 45267   , 'Monday'     , 87, 'Hr-iOS HR', 'Mobile_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Mohsen2')

------------------------------------------------------------------------------------
-- Facebook -- => Web_Department
INSERT INTO Users VALUES ('Eyad2'          , 'Hello, World8', 'Eyad2@gmail.com'   , 'Eyad2'    , 'Mohamed', 'Ahmed', '1997/06/10', 5)
INSERT INTO Staff_Members VALUES ('Eyad2'     , 150294   , 'Monday'     , 50, 'Manager-Junior Web Development Manager', 'Web_Dev', 'facebook.com')
INSERT INTO Managers VALUES('Eyad2', 'Junior')

INSERT INTO Users VALUES ('Mohab2'         , 'Hello, World9', 'Mohab2@gmail.com'  , 'Mohab2'   , 'Mohamed', 'Ahmed', '1997/07/10', 6)
INSERT INTO Staff_Members VALUES ('Mohab2'     , 150294   , 'Monday'     , 20, 'Manager-Junior Web Development Manager', 'Web_Dev', 'facebook.com')
INSERT INTO Managers VALUES('Mohab2', 'Junior')

INSERT INTO Users VALUES ('Adel2'          , 'Hello, World0', 'Adel2@gmail.com'   , 'Adel2'    , 'Mohamed', 'Ahmed', '1997/08/10', 9)
INSERT INTO Staff_Members VALUES ('Adel2'    , 54928   , 'Sunday'     , 15, 'Hr-Web Development HR', 'Web_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Adel2')

INSERT INTO Users VALUES ('Sabry2'         , 'Hello, World*', 'Sabry2@gmail.com'  , 'Sabry2'   , 'Mohamed', 'Ahmed', '1997/09/10', 10)
INSERT INTO Staff_Members VALUES ('Sabry2'    , 54928   , 'Sunday'     , 80, 'Hr-Web Development HR', 'Web_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Sabry2')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- Apple -- => iOS_Department
INSERT INTO Users VALUES ('AmrMKayid3'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('AmrMKayid3'   , 346792   , 'Monday'     , 37, 'Manager-Junior iOS Manager', 'iOS', 'apple.com')
INSERT INTO Managers VALUES('AmrMKayid3', 'Senior')

INSERT INTO Users VALUES ('YasmeenKhaled3' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('YasmeenKhaled3'    , 346792   , 'Sunday'     , 47, 'Manager-Junior iOS Manager', 'iOS', 'apple.com')
INSERT INTO Managers VALUES('YasmeenKhaled3', 'Senior')

INSERT INTO Users VALUES ('Ahmed3'         , 'Hello, World3', 'Ahmed3@gmail.com'  , 'Ahmed3'   , 'Mohamed', 'Ahmed3', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('Ahmed3'     , 135792   , 'Monday'     , 27, 'Hr-iOS HR', 'iOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Ahmed3')

INSERT INTO Users VALUES ('Mohamed3'       , 'Hello, World4', 'Mohamed3@gmail.com', 'Mohamed3' , 'Ahmed'  , 'Ali', '1997/02/01', 1)
INSERT INTO Staff_Members VALUES ('Mohamed3'     ,  135792   , 'Saturday'     , 55, 'Hr-iOS HR', 'iOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Mohamed3')

------------------------------------------------------------------------------------
-- Apple -- => macOS_Department
INSERT INTO Users VALUES ('ShadiBarghash3' , 'Hello, World3', 'shadi@gmail.com'  , 'Shadi'   , 'Ayman'  , 'Barghash', '1997/06/17', 3)
INSERT INTO Staff_Members VALUES ('ShadiBarghash3'    , 563846   , 'Monday'     , 50, 'Manager-Junior macOS Software Manager', 'macOS', 'apple.com')
INSERT INTO Managers VALUES('ShadiBarghash3', 'Senior')

INSERT INTO Users VALUES ('Mahmoud3'       , 'Hello, World5', 'Mahmoud3@gmail.com', 'Mahmoud3' , 'Mohamed', 'Ahmed', '1997/03/10', 1)
INSERT INTO Staff_Members VALUES ('Mahmoud3'    , 563846   , 'Tuesday'     , 34, 'Manager-Junior macOS Software Manager', 'macOS', 'apple.com')
INSERT INTO Managers VALUES('Mahmoud3', 'Junior')

INSERT INTO Users VALUES ('Ali3'           , 'Hello, World6', 'Ali3@gmail.com'    , 'Ali3'     , 'Mohamed', 'Ahmed', '1997/04/10', 5)
INSERT INTO Staff_Members VALUES ('Ali3'     , 579340   , 'Sunday'     , 27, 'Hr-macOS HR', 'macOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Ali3')

INSERT INTO Users VALUES ('Mohsen3'        , 'Hello, World7', 'Mohsen3@gmail.com' , 'Mohsen3'  , 'Mohamed', 'Ahmed', '1997/05/10', 4)
INSERT INTO Staff_Members VALUES ('Mohsen3'    , 579340   , 'Monday'     , 87, 'Hr-macOS HR', 'macOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Mohsen3')

------------------------------------------------------------------------------------
-- Apple -- => TV_Department
INSERT INTO Users VALUES ('Eyad3'          , 'Hello, World8', 'Eyad3@gmail.com'   , 'Eyad3'    , 'Mohamed', 'Ahmed', '1997/06/10', 5)
INSERT INTO Staff_Members VALUES ('Eyad3'     , 987123   , 'Monday'     , 50, 'Manager-Junior TV Development Manager', 'iTV', 'apple.com')
INSERT INTO Managers VALUES('Eyad3', 'Junior')

INSERT INTO Users VALUES ('Mohab3'         , 'Hello, World9', 'Mohab2@gmail.com'  , 'Mohab3'   , 'Mohamed', 'Ahmed', '1997/07/10', 6)
INSERT INTO Staff_Members VALUES ('Mohab3'    , 987123   , 'Monday'     , 20, 'Manager-Junior TV Development Manager', 'iTV', 'apple.com')
INSERT INTO Managers VALUES('Mohab3', 'Junior')

INSERT INTO Users VALUES ('Adel3'          , 'Hello, World0', 'Adel3@gmail.com'   , 'Adel3'    , 'Mohamed', 'Ahmed', '1997/08/10', 9)
INSERT INTO Staff_Members VALUES ('Adel3'    , 34682   , 'Sunday'     , 15, 'Hr-TV Development HR', 'iTV', 'apple.com')
INSERT INTO Hr_Employees VALUES('Adel3')

INSERT INTO Users VALUES ('Sabry3'         , 'Hello, World*', 'Sabry3@gmail.com'  , 'Sabry3'   , 'Mohamed', 'Ahmed', '1997/09/10', 10)
INSERT INTO Staff_Members VALUES ('Sabry3'    , 34682   , 'Sunday'     , 80, 'Hr-TV Development HR', 'iTV', 'apple.com')
INSERT INTO Hr_Employees VALUES('Sabry3')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----


---- ##### ##### ##### ##### ##### ##### ##### #####  Yasmeen Data  ##### ##### ##### #####  ##### ##### ##### ##### -----
INSERT INTO Users VALUES ('Maza'  , 'Hello, World*', 'Maza@gmail.com'  , 'Maza'   , 'Mohamed', 'Ahmed', '1997/09/10', 10);
Insert into Applicants values('Maza');

INSERT INTO Users VALUES ('Maza1'  , 'Hello, World*', 'Maza1@gmail.com'  , 'Maza'   , 'Mohamed', 'Ahmed', '1997/09/10', 10);
Insert into Applicants values('Maza1');
INSERT INTO Users VALUES ('Maza2'  , 'Hello, World*', 'Maza2@gmail.com'  , 'Maza'   , 'Mohamed', 'Ahmed', '1997/09/10', 10);
Insert into Applicants values('Maza2');
INSERT INTO Users VALUES ('Maza7'  , 'Hello, World*', 'Maza2@gmail.com'  , 'Maza'   , 'Mohamed', 'Ahmed', '1997/09/10', 10);
Insert into Applicants values('Maza7');

INSERT INTO Users VALUES ('editingtrial'  , 'Hello, World*', 'Maza@gmail.com'  , 'Maza'   , 'Mohamed', 'Ahmed', '1997/09/10', 10);

INSERT INTO User_Previous_Job_Titles values('Manger @CGG','editingtrial')

Insert into Attendance_Records values('Adel','2017/10/17','03:49:00','05:49:00',2,5);
Insert into Attendance_Records values('Adel','2017/10/18','03:49:00','05:49:00',2,5);
Insert into Attendance_Records values('Adel','2017/10/19','03:49:00','05:49:00',2,5);
Insert into Attendance_Records values('Adel','2017/10/20','03:49:00','05:49:00',2,5);
Insert into Attendance_Records values('Adel','2017/10/21','03:49:00','05:49:00',2,5);

Insert into Applications values(90,'Accepted','Pending','Hr-Android HR','Android_OS','google.com','Maza','Mohamed',null);

Insert into Applications values(90,'Accepted','Accepted','Hr-Android HR','Android_OS','google.com','Maza2','Mohamed','ShadiBarghash');
Insert into Applications values(90,'Accepted','Accepted','Hr-Android HR','Mobile_Dev','facebook.com','Maza2','Mohsen2','Mahmoud2');
Insert into Applications values(90,'Accepted','Accepted','Hr-iOS HR','iOS','apple.com','Maza2','Mohamed3','AmrMKayid3');

Insert into Applications values(90,'pending','pending','Hr-Android HR','Android_OS','google.com','Maza1',null,null);
Insert into Applications values(90,'Accepted','pending','Hr-iOS HR','iOS','apple.com','Maza1','Mohamed3',null);


--- Regular Employee
--------->>>>>>>>>>>>>>>> Two HR Ahmed & Mohamed ^^^^

INSERT INTO Users VALUES ('Regular1' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('Regular1'     ,  175735   , 'Sunday'     , 47, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('Regular1')

-- ########################## --
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/11/20', '8:15:00', '7:00:00', 11.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/11/21', '10:15:00', '1:00:00', 2.45, 0)
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/11/22', '12:15:00', '5:30:00', 5.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/11/23', '9:15:00', '4:15:00', 6.30, 0)
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/11/24', '6:15:00', '1:40:00', 7, 0)
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/12/24', '6:15:00', '1:40:00', 7, 0)
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/01/24', '6:15:00', '1:40:00', 7, 0)
INSERT INTO Attendance_Records VALUES ('Regular1', '2017/07/24', '6:15:00', '1:40:00', 7, 0)


INSERT INTO Projects VALUES ('First Project', 'google.com', '2017/11/15'   , '2017/11/30' , 'AmrMKayid')
INSERT INTO Project_Assignments VALUES ('First Project', 'google.com', 'Regular1' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('First Task', 'The easy task', 'fixed'   , '2017/11/27' , 'First Project', 'google.com', 'Regular1' , 'AmrMKayid')
-- ########################## --

INSERT INTO Users VALUES ('Regular2' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('Regular2'     ,  32489670   , 'Monday'     , 47, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('Regular2')

-- ########################## --
INSERT INTO Attendance_Records VALUES ('Regular2', '2017/11/23', '8:15:00', '7:00:00', 11.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular2', '2017/11/24', '10:15:00', '1:00:00', 2.45, 0)
INSERT INTO Attendance_Records VALUES ('Regular2', '2017/11/22', '12:15:00', '5:30:00', 5.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular2', '2017/11/25', '9:15:00', '4:15:00', 6.30, 0)
INSERT INTO Attendance_Records VALUES ('Regular2', '2017/11/27', '7:15:00', '1:40:00', 6.25, 0)

-- INSERT INTO Projects VALUES ('First Project', 'google.com', '2017/11/15'   , '2017/11/30' , 'AmrMKayid')
INSERT INTO Project_Assignments VALUES ('First Project', 'google.com', 'Regular2' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('Second Task', 'The 2nd easy task', 'fixed'   , '2017/11/27' , 'First Project', 'google.com', 'Regular2' , 'AmrMKayid')
-- ########################## --

INSERT INTO Users VALUES ('Regular3' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('Regular3'     ,  65845   , 'Tuesday'     , 47, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('Regular3')

-- ########################## --
INSERT INTO Attendance_Records VALUES ('Regular3', '2017/11/25', '8:15:00', '12:00:00', 3.45, 0)
INSERT INTO Attendance_Records VALUES ('Regular3', '2017/11/21', '10:15:00', '3:15:00', 4, 0)
INSERT INTO Attendance_Records VALUES ('Regular3', '2017/11/29', '12:15:00', '5:30:00', 5.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular3', '2017/11/27', '9:15:00', '2:15:00', 4.30, 0)
INSERT INTO Attendance_Records VALUES ('Regular3', '2017/11/23', '6:15:00', '1:40:00', 7.25, 0)

INSERT INTO Projects VALUES ('Second Project', 'google.com', '2017/11/15'   , '2017/11/25' , 'AmrMKayid')
INSERT INTO Project_Assignments VALUES ('Second Project', 'google.com', 'Regular3' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('First Task', 'The easy task', 'fixed'   , '2017/11/23' , 'Second Project', 'google.com', 'Regular3' , 'AmrMKayid')
-- ########################## --

INSERT INTO Users VALUES ('Regular4' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('Regular4'     ,  497082   , 'Saturday'     , 47, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('Regular4')

-- ########################## --
INSERT INTO Attendance_Records VALUES ('Regular4', '2017/11/22', '8:15:00', '4:00:00', 8.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular4', '2017/11/21', '10:15:00', '4:00:00', 5.45, 0)
INSERT INTO Attendance_Records VALUES ('Regular4', '2017/11/27', '12:15:00', '3:30:00', 2.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular4', '2017/11/23', '9:15:00', '4:15:00', 6.30, 0)
INSERT INTO Attendance_Records VALUES ('Regular4', '2017/11/28', '6:15:00', '1:40:00', 7, 0)

-- INSERT INTO Projects VALUES ('Second Project', 'google.com', '2017/11/15'   , '2017/11/25' , 'AmrMKayid')
INSERT INTO Project_Assignments VALUES ('Second Project', 'google.com', 'Regular4' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('2nd Task', 'The easy task', 'fixed'   , '2017/11/23' , 'Second Project', 'google.com', 'Regular4' , 'AmrMKayid')

INSERT INTO Tasks VALUES ('6th Task', 'The easy task', 'Assigned'   , '2017/11/23' , 'Second Project', 'google.com', 'Regular3' , 'AmrMKayid')

-- ########################## --

INSERT INTO Users VALUES ('Regular5' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('Regular5'     ,  638745   , 'Monday'     , 47, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('Regular5')

-- ########################## --
INSERT INTO Attendance_Records VALUES ('Regular5', '2017/11/25', '8:15:00', '7:00:00', 11.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular5', '2017/11/21', '10:15:00', '1:00:00', 2.45, 0)
INSERT INTO Attendance_Records VALUES ('Regular5', '2017/11/29', '12:15:00', '5:30:00', 5.25, 0)
INSERT INTO Attendance_Records VALUES ('Regular5', '2017/11/27', '9:15:00', '4:15:00', 6.30, 0)
INSERT INTO Attendance_Records VALUES ('Regular5', '2017/11/24', '6:15:00', '1:40:00', 7, 0)

INSERT INTO Attendance_Records VALUES ('Regular5', '2017/10/24', '6:15:00', '1:40:00', 7, 0)


-- INSERT INTO Projects VALUES ('Second Project', 'google.com', '2017/11/15'   , '2017/11/25' , 'AmrMKayid')
INSERT INTO Project_Assignments VALUES ('Second Project', 'google.com', 'Regular5' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('5thTask', 'finaltask', 'fixed'   , '2017/11/23' , 'Second Project', 'google.com', 'Regular5' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('8thTask', 'finaltask', 'fixed'   , '2017/10/23' , 'Second Project', 'google.com', 'Regular5' , 'AmrMKayid')


-- ########################## --

---- ##### ##### ##### ##### ##### ##### ##### #####  Yasmeen Data  ##### ##### ##### #####  ##### ##### ##### ##### -----



---- ##### ##### ##### ##### ##### ##### ##### #####  Amr Data  ##### ##### ##### #####  ##### ##### ##### ##### -----

-- INSERT INTO Project_Assignments VALUES ('Second Project', 'google.com', 'Regular1' , 'AmrMKayid') -- Testing Amr

------ Regular Employee Testing
INSERT INTO Users VALUES ('Regular7' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('Regular7'     ,  175735   , 'Sunday'     , 47, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('Regular7')

INSERT INTO Project_Assignments VALUES ('Second Project', 'google.com', 'Regular7' , 'AmrMKayid')

---- TOTEST: Number 3
INSERT INTO Tasks VALUES ('AssignedAmr''sTask', 'Test FinishedTask', 'Assigned'   , '2018/01/10' , 'Second Project', 'google.com', 'Regular7' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('FixedAmr''sTask', 'Test FinishedTask', 'Fixed'   , '2018/01/10' , 'Second Project', 'google.com', 'Regular7' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('AssignedAmr''sTaskAfterDeadline', 'Test FinishedTask', 'Assigned'   , '2017/01/10' , 'Second Project', 'google.com', 'Regular7' , 'AmrMKayid')

---- TOTEST: Number 4
INSERT INTO Tasks VALUES ('Number4Case1', 'Test FinishedTask', 'Fixed'   , '2018/01/10' , 'Second Project', 'google.com', 'Regular7' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('Number4Case2', 'Test FinishedTask', 'Closed'   , '2018/01/10' , 'Second Project', 'google.com', 'Regular7' , 'AmrMKayid')
INSERT INTO Tasks VALUES ('Number4Case3', 'Test FinishedTask', 'Fixed'   , '2017/01/10' , 'Second Project', 'google.com', 'Regular7' , 'AmrMKayid')


------ Manager Testing

---- TOTEST: Number 1
INSERT INTO Users VALUES ('YasmeenHRTestingAmr'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('YasmeenHRTestingAmr'    , 25732   , 'Monday'     , 37, 'Manager-Junior Software Engineering Manager', 'G_Research', 'google.com')
INSERT INTO Managers VALUES('YasmeenHRTestingAmr', 'HR')

INSERT INTO Users VALUES ('AmrHR'         , 'Hello, World3', 'Ahmed@gmail.com'  , 'Ahmed'   , 'Mohamed', 'Ahmed', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('AmrHR'     , 15023   , 'Monday'     , 27, 'Hr-Software Engineering HR', 'G_Research', 'google.com')
INSERT INTO Hr_Employees VALUES('AmrHR')

INSERT INTO Users VALUES ('YasmeenNOTHRTestingAmr'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('YasmeenNOTHRTestingAmr'    , 25732   , 'Monday'     , 37, 'Manager-Junior Software Engineering Manager', 'G_Research', 'google.com')
INSERT INTO Managers VALUES('YasmeenNOTHRTestingAmr', '!HR')

INSERT INTO Users VALUES ('AmrNOTHrBUTReg'         , 'Hello, World3', 'Ahmed@gmail.com'  , 'Ahmed'   , 'Mohamed', 'Ahmed', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('AmrNOTHrBUTReg'     , 15023   , 'Monday'     , 27, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('AmrNOTHrBUTReg')

----- New Requests
-- HR Request
INSERT INTO Requests(start_date, username, request_date, end_date) VALUES ('2018/01/01', 'AmrHR', '2017/11/20'  , '2018/09/01')
-- NOT HR Request BUT Regular_Employees
INSERT INTO Requests(start_date, username, request_date, end_date) VALUES ('2018/01/01', 'AmrNOTHrBUTReg', '2017/11/20'  , '2018/09/01') 


----- View Applications
INSERT INTO Users VALUES ('AmrApplicant1', 'Hello, World!', 'amr@gmail.com', 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Applicants VALUES('AmrApplicant1')

INSERT INTO Users VALUES ('AmrApplicant2', 'Hello, World!', 'amr@gmail.com', 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Applicants VALUES('AmrApplicant2')

INSERT INTO Applications(job_title, department, company, app_username, score, hr_status) VALUES('Manager-Junior Software Engineering Manager', 'G_Research', 'google.com', 'AmrApplicant1', 10, 'ACCEPTED')
INSERT INTO Applications(job_title, department, company, app_username, score, hr_status) VALUES('Manager-Junior Software Engineering Manager', 'G_Research', 'google.com', 'AmrApplicant2', 70, 'ACCEPTED')


INSERT INTO Users VALUES ('RegEmpWithNoTasks'         , 'Hello, World3', 'Ahmed@gmail.com'  , 'Ahmed'   , 'Mohamed', 'Ahmed', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('RegEmpWithNoTasks'     , 15023   , 'Monday'     , 27, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('RegEmpWithNoTasks')

INSERT INTO Project_Assignments VALUES ('First Project', 'google.com', 'RegEmpWithNoTasks' , 'YasmeenHRTestingAmr')


--- Change Task Employee
INSERT INTO Users VALUES ('Regular8' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('Regular8'     ,  175735   , 'Sunday'     , 47, 'Regular-Software Engineering', 'G_Research', 'google.com')
INSERT INTO Regular_Employees VALUES('Regular8')


-- ---- ##### ##### ##### ##### ##### ##### ##### #####  Amr Data  ##### ##### ##### #####  ##### ##### ##### ##### -----
-- ###############################################################################################################

-- Company "Runtastic"
INSERT INTO Companies VALUES ('runtastic.com', 'Runtastic', 'info@runtastic.com', 'Linz, Austria', 'International', 'Healthy lifestyle', 'Fitness App');

-- Department "App Development" in Runtastic
INSERT INTO Departments VALUES ('AppDev', 'runtastic.com', 'App Development');

-- Job "Windows App Programmer"
INSERT INTO Jobs VALUES ('Regular Employee - Windows App Programmer', 'AppDev', 'runtastic.com', 'Programs Runtastic App for the Windows platform', 'Programs Runtastic App for the Windows platform bardo. Ah, Windows (Phone) 8.1, w Windows UWP (10 for all devices)', 5, 4, 2000, 2, '2018-12-12');

-- RegE: Shadi Barghash
INSERT INTO Users VALUES ('shadi.barghash', 'ayy7agaPassword:"D', 'shady.barghash@outlook.com', 'Shadi', 'Ayman', 'Barghash', '1997-06-17', 6);
INSERT INTO Staff_Members VALUES ('shadi.barghash', 2500, 'Saturday', 26, 'Regular Employee - Windows App Programmer', 'AppDev', 'runtastic.com');
INSERT INTO Regular_Employees VALUES ('shadi.barghash');

INSERT INTO User_Previous_Job_Titles VALUES ('Windows App Developer (Founder) at GUCian App', 'shadi.barghash');
INSERT INTO User_Previous_Job_Titles VALUES ('UWP Developer at Vditory (Award Winner)', 'shadi.barghash');
INSERT INTO User_Previous_Job_Titles VALUES ('Windows App Developer at Whisperings', 'shadi.barghash');
INSERT INTO User_Previous_Job_Titles VALUES ('Software Developer at Exams Miner for IGCSE', 'shadi.barghash');

-- Job "iOS Developer"
INSERT INTO Jobs VALUES ('Regular Employee - iOS Developer', 'AppDev', 'runtastic.com', 'Programs Runtastic App for the iOS', 'Programs Runtastic App for iOS bardo.', 5, 4, 2000, 2, '2018-12-12');

-- RegE: Daniel Achraf
INSERT INTO Users VALUES ('danial.ashraf', 'haHaha2Password_xD', 'danial.ashraf@outlook.com', 'Daniel', 'Achraf', 'Daniel''s Family', '1996-07-14', 6);
INSERT INTO Staff_Members VALUES ('danial.ashraf', 2500, 'Sunday', 20, 'Regular Employee - iOS Developer', 'AppDev', 'runtastic.com');
INSERT INTO Regular_Employees VALUES ('danial.ashraf');

-- Job "AppDevHR"
INSERT INTO Jobs VALUES ('HR Employee - App Dev', 'AppDev', 'runtastic.com', 'Manages HR for App Dev department.', 'Manages HR for App Dev department. bardo.', 5, 4, 2000, 2, '2018-12-12');

-- HR 1: Nourhane Ali
INSERT INTO Users VALUES ('nourAli', 'YeaYea!Password_xD', 'nour_ali@outlook.com', 'Nourhane', 'Ali', 'Nour''s Fam', '1997-06-14', 4);
INSERT INTO Staff_Members VALUES ('nourAli', 2500, 'Monday', 20, 'HR Employee - App Dev', 'AppDev', 'runtastic.com');
INSERT INTO Hr_Employees VALUES ('nourAli');

-- HR 2: Liza Charles
INSERT INTO Users VALUES ('lizaCharles', 'xD', 'lizaCharles@outlook.com', 'Liza', NULL, 'Charles', '1997-06-14', 4);
INSERT INTO Staff_Members VALUES ('lizaCharles', 2500, 'Monday', 20, 'HR Employee - App Dev', 'AppDev', 'runtastic.com');
INSERT INTO Hr_Employees VALUES ('lizaCharles');

-- Announcements:
INSERT INTO Announcements VALUES ('Running', '2017-12-20', 'Sports Activity', 'We''ll run 4km in Linz on Saturday, 2/1/2018. Location is a surprise.', 'nourAli');
INSERT INTO Announcements VALUES ('Annual Meeting', '2017-11-01', 'Conference', 'In this annual conference, we encourage all employees to attend and celebrate our achievements of the year.', 'nourAli');
INSERT INTO Announcements VALUES ('Running Sponsor', '2017-09-01', 'Event Sponsorship', 'We were invited by a group of GUC in Berlin to join them in their run as a sponsor.', 'nourAli');

-- Job "Delivery Manager"
INSERT INTO Jobs VALUES ('Manager - Senior Projects Manager', 'AppDev', 'runtastic.com', 'Manages project delivery for App Dev department.', 'Manages project delivery for App Dev department. bardoo.', 5, 4, 2000, 2, '2018-12-12');

-- Manager 1: Nesrine Anwar
INSERT INTO Users VALUES ('nesrine.anwarr', 'Family<3', 'nesrine.anwar@outlook.com', 'Nesrine', 'Anwar', 'Abd El Khalek', '1972-09-14', 25);
INSERT INTO Staff_Members VALUES ('nesrine.anwarr', 5000, 'Saturday', 28, 'Manager - Senior Projects Manager', 'AppDev', 'runtastic.com');
INSERT INTO Managers VALUES ('nesrine.anwarr', 'Projects');

-- Manager 2: Wael Fakharany
INSERT INTO Users VALUES ('waelFakh', 'Fakh:', 'waelFakh@outlook.com', 'Wael', NULL, 'Fakharany', '1972-09-14', 25);
INSERT INTO Staff_Members VALUES ('waelFakh', 5000, 'Saturday', 28, 'Manager - Senior Projects Manager', 'AppDev', 'runtastic.com');
INSERT INTO Managers VALUES ('waelFakh', 'Projects');

-- Requests
INSERT INTO Requests (start_date, end_date, username, manager_status, mang_username)
VALUES ('2018-01-01', '2018-01-10', 'danial.ashraf', 'ACCEPTED', 'nesrine.anwarr');
INSERT INTO Leave_Requests VALUES ('2018-01-01', 'danial.ashraf', 'annual');
INSERT INTO Request_Regular_Employee_Replace VALUES ('2018-01-01', 'danial.ashraf', 'shadi.barghash');

INSERT INTO Requests (start_date, end_date, username, manager_status, mang_username)
VALUES ('2018-01-20', '2018-01-22', 'shadi.barghash', 'ACCEPTED', 'nesrine.anwarr');
INSERT INTO Leave_Requests VALUES ('2018-01-20', 'shadi.barghash', 'annual');
INSERT INTO Request_Regular_Employee_Replace VALUES ('2018-01-20', 'shadi.barghash', 'danial.ashraf');

-- Emails
INSERT INTO Emails VALUES ('Finished my part', 'I''ve just finished my part from Windows-iOS P2P comm.', NULL);
INSERT INTO Staff_send_Email VALUES (1, 'nesrine.anwarr', 'shadi.barghash');
INSERT INTO Staff_send_Email VALUES (1, 'danial.ashraf', 'shadi.barghash');

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Department "Business Development" in Runtastic
INSERT INTO Departments VALUES ('BusinessDevelopment', 'runtastic.com', 'Business Development');

-- Job "HR Employee - Motivation"
INSERT INTO Jobs VALUES ('HR Employee - Motivation', 'BusinessDevelopment', 'runtastic.com', 'Motivates other employees in the department.', 'We need more HR motivation employees to motivate employees even more!', 3, 3, 2000, 4, '2017-11-25')

-- HR 1: Shadwa
INSERT INTO Users VALUES ('shadwa-barghash', 'shadwy', 'shadwa-ayman@hotmail.com', 'Shadwa', 'Ayman', 'Barghash', '1997-06-17', 4);
INSERT INTO Staff_Members VALUES ('shadwa-barghash', 3500, 'Saturday', 28, 'HR Employee - Motivation', 'BusinessDevelopment', 'runtastic.com');
INSERT INTO Hr_Employees VALUES ('shadwa-barghash');

-- HR 2: Nevine
INSERT INTO Users VALUES ('NevyAnwar', 'nevy', 'nevy-anwar@hotmail.com', 'Nevine', 'Anwar', 'Abd-El-Khalek', '1974-06-17', 4);
INSERT INTO Staff_Members VALUES ('NevyAnwar', 3500, 'Saturday', 28, 'HR Employee - Motivation', 'BusinessDevelopment', 'runtastic.com');
INSERT INTO Hr_Employees VALUES ('NevyAnwar');

-- Job Seeker 1: Mariam Hussein
INSERT INTO Users VALUES ('mariam-hussein', 'mairam', 'mariam-hussein@outlook.com', 'Mariam', NULL, 'Hussein', '1997-07-18', 3)
INSERT INTO Applicants VALUES ('mariam-hussein');

-- Job Applications for "HR Employee - Motivation"
INSERT INTO Applications (app_username, score, job_title, department, company)
VALUES ('mariam-hussein', 95, 'HR Employee - Motivation', 'BusinessDevelopment', 'runtastic.com');

-- Job Seeker 2: Mohamed Sharkawy
INSERT INTO Users VALUES ('moh-sharkawy', 'MMEESHOOOHh', 'moh-sharkawyy@outlook.com', 'Mohamed', NULL, 'Sharkawy', '1997-07-18', 3)
INSERT INTO Applicants VALUES ('moh-sharkawy');

-- Job Applications for "HR Employee - Motivation"
INSERT INTO Applications (app_username, score, job_title, department, company)
VALUES ('moh-sharkawy', 85, 'HR Employee - Motivation', 'BusinessDevelopment', 'runtastic.com');

-- Job "Junior Strategic Planner"

INSERT INTO Jobs VALUES ('Manager - Junior Strategic Planner', 'BusinessDevelopment', 'runtastic.com', 'Beyebher el nas', '3ashan da baheer akho samir w shahir', 3, 3, 2000, 2, '2018-02-02');

-- Manager 1: Sameer
INSERT INTO Users VALUES ('samir.sameer', 'sem0', 'samir_spOt@yahoo.com', 'Sameer', 'Sameer', 'Sameer', '1980-01-22', 4);
INSERT INTO Staff_Members VALUES ('samir.sameer', 3500, 'Thursday', 15, 'Manager - Junior Strategic Planner', 'BusinessDevelopment', 'runtastic.com');
INSERT INTO Managers VALUES ('samir.sameer', 'Strategic');

-- Manager 1: Baheer
INSERT INTO Users VALUES ('baheer.elKhateer', 'gamedBass!!', 'baheer_elkhatir@yahoo.com', 'Baheer', 'Mounir', 'El-Khatir', '1980-02-29', 4);
INSERT INTO Staff_Members VALUES ('baheer.elKhateer', 3500, 'Thursday', 15, 'Manager - Junior Strategic Planner', 'BusinessDevelopment', 'runtastic.com');
INSERT INTO Managers VALUES ('baheer.elKhateer', 'Strategic');

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

INSERT INTO Departments VALUES ('PR+Marketing', 'runtastic.com', 'PR and Marketing');

INSERT INTO Jobs VALUES ('Senior Marketing Manager', 'PR+Marketing', 'runtastic.com', 'Manages Marketing campaigns', 'What can be said more than what have been said', 3, 3, 2000, 2, '2018-03-15');

-- Manager 1: Nagham
INSERT INTO Users VALUES ('naghouma', 'aywaYaSa7by', 'nagham@hotmail.com', 'Nagham', 'Ayman', 'Barghash', '1995-05-17', 4);
INSERT INTO Staff_Members VALUES ('naghouma', 3500, 'Sunday', 20, 'Senior Marketing Manager', 'PR+Marketing', 'runtastic.com');
INSERT INTO Managers VALUES ('naghouma', 'Marketing');

-- Manager 2: Yomna
INSERT INTO Users VALUES ('yomna', 'aywaYaSa7by', 'yomna@hotmail.com', 'Yomna', '', '', '1995-05-17', 4);
INSERT INTO Staff_Members VALUES ('yomna', 3500, 'Sunday', 20, 'Senior Marketing Manager', 'PR+Marketing', 'runtastic.com');
INSERT INTO Managers VALUES ('yomna', 'Marketing');

INSERT INTO Jobs VALUES ('HR Employee - PR and Marketing HR', 'PR+Marketing', 'runtastic.com', 'Manages HR inside PR and Marketing department', 'Hmm yes that''s all', 3, 3, 2000, 2, '2018-01-18');

-- HR 1: Ahmed Kassed
INSERT INTO Users VALUES ('elkassed', 'aywaYaSa7by', 'elkassed@hotmail.com', 'Ahmed', '', 'El Kassed', '1995-05-17', 4);
INSERT INTO Staff_Members VALUES ('elkassed', 3500, 'Sunday', 20, 'HR Employee - PR and Marketing HR', 'PR+Marketing', 'runtastic.com');
INSERT INTO Hr_Employees VALUES ('elkassed');

-- HR 2: Mostafa Shalaby
INSERT INTO Users VALUES ('mostafa_shalaby', 'aywaYaSa7by', 'mostafa_shalaby@hotmail.com', 'Mostafa', 'Mahmoud', 'Shalaby', '1995-05-17', 4);
INSERT INTO Staff_Members VALUES ('mostafa_shalaby', 3500, 'Sunday', 20, 'HR Employee - PR and Marketing HR', 'PR+Marketing', 'runtastic.com');
INSERT INTO Hr_Employees VALUES ('mostafa_shalaby');

-- ###############################################################################################################