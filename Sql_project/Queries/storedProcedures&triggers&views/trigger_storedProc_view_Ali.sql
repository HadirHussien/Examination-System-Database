-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  view  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- **********************************************************************************************
-- Create a view to view all students with their details
CREATE VIEW All_Students_View
AS
SELECT
    s.User_ID AS Student_ID,
    u.userName AS Username,
    u.Name AS Student_Name,
    u.phone AS Phone,
    u.email AS Email,
    b.branch_name AS Branch_Name,
    t.track_name AS Track_Name,
    i.quarter_round AS Quarter_Round,
    i.year AS Intake_Year,
    s.Militery_status AS Military_Status,
    s.Faculty AS Faculty
FROM
    Students s
    JOIN users u ON s.User_ID = u.User_ID
    JOIN branch b ON s.branch_ID = b.branch_ID
    JOIN track t ON s.Track_ID = t.track_ID
    JOIN intake i ON s.Intake_ID = i.intake_ID
WHERE
    EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER AND Role = 'Instructor');

-- **********************************************************************************************
-- Create a view to view all questions for a course
CREATE VIEW All_Questions_For_Course_View AS
SELECT
    q.Question_ID,
    q.Question_Text,
    q.Question_Type,
    q.degree,
    c.Course_ID,
    c.Course_Name,
    c.Course_Description
FROM
    Question.Questions q
    JOIN Courses c ON q.course_id = c.Course_ID
WHERE
    EXISTS (
        SELECT 1
        FROM users u
        WHERE u.Name = SYSTEM_USER
        AND u.Role = 'Instructor'
    );

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  stoder proc   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- **********************************************************************************************
-- Create procedure to add a student
CREATE PROCEDURE AddStudent
    @userName nvarchar(50),
    @password nvarchar(50),
    @Name nvarchar(100),
    @phone nvarchar(20),
    @role nvarchar(20),
    @email nvarchar(100),
    @branch_ID int,
    @Track_ID int,
    @Intake_ID int,
	@User_ID int,
    @Militery_status nvarchar(50),
    @Faculty nvarchar(200)
    --@Training_ManagerID int -- New parameter for Training Manager ID
AS
BEGIN
    -- Check if the @Training_ManagerID is authorized (you need to define how this check works)
    IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and Role = 'Training_Manager')
    BEGIN
        RAISERROR ('Only Training Managers are authorized to add students.', 16, 1);
        RETURN;
    END

    -- Insert into users table to create the user
    INSERT INTO users (User_ID, userName, password, Name, phone, role, email)
    VALUES (@User_ID, @userName, @password, @Name, @phone, @role, @email);
    
    -- Insert into Students table
    INSERT INTO Students (User_ID, branch_ID, Track_ID, Intake_ID, Militery_status, Faculty)
    VALUES (@User_ID, @branch_ID, @Track_ID, @Intake_ID, @Militery_status, @Faculty);
    --SCOPE_IDENTITY();
END;
-- **********************************************************************************************
EXECUTE AddStudent
    @userName = 'Esslam',
    @password = 'password123',
    @Name = 'John Doe',
    @phone ='1234567890',
    @role = 'Student',
    @email = 'student1@email.com',
    @branch_ID = 1,
    @Track_ID = 1,
    @Intake_ID = 1,
	@User_ID = 33,
    @Militery_status = 'Active',
    @Faculty = 'Engineering';
-- **********************************************************************************************
-- PROCEDURE TO ADD NEW INTAKE
CREATE PROCEDURE AddIntake
    @Quarter_Round int,
    @Year int,
	@Intake_ID int,
    @Branch_ID int
   -- @Training_ManagerID int -- New parameter for Training Manager ID
AS
BEGIN
    -- Check if the @Training_ManagerID is authorized (you need to define how this check works)
    IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and Role = 'Training_Manager')
    BEGIN
        RAISERROR ('Only Training Managers are authorized to add intakes.', 16, 1);
        RETURN;
    END

    -- Insert into intake table to add a new intake with manual Intake_ID
    INSERT INTO intake (intake_ID, quarter_round, year, branch_ID)
    VALUES (@Intake_ID, @Quarter_Round, @Year, @Branch_ID);
END;
-- **********************************************************************************************
EXECUTE AddIntake
    @Quarter_Round =  1,
    @Year = 2024,
	@Intake_ID =  6,
    @Branch_ID = 1;
   -- @Training_ManagerID = @Training_ManagerID;


-- **********************************************************************************************
-- PROCEDURE to delete student
create PROCEDURE DeleteStudent
    @User_ID int -- Manager ID who is authorized to delete
AS
BEGIN
    -- Check if the @Manager_ID is authorized as a Manager (or Training Manager)
    IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and Role = 'Training_Manager')
    BEGIN
        RAISERROR ('Only Managers or Training Managers are authorized to delete students.', 16, 1);
        RETURN;
    END

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Students WHERE User_ID = @User_ID)
    BEGIN
        RAISERROR ('Student with specified User_ID does not exist.', 16, 1);
        RETURN;
    END

    -- Begin transaction to ensure atomic operation
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Delete from student_answer table
        DELETE FROM student_answer WHERE question_id IN (
            SELECT question_id FROM exam_questions WHERE exam_id IN (
                SELECT exam_id FROM exam WHERE stu_user_id = @User_ID
            )
        );

        -- Delete from exam_questions table
        DELETE FROM exam_questions WHERE exam_id IN (
            SELECT exam_id FROM exam WHERE stu_user_id = @User_ID
        );

        -- Delete from exam table
        DELETE FROM exam WHERE stu_user_id = @User_ID;

        -- Delete from Students table
        DELETE FROM Students WHERE User_ID = @User_ID;

        -- Delete from users table (optional)
        -- DELETE FROM users WHERE User_ID = @User_ID;

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of error
        ROLLBACK TRANSACTION;

        -- Propagate the error to the caller
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN;
    END CATCH;
END;
-- **********************************************************************************************

--DECLARE @Manager_ID int = 4; -- Manager ID for deletion
-- User ID of the student to delete
-- Execute the DeleteStudent procedure
EXECUTE DeleteStudent @User_ID = 34;



-- **********************************************************************************************
-------------------procedure to update student
CREATE PROCEDURE UpdateStudent
    @userName nvarchar(50),
    @password nvarchar(50),
    @Name nvarchar(100),
    @phone nvarchar(20),
    @role nvarchar(20),
    @email nvarchar(100),
    @branch_ID int,
    @Track_ID int,
    @Intake_ID int,
	@User_ID int,
    @Militery_status nvarchar(50),
    @Faculty nvarchar(200)
AS
BEGIN
    -- Check if the @Manager_ID is authorized as a Training Manager
    IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and Role = 'Training_Manager')
    BEGIN
        RAISERROR ('Only Training Managers are authorized to update students.', 16, 1);
        RETURN;
    END

    -- Check if the student exists
    IF NOT EXISTS (SELECT 1 FROM Students WHERE User_ID = @User_ID)
    BEGIN
        RAISERROR ('Student with specified User_ID does not exist.', 16, 1);
        RETURN;
    END

    -- Begin transaction to ensure atomic operation
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update users table
        UPDATE users
        SET userName = @userName,
            password = @password,
            Name = @Name,
            phone = @phone,
            role = @role,
            email = @email
        WHERE User_ID = @User_ID;

        -- Update Students table
        UPDATE Students
        SET branch_ID = @branch_ID,
            Track_ID = @Track_ID,
            Intake_ID = @Intake_ID,
            Militery_status = @Militery_status,
            Faculty = @Faculty
        WHERE User_ID = @User_ID;

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of error
        ROLLBACK TRANSACTION;

        -- Propagate the error to the caller
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN;
    END CATCH;
END;
-- **********************************************************************************************
-- Execute the UpdateStudent procedure
EXECUTE UpdateStudent
    @userName = 'aaaaaaaaaaaaa',
    @password ='newpassword',
    @Name = 'New Name',
    @phone = '1234567890',
    @role = 'Student',
    @email = 'newemail@example.com',
    @branch_ID = 1,
    @Track_ID = 2,
    @Intake_ID = 3,
	@User_ID = 33,
    @Militery_status = 'Exempted',
    @Faculty = 'Engineering';

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  trigger   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- **********************************************************************************************
-- Create trigger to prevent instructors from modifying exam table
create TRIGGER trgPreventIntake
ON intake
FOR INSERT, DELETE
AS
BEGIN
    -- Check if the current user is an instructor
   IF  EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and Role = 'Instructor')
    BEGIN
        RAISERROR ('Instructors are not allowed to add, delete intake.', 16, 1);
        ROLLBACK TRANSACTION; -- Rollback to prevent the operation
        RETURN;
    END
END;



