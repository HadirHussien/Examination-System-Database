----------Stored Procedure For add new course in track in specific branch by training manager
Create PROCEDURE AddCourseToTrackInBranch
    @Course_ID INT,
    @Course_Name NVARCHAR(50),
    @Course_Description NVARCHAR(200),
    @Max_Degree INT,
    @Min_Degree INT,
    @Instructor_ID INT,
    @Track_ID INT,
    @Branch_ID INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Check if the SYSTEM_USER a training manager
         IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and role = 'Training_Manager' or SYSTEM_USER='AdminUser')
    BEGIN
        RAISERROR ('Only Training Managers are authorized to add students.', 16, 1);
        RETURN;
    END

        -- Insert the new course
        INSERT INTO Courses (Course_ID, Course_Name, Course_Description, Max_Degree, Min_Degree, Instractor_ID)
        VALUES (@Course_ID, @Course_Name, @Course_Description, @Max_Degree, @Min_Degree, @Instructor_ID);

        -- Insert into Courses_In_Track
        INSERT INTO Courses_In_Track (Course_ID, Track_ID)
        VALUES (@Course_ID, @Track_ID);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;


----------------------------------------------------------
-- Stored Procedure For Delete course in track by instructor 
GO
Create PROCEDURE DeleteCourseFromTrackInBranch
    @Course_ID INT,
    @Track_ID INT
AS
BEGIN
    BEGIN TRANSACTION;
	IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and role= 'Training_Manager' or SYSTEM_USER='AdminUser')
        BEGIN
            -- If the user is not a training manager, raise an error and rollback the transaction
            RAISERROR( 'Only training managers are allowed to delete courses.',16, 1);
            RETURN;
        END
    
    BEGIN TRY
        -- Delete the course from the Courses_In_Track table
        DELETE FROM Courses_In_Track
        WHERE Course_ID = @Course_ID AND Track_ID = @Track_ID;

        -- Check if the course exists in any other track
        IF NOT EXISTS (SELECT 1 FROM Courses_In_Track WHERE Course_ID = @Course_ID)
        BEGIN
            -- If the course is not in any other track, delete the course from the Courses table
            DELETE FROM Courses
            WHERE Course_ID = @Course_ID;
        END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;



------------------------------------------------
-- Stored Procedure For Edit course in track 
GO
Create PROCEDURE EditCourseInTrack
    @Course_ID INT,
    @Course_Name NVARCHAR(50),
    @Course_Description NVARCHAR(200),
    @Max_Degree INT,
    @Min_Degree INT,
    @Instructor_ID INT,
    @Track_ID INT
AS
BEGIN
    BEGIN TRANSACTION;
	IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and role = 'Training_Manager' or SYSTEM_USER='AdminUser')
        BEGIN
            -- If the user is not a training manager, raise an error and rollback the transaction
            RAISERROR('Only training managers are allowed to Update courses.',16, 1);
            RETURN;
        END
    
    BEGIN TRY
        -- Update the course details in the Courses table
        UPDATE Courses
        SET 
            Course_Name = @Course_Name,
            Course_Description = @Course_Description,
            Max_Degree = @Max_Degree,
            Min_Degree = @Min_Degree,
            Instractor_ID = @Instructor_ID
        WHERE Course_ID = @Course_ID;

        -- Ensure the course is associated with the correct track in the Courses_In_Track table
        IF NOT EXISTS (SELECT 1 FROM Courses_In_Track WHERE Course_ID = @Course_ID AND Track_ID = @Track_ID)
        BEGIN
            -- If the course is not associated with the track, insert the association
            INSERT INTO Courses_In_Track (Course_ID, Track_ID)
            VALUES (@Course_ID, @Track_ID);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;

-----------------------------------------------------------------
-- Stored Procedure For Update track 
GO
Create PROCEDURE UpdateTrack
    @Track_ID INT,
    @Dept_ID INT,
    @Track_Name NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Check if the Updating_User_ID is a training manager
       IF NOT EXISTS (SELECT 1 FROM users WHERE Name = SYSTEM_USER and role = 'Training_Manager' or SYSTEM_USER='AdminUser')
        BEGIN
            -- If the user is not a training manager, raise an error and rollback the transaction
            RAISERROR( 'Only training managers are allowed to update tracks.',16, 1);
            RETURN;
        END

        -- Update the track details in the track table
        UPDATE track
        SET 
            Dept_ID = @Dept_ID,
            Track_Name = @Track_Name
        WHERE Track_ID = @Track_ID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

