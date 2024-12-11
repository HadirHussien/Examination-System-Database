
-- create database
create database examination_Project
on 
(
	Name ='examination_Data',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\examination_system.mdf',
	Size = 10MB,
	Maxsize = unlimited,
	filegrowth = 50%
)
LOG on
(
	Name ='examination_Log',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\examination_system.ldf',
	Size = 5MB,
	Maxsize = 100MB,
	filegrowth = 50%
)
--end create database
------------------------------------------------------------------------
--start create tables

--create user table
create  table users(
    User_ID int,
    userName nvarchar(50) ,
    password nvarchar(50),
    Name nvarchar(100),
    phone nvarchar(20),
	role nvarchar(20),
    email nvarchar(100),
	constraint usersPk primary key(User_ID),
);


--create Permission table
create table Permission(
    Permission_ID int,
	User_ID int,
    Permission_Name nvarchar(50),
	constraint PermissionPk primary key(Permission_ID),
    constraint FK_User_Permission foreign key (User_ID) references users(User_ID)
);
--create branch table
create table branch (
    branch_ID int ,
    City nvarchar(50),
    Found_date date,
    Training_manager nvarchar(100),
    branch_name nvarchar(100),
	constraint PK_branch_ID primary key (branch_ID)
);
--create current_user table
create table current_users(
    user_ID int,
    userName nvarchar(50),
    constraint PK_current_user primary key (user_ID),
    constraint FK_user_ID foreign key (user_ID) references users (User_ID)
);

 
--create intake_table

create table intake(
intake_ID int ,
quarter_round int,
year int,
branch_ID int,
constraint PK_intake_ID primary key (intake_ID),
constraint FK_branch_ID Foreign key (branch_ID) references branch (branch_ID)
)

--create department ID

create table department(
dept_ID int,
intake_ID int ,
dept_name nvarchar(50),
constraint PK_dept_ID primary key (dept_ID) ,
constraint FK_intake_ID foreign key (intake_ID) references intake(intake_ID)
)

create table track (
track_ID int , 
dept_ID int ,
track_name nvarchar(50),
constraint PK_track_ID primary key (track_ID) ,
constraint FK_dept_ID foreign key (dept_ID) references department (dept_ID)
)
---Create table UserRole
CREATE TABLE UserRoles (
    User_ID int,
    Role nvarchar(20),
    CONSTRAINT PK_UserRoles PRIMARY KEY (User_ID, Role),
    CONSTRAINT FK_UserRoles_UserID FOREIGN KEY (User_ID) REFERENCES users (User_ID)
);

---Create instructors Table
CREATE TABLE Instructors (
    User_ID int,
    branch_ID int,
    Traning_Manager int,  -- Changed to int to reference User_ID
    Manager_Role nvarchar(20),  -- Added to reference role
    Field nvarchar(50),
    CONSTRAINT PK_user PRIMARY KEY (User_ID),
    CONSTRAINT FK_userID FOREIGN KEY (User_ID) REFERENCES users (User_ID),
    CONSTRAINT FK_BranchID FOREIGN KEY (branch_ID) REFERENCES branch (branch_ID),
    CONSTRAINT FK_Traning_Manager_ID FOREIGN KEY (Traning_Manager, Manager_Role) REFERENCES UserRoles (User_ID, Role)
);



---Create Courses Table
Create table Courses (
Course_ID int , 
Course_Name nvarchar(50),
Course_Description nvarchar(200),
Max_Degree int ,
Min_Degree int ,
Instractor_ID int,
constraint PK_CourseID primary key (Course_ID) ,
Constraint FK_Instructor_ID foreign key (Instractor_ID) references users (User_ID )
)
----Create Courses_In_Track table
create table Courses_In_Track (
Course_ID int , 
track_ID int ,
Constraint FKCourseID foreign key (Course_ID) references Courses (Course_ID),
Constraint FK_Track_ID foreign key (track_ID) references track (track_ID),
Constraint PKCourse primary key (Course_ID,track_ID)
)

---Create Student Table
Create Table Students (
User_ID int ,
branch_ID int,
Track_ID int,
Intake_ID int,
Militery_status nvarchar(50),
Faculty nvarchar(200),
Constraint PK_User_ID primary key (user_ID),
Constraint FKuser_ID foreign key (user_ID) references users (User_ID),
Constraint FKBranchID foreign key (branch_ID) references branch (branch_ID),
Constraint FKTrackID foreign key (Track_ID) references track (track_ID),
Constraint FKIntakeID foreign key (Intake_ID) references intake (intake_ID)
)
