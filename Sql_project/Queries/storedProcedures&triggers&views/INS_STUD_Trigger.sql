-- Create the trigger to prevent instructor from adding new student

-- Trigger Definition
CREATE TRIGGER trg_PreventInstructorAddStudent
ON Students
INSTEAD OF INSERT
AS
BEGIN

    DECLARE @Adding_User_ID INT
    DECLARE @IsInstructor BIT

    SET @Adding_User_ID = CAST(CAST(CONTEXT_INFO() AS VARBINARY(128)) AS INT)

    -- Check if the Adding_User_ID is an instructor
    SET @IsInstructor = (SELECT CASE WHEN EXISTS (
        SELECT 1 
        FROM Instructors 
        WHERE User_ID = @Adding_User_ID
    ) THEN 1 ELSE 0 END)

    -- If the user is an instructor, raise an error
    IF @IsInstructor = 1
    BEGIN
        RAISERROR('Instructors are not allowed to add new students.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    -- If not an instructor, proceed with the insert
    INSERT INTO Students (User_ID, Branch_ID, Track_ID, Intake_ID, Militery_Status, Faculty)
    SELECT User_ID, Branch_ID, Track_ID, Intake_ID, Militery_Status, Faculty
    FROM INSERTED
END;

-- Example of setting CONTEXT_INFO and performing an insert
DECLARE @User_ID INT
SET @User_ID = 1  
SET CONTEXT_INFO @User_ID

-- insert for Column Student
INSERT INTO Students (User_ID, Branch_ID, Track_ID, Intake_ID, Militery_Status, Faculty)
VALUES (1, 1, 1, 1, 'N/A', 'Faculty Of Science')

Select * from Students

---------------------------------------------
-- Create the trigger to prevent instructor from update student any student Data

GO
Create TRIGGER trg_PreventInstructorUpdateStudent
ON Students
INSTEAD OF UPDATE
AS
BEGIN
    DECLARE @Updating_User_ID INT
    DECLARE @IsInstructor BIT

    SET @Updating_User_ID = CAST(CAST(CONTEXT_INFO() AS VARBINARY(128)) AS INT)

    -- Check if the Updating_User_ID is an instructor
    SET @IsInstructor = (SELECT CASE WHEN EXISTS (
        SELECT 1 
        FROM Instructors 
        WHERE User_ID = @Updating_User_ID
    ) THEN 1 ELSE 0 END)

    -- If the user is an instructor, raise an error
    IF @IsInstructor = 1
    BEGIN
        RAISERROR('Instructors are not allowed to update student data.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    -- If not an instructor, proceed with the update
    UPDATE Students
    SET 
        User_ID = inserted.User_ID,
        Branch_ID = inserted.Branch_ID,
        Track_ID = inserted.Track_ID,
        Intake_ID = inserted.Intake_ID,
        Militery_Status = inserted.Militery_Status,
        Faculty = inserted.Faculty
    FROM inserted
    WHERE Students.User_ID = inserted.User_ID
END;

-- Example of setting CONTEXT_INFO and performing an update
DECLARE @User_ID INT
SET @User_ID = 2 

SET CONTEXT_INFO @User_ID

UPDATE Students
SET Branch_ID = 2, 
Track_ID = 2
WHERE User_ID = 5 

Select * From Students


-----------------------------------------------
-- Create the trigger to prevent instructor from Delete student any student Data
GO
CREATE TRIGGER trg_PreventInstructorDeleteStudent
ON Students
INSTEAD OF DELETE
AS
BEGIN
    -- Declare variables to hold the user ID attempting the delete and their role
    DECLARE @Deleting_User_ID INT
    DECLARE @IsInstructor BIT

    SET @Deleting_User_ID = CAST(CAST(CONTEXT_INFO() AS VARBINARY(128)) AS INT)

    -- Check if the Deleting_User_ID is an instructor
    SET @IsInstructor = (SELECT CASE WHEN EXISTS (
        SELECT 1 
        FROM Instructors 
        WHERE User_ID = @Deleting_User_ID
    ) THEN 1 ELSE 0 END)

    -- If the user is an instructor, raise an error
    IF @IsInstructor = 1
    BEGIN
        RAISERROR('Instructors are not allowed to delete student data.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    -- If not an instructor, proceed with the delete
    DELETE FROM Students
    WHERE User_ID IN (SELECT User_ID FROM deleted)
END;

-- Example of setting CONTEXT_INFO and performing a delete
DECLARE @User_ID INT
SET @User_ID = 1 

-- Set the CONTEXT_INFO
SET CONTEXT_INFO @User_ID

DELETE FROM Students
WHERE User_ID = 5

Select * From Students