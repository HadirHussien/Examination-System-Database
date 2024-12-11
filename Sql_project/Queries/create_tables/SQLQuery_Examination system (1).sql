use examinaton_Project
-- create database
create database examination_Project
on
(
	Name ='examination_Data',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\examination_system.mdf',
	Size = 10MB,
	Maxsize = unlimited,
	filegrowth = 50%
)
LOG on
(
	Name ='examination_Log',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\examination_system.ldf',
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
	constraint usersPk primary key(User_ID)
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
    declare @userName nvarchar(50),set @userName=system_user ,
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
---Create instructors Table
Create Table Instructors (
User_ID int ,
branch_ID int,
Traning_ManagerID int,
Field nvarchar(50),
Constraint PK_user primary key (user_ID),
Constraint FK_userID foreign key (user_ID) references users (User_ID),
Constraint FK_BranchID foreign key (branch_ID) references branch (branch_ID),
Constraint FK_Traning_Manager_ID foreign key (Traning_ManagerID) references Users (User_ID)
)


---Create Courses Table
Create table Courses (
Course_ID int , 
track_ID int ,
Course_Name nvarchar(50),
Course_Description nvarchar(200),
Max_Degree int ,
Min_Degree int ,
Instractor_ID int,
constraint PK_CourseID primary key (Course_ID) ,
constraint FK_trackID foreign key (track_ID) references track (track_ID),
Constraint FK_Instructor_ID foreign key (Instractor_ID) references users (User_ID)
)
----Create Courses_In_Track table
Create table Courses_In_Track (
Course_ID int , 
track_ID int ,
Constraint PKCourseID primary key (Course_ID),
Constraint FKCourseID foreign key (Course_ID) references Courses (Course_ID),
Constraint FK_Track_ID foreign key (track_ID) references track (track_ID)

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

-- create exam table
create table exam(
exam_id int,
course_id int,
stu_user_id int,
year int,
total_degree int,
date date,
start_time time,
end_time time,
type nvarchar(20),
constraint PK_exam_id primary key (exam_id),
constraint FK_course_id foreign key (course_id) references courses (course_id),
constraint FK_stu_user_id foreign key (stu_user_id) references students (user_id)
)

-- create exam_questions table
create table exam_questions(
question_id int,
exam_id int,
constraint PK_question_id primary key (question_id),
constraint FK_question_id foreign key (question_id) references Question.questions (question_id),
constraint FK_exam_id foreign key (exam_id) references exam (exam_id) 
)
go
-- create student_answer table
create table student_answer(
question_id int,
stu_user_id int,
mark int,
student_ans nvarchar(200),
constraint PK_question_id2 primary key (question_id, stu_user_id),
constraint FK_question_id2 foreign key (question_id) references Question.questions(question_id),
constraint FK_stu_user_id2 foreign key (stu_user_id) references students(user_id)
)


