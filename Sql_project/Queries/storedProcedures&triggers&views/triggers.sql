------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Drop the trigger if it exists
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_PreventInstructorInsertTrack')
    DROP TRIGGER trg_PreventInstructorInsertTrack;
GO

-- Create the trigger
CREATE TRIGGER trg_PreventInstructorInsertTrack
ON track
AFTER INSERT
AS
BEGIN
    DECLARE @UserRole NVARCHAR(50);

    -- Check the current user's role
    SELECT @UserRole = u.role
    FROM users u
    WHERE u.Name = SYSTEM_USER;
    -- If the user is an instructor, prevent the insert
    IF @UserRole = 'Instructor'
    BEGIN
        RAISERROR ('Instructors are not allowed to add tracks.', 16, 1);
        ROLLBACK TRANSACTION;  -- Rollback to prevent the insertion
    END
END;
GO

------------------------------------------------------------
--------trigger to prevent instructor to update track------

-- Drop the trigger if it exists
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_PreventInstructorUpdateTrack')
    DROP TRIGGER trg_PreventInstructorUpdateTrack;
GO

-- Create the trigger
CREATE TRIGGER trg_PreventInstructorUpdateTrack
ON track
AFTER UPDATE
AS
BEGIN
    DECLARE @UserRole NVARCHAR(50);

    -- Check the current user's role
    SELECT @UserRole = u.role
    FROM users u
    WHERE u.Name = SYSTEM_USER;

    -- If the user is an instructor, prevent the update
    IF @UserRole = 'Instructor'
    BEGIN
        RAISERROR ('Instructors are not allowed to update tracks.', 16, 1);
        ROLLBACK TRANSACTION;  -- Rollback to prevent the update
    END
END;
GO
------------------------------------------------------------
--------trigger to prevent instructor to delete track------

-- Drop the trigger if it exists
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_PreventInstructorDeleteTrack')
    DROP TRIGGER trg_PreventInstructorDeleteTrack;
GO

-- Create the trigger
CREATE TRIGGER trg_PreventInstructorDeleteTrack
ON track
AFTER DELETE
AS
BEGIN
    DECLARE @UserRole NVARCHAR(50);

    -- Check the current user's role
    SELECT @UserRole = u.role
    FROM users u
    WHERE u.Name = SYSTEM_USER;

    -- If the user is an instructor, prevent the delete
    IF @UserRole = 'Instructor'
    BEGIN
        RAISERROR ('Instructors are not allowed to delete tracks.', 16, 1);
        ROLLBACK TRANSACTION;  -- Rollback to prevent the delete
    END
END;
GO
