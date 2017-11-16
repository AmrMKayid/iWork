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
INSERT INTO Jobs VALUES ('Software Engineering Manager', 'G_Research', 'google.com', ' ', ' ', 12, 3, 173000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Software Engineering HR', 'G_Research', 'google.com', ' ', ' ', 12, 1, 15000, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Android Software Manager', 'Android_OS', 'google.com', ' ', ' ', 10, 3, 183000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Android HR', 'Android_OS', 'google.com', ' ', ' ', 10, 1, 11000, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Web Development Manager', 'Web_Dev', 'google.com', ' ', ' ', 8, 3, 18000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Web Development HR', 'Web_Dev', 'google.com', ' ', ' ', 7, 1, 12000, 3, '2017/11/20')

-- Facebook's Jobs
INSERT INTO Jobs VALUES ('Machine Learning Manager', 'FAIR', 'facebook.com', ' ', ' ', 12, 3, 173000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Artificial Intelligence Manager', 'FAIR', 'facebook.com', ' ', ' ', 12, 3, 173000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Software Engineering HR', 'FAIR', 'facebook.com', ' ', ' ', 12, 1, 15000, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Android Software Manager', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 3, 183000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('iOS Software Manager', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 3, 183000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Android HR', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 1, 11000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('iOS HR', 'Mobile_Dev', 'facebook.com', ' ', ' ', 10, 1, 11000, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('Web Development Manager', 'Web_Dev', 'facebook.com', ' ', ' ', 8, 3, 18000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('Web Development HR', 'Web_Dev', 'facebook.com', ' ', ' ', 7, 1, 12000, 3, '2017/11/20')


-- Apple's Jobs
INSERT INTO Jobs VALUES ('iOS Manager', 'iOS', 'apple.com', ' ', ' ', 12, 3, 173000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('iOS HR', 'iOS', 'apple.com', ' ', ' ', 12, 1, 15000, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('macOS Software Manager', 'macOS', 'apple.com', ' ', ' ', 10, 3, 183000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('macOS HR', 'macOS', 'apple.com', ' ', ' ', 10, 1, 11000, 3, '2017/11/20')

INSERT INTO Jobs VALUES ('TV Development Manager', 'iTV', 'apple.com', ' ', ' ', 8, 3, 18000, 3, '2017/11/20')
INSERT INTO Jobs VALUES ('TV Development HR', 'iTV', 'apple.com', ' ', ' ', 7, 1, 12000, 3, '2017/11/20')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- Google -- => Research_Department
INSERT INTO Users VALUES ('AmrMKayid'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('AmrMKayid'     , 175735   , 'Friday'     , 37, 'Software Engineering Manager', 'G_Research', 'google.com')
INSERT INTO Managers VALUES('AmrMKayid', 'Senior')

INSERT INTO Users VALUES ('YasmeenKhaled' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('YasmeenKhaled'     , 175735   , 'Sunday'     , 47, 'Software Engineering Manager', 'G_Research', 'google.com')
INSERT INTO Managers VALUES('YasmeenKhaled', 'Senior')

INSERT INTO Users VALUES ('Ahmed'         , 'Hello, World3', 'Ahmed@gmail.com'  , 'Ahmed'   , 'Mohamed', 'Ahmed', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('Ahmed'     , 17573   , 'Monday'     , 27, 'Software Engineering HR', 'G_Research', 'google.com')
INSERT INTO Hr_Employees VALUES('Ahmed')

INSERT INTO Users VALUES ('Mohamed'       , 'Hello, World4', 'Mohamed@gmail.com', 'Mohamed' , 'Ahmed'  , 'Ali', '1997/02/01', 1)
INSERT INTO Staff_Members VALUES ('Mohamed'     , 15735   , 'Saturday'     , 55, 'Software Engineering HR', 'G_Research', 'google.com')
INSERT INTO Hr_Employees VALUES('Mohamed')

------------------------------------------------------------------------------------
-- Google -- => Android_Department
INSERT INTO Users VALUES ('ShadiBarghash' , 'Hello, World3', 'shadi@gmail.com'  , 'Shadi'   , 'Ayman'  , 'Barghash', '1997/06/17', 3)
INSERT INTO Staff_Members VALUES ('ShadiBarghash'     , 195735   , 'Friday'     , 50, 'Android Software Manager', 'Android_OS', 'google.com')
INSERT INTO Managers VALUES('ShadiBarghash', 'Senior')

INSERT INTO Users VALUES ('Mahmoud'       , 'Hello, World5', 'Mahmoud@gmail.com', 'Mahmoud' , 'Mohamed', 'Ahmed', '1997/03/10', 1)
INSERT INTO Staff_Members VALUES ('Mahmoud'     , 123735   , 'Tuesday'     , 34, 'Android Software Manager', 'Android_OS', 'google.com')
INSERT INTO Managers VALUES('Mahmoud', 'Junior')

INSERT INTO Users VALUES ('Ali'           , 'Hello, World6', 'Ali@gmail.com'    , 'Ali'     , 'Mohamed', 'Ahmed', '1997/04/10', 5)
INSERT INTO Staff_Members VALUES ('Ali'     , 17325   , 'Sunday'     , 27, 'Android HR', 'Android_OS', 'google.com')
INSERT INTO Hr_Employees VALUES('Ali')

INSERT INTO Users VALUES ('Mohsen'        , 'Hello, World7', 'Mohsen@gmail.com' , 'Mohsen'  , 'Mohamed', 'Ahmed', '1997/05/10', 4)
INSERT INTO Staff_Members VALUES ('Mohsen'     , 12735   , 'Monday'     , 87, 'Android HR', 'Android_OS', 'google.com')
INSERT INTO Hr_Employees VALUES('Mohsen')

------------------------------------------------------------------------------------
-- Google -- => Web_Department
INSERT INTO Users VALUES ('Eyad'          , 'Hello, World8', 'Eyad@gmail.com'   , 'Eyad'    , 'Mohamed', 'Ahmed', '1997/06/10', 5)
INSERT INTO Staff_Members VALUES ('Eyad'     , 12135   , 'Friday'     , 50, 'Web Development Manager', 'Web_Dev', 'google.com')
INSERT INTO Managers VALUES('Eyad', 'Junior')

INSERT INTO Users VALUES ('Mohab'         , 'Hello, World9', 'Mohab@gmail.com'  , 'Mohab'   , 'Mohamed', 'Ahmed', '1997/07/10', 6)
INSERT INTO Staff_Members VALUES ('Mohab'     , 195735   , 'Friday'     , 20, 'Web Development Manager', 'Web_Dev', 'google.com')
INSERT INTO Managers VALUES('Mohab', 'Junior')

INSERT INTO Users VALUES ('Adel'          , 'Hello, World0', 'Adel@gmail.com'   , 'Adel'    , 'Mohamed', 'Ahmed', '1997/08/10', 9)
INSERT INTO Staff_Members VALUES ('Adel'     , 1492   , 'Sunday'     , 15, 'Web Development HR', 'Web_Dev', 'google.com')
INSERT INTO Hr_Employees VALUES('Adel')

INSERT INTO Users VALUES ('Sabry'         , 'Hello, World*', 'Sabry@gmail.com'  , 'Sabry'   , 'Mohamed', 'Ahmed', '1997/09/10', 10)
INSERT INTO Staff_Members VALUES ('Sabry'     , 17246   , 'Sunday'     , 80, 'Web Development HR', 'Web_Dev', 'google.com')
INSERT INTO Hr_Employees VALUES('Sabry')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- Facebook -- => Facebook AI Research
INSERT INTO Users VALUES ('AmrMKayid2'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('AmrMKayid2'     , 175735   , 'Friday'     , 37, 'Machine Learning Manager', 'FAIR', 'facebook.com')
INSERT INTO Managers VALUES('AmrMKayid2', 'Senior')

INSERT INTO Users VALUES ('YasmeenKhaled2' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('YasmeenKhaled2'     , 175735   , 'Sunday'     , 47, 'Artificial Intelligence Manager', 'FAIR', 'facebook.com')
INSERT INTO Managers VALUES('YasmeenKhaled2', 'Senior')

INSERT INTO Users VALUES ('Ahmed2'         , 'Hello, World3', 'Ahmed2@gmail.com'  , 'Ahmed2'   , 'Mohamed', 'Ahmed2', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('Ahmed2'     , 17573   , 'Monday'     , 27, 'Software Engineering HR', 'FAIR', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Ahmed2')

INSERT INTO Users VALUES ('Mohamed2'       , 'Hello, World4', 'Mohamed2@gmail.com', 'Mohamed2' , 'Ahmed'  , 'Ali', '1997/02/01', 1)
INSERT INTO Staff_Members VALUES ('Mohamed2'     , 15735   , 'Saturday'     , 55, 'Software Engineering HR', 'FAIR', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Mohamed2')

------------------------------------------------------------------------------------
-- Facebook -- => Mobile Development
INSERT INTO Users VALUES ('ShadiBarghash2' , 'Hello, World3', 'shadi@gmail.com'  , 'Shadi'   , 'Ayman'  , 'Barghash', '1997/06/17', 3)
INSERT INTO Staff_Members VALUES ('ShadiBarghash2'     , 195735   , 'Friday'     , 50, 'Android Software Manager', 'Mobile_Dev', 'facebook.com')
INSERT INTO Managers VALUES('ShadiBarghash2', 'Senior')

INSERT INTO Users VALUES ('Mahmoud2'       , 'Hello, World5', 'Mahmoud2@gmail.com', 'Mahmoud2' , 'Mohamed', 'Ahmed', '1997/03/10', 1)
INSERT INTO Staff_Members VALUES ('Mahmoud2'     , 123735   , 'Tuesday'     , 34, 'iOS Software Manager', 'Mobile_Dev', 'facebook.com')
INSERT INTO Managers VALUES('Mahmoud2', 'Junior')

INSERT INTO Users VALUES ('Ali2'           , 'Hello, World6', 'Ali2@gmail.com'    , 'Ali2'     , 'Mohamed', 'Ahmed', '1997/04/10', 5)
INSERT INTO Staff_Members VALUES ('Ali2'     , 17325   , 'Sunday'     , 27, 'Android HR', 'Mobile_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Ali2')

INSERT INTO Users VALUES ('Mohsen2'        , 'Hello, World7', 'Mohsen2@gmail.com' , 'Mohsen2'  , 'Mohamed', 'Ahmed', '1997/05/10', 4)
INSERT INTO Staff_Members VALUES ('Mohsen2'     , 12735   , 'Monday'     , 87, 'iOS HR', 'Mobile_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Mohsen2')

------------------------------------------------------------------------------------
-- Facebook -- => Web_Department
INSERT INTO Users VALUES ('Eyad2'          , 'Hello, World8', 'Eyad2@gmail.com'   , 'Eyad2'    , 'Mohamed', 'Ahmed', '1997/06/10', 5)
INSERT INTO Staff_Members VALUES ('Eyad2'     , 12135   , 'Friday'     , 50, 'Web Development Manager', 'Web_Dev', 'facebook.com')
INSERT INTO Managers VALUES('Eyad2', 'Junior')

INSERT INTO Users VALUES ('Mohab2'         , 'Hello, World9', 'Mohab2@gmail.com'  , 'Mohab2'   , 'Mohamed', 'Ahmed', '1997/07/10', 6)
INSERT INTO Staff_Members VALUES ('Mohab2'     , 195735   , 'Friday'     , 20, 'Web Development Manager', 'Web_Dev', 'facebook.com')
INSERT INTO Managers VALUES('Mohab2', 'Junior')

INSERT INTO Users VALUES ('Adel2'          , 'Hello, World0', 'Adel2@gmail.com'   , 'Adel2'    , 'Mohamed', 'Ahmed', '1997/08/10', 9)
INSERT INTO Staff_Members VALUES ('Adel2'     , 1492   , 'Sunday'     , 15, 'Web Development HR', 'Web_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Adel2')

INSERT INTO Users VALUES ('Sabry2'         , 'Hello, World*', 'Sabry2@gmail.com'  , 'Sabry2'   , 'Mohamed', 'Ahmed', '1997/09/10', 10)
INSERT INTO Staff_Members VALUES ('Sabry2'     , 17246   , 'Sunday'     , 80, 'Web Development HR', 'Web_Dev', 'facebook.com')
INSERT INTO Hr_Employees VALUES('Sabry2')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----

-- Apple -- => iOS_Department
INSERT INTO Users VALUES ('AmrMKayid3'     , 'Hello, World!', 'amr@gmail.com'    , 'Amr'     , 'Mohamed', 'Kayid', '1997/07/10', 3)
INSERT INTO Staff_Members VALUES ('AmrMKayid3'     , 175735   , 'Friday'     , 37, 'iOS Manager', 'iOS', 'apple.com')
INSERT INTO Managers VALUES('AmrMKayid3', 'Senior')

INSERT INTO Users VALUES ('YasmeenKhaled3' , 'Hello, World2', 'yasmeen@gmail.com', 'Yasmeen' , 'Khaled' , 'Abdelmohsen', '1997/04/25', 3)
INSERT INTO Staff_Members VALUES ('YasmeenKhaled3'     , 175735   , 'Sunday'     , 47, 'iOS Manager', 'iOS', 'apple.com')
INSERT INTO Managers VALUES('YasmeenKhaled3', 'Senior')

INSERT INTO Users VALUES ('Ahmed3'         , 'Hello, World3', 'Ahmed3@gmail.com'  , 'Ahmed3'   , 'Mohamed', 'Ahmed3', '1997/01/01', 2)
INSERT INTO Staff_Members VALUES ('Ahmed3'     , 17573   , 'Monday'     , 27, 'iOS HR', 'iOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Ahmed3')

INSERT INTO Users VALUES ('Mohamed3'       , 'Hello, World4', 'Mohamed3@gmail.com', 'Mohamed3' , 'Ahmed'  , 'Ali', '1997/02/01', 1)
INSERT INTO Staff_Members VALUES ('Mohamed3'     , 15735   , 'Saturday'     , 55, 'iOS HR', 'iOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Mohamed3')

------------------------------------------------------------------------------------
-- Apple -- => macOS_Department
INSERT INTO Users VALUES ('ShadiBarghash3' , 'Hello, World3', 'shadi@gmail.com'  , 'Shadi'   , 'Ayman'  , 'Barghash', '1997/06/17', 3)
INSERT INTO Staff_Members VALUES ('ShadiBarghash3'     , 195735   , 'Friday'     , 50, 'macOS Software Manager', 'macOS', 'apple.com')
INSERT INTO Managers VALUES('ShadiBarghash3', 'Senior')

INSERT INTO Users VALUES ('Mahmoud3'       , 'Hello, World5', 'Mahmoud3@gmail.com', 'Mahmoud3' , 'Mohamed', 'Ahmed', '1997/03/10', 1)
INSERT INTO Staff_Members VALUES ('Mahmoud3'     , 123735   , 'Tuesday'     , 34, 'macOS Software Manager', 'macOS', 'apple.com')
INSERT INTO Managers VALUES('Mahmoud3', 'Junior')

INSERT INTO Users VALUES ('Ali3'           , 'Hello, World6', 'Ali3@gmail.com'    , 'Ali3'     , 'Mohamed', 'Ahmed', '1997/04/10', 5)
INSERT INTO Staff_Members VALUES ('Ali3'     , 17325   , 'Sunday'     , 27, 'macOS HR', 'macOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Ali3')

INSERT INTO Users VALUES ('Mohsen3'        , 'Hello, World7', 'Mohsen3@gmail.com' , 'Mohsen3'  , 'Mohamed', 'Ahmed', '1997/05/10', 4)
INSERT INTO Staff_Members VALUES ('Mohsen3'     , 12735   , 'Monday'     , 87, 'macOS HR', 'macOS', 'apple.com')
INSERT INTO Hr_Employees VALUES('Mohsen3')

------------------------------------------------------------------------------------
-- Apple -- => TV_Department
INSERT INTO Users VALUES ('Eyad3'          , 'Hello, World8', 'Eyad3@gmail.com'   , 'Eyad3'    , 'Mohamed', 'Ahmed', '1997/06/10', 5)
INSERT INTO Staff_Members VALUES ('Eyad3'     , 12135   , 'Friday'     , 50, 'TV Development Manager', 'iTV', 'apple.com')
INSERT INTO Managers VALUES('Eyad3', 'Junior')

INSERT INTO Users VALUES ('Mohab3'         , 'Hello, World9', 'Mohab2@gmail.com'  , 'Mohab3'   , 'Mohamed', 'Ahmed', '1997/07/10', 6)
INSERT INTO Staff_Members VALUES ('Mohab3'     , 195735   , 'Friday'     , 20, 'TV Development Manager', 'iTV', 'apple.com')
INSERT INTO Managers VALUES('Mohab3', 'Junior')

INSERT INTO Users VALUES ('Adel3'          , 'Hello, World0', 'Adel3@gmail.com'   , 'Adel3'    , 'Mohamed', 'Ahmed', '1997/08/10', 9)
INSERT INTO Staff_Members VALUES ('Adel3'     , 1492   , 'Sunday'     , 15, 'TV Development HR', 'iTV', 'apple.com')
INSERT INTO Hr_Employees VALUES('Adel3')

INSERT INTO Users VALUES ('Sabry3'         , 'Hello, World*', 'Sabry3@gmail.com'  , 'Sabry3'   , 'Mohamed', 'Ahmed', '1997/09/10', 10)
INSERT INTO Staff_Members VALUES ('Sabry3'     , 17246   , 'Sunday'     , 80, 'TV Development HR', 'iTV', 'apple.com')
INSERT INTO Hr_Employees VALUES('Sabry3')

---- ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ##### ##### ##### ##### -----