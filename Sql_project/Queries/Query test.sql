-- EXECUTE to UpdateStudent by training manager Called Hadir  also try basma to check trigger--------------- Aly
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
	@User_ID = 34,
    @Militery_status = 'Active',
    @Faculty = 'Engineering';

-- EXECUTE to UpdateStudent by training manager Called Hadir  also try basma to check trigger------------- Aly
EXECUTE AddIntake
    @Quarter_Round =  1,
    @Year = 2024,
	@Intake_ID =  7,
    @Branch_ID = 1;

-- EXECUTE to UpdateStudent by training manager Called Hadir  also try basma to check trigger------------- Aly
EXECUTE DeleteStudent @User_ID = 34;

-- EXECUTE to UpdateStudent by training manager Called Hadir  also try basma to check trigger-------------- Aly
EXECUTE UpdateStudent
    @userName = 'aaaaaaa',
    @password ='newpassword',
    @Name = 'New Name',
    @phone = '1234567890',
    @role = 'Student',
    @email = 'newemail@example.com',
    @branch_ID = 1,
    @Track_ID = 2,
    @Intake_ID = 3,
	@User_ID = 33,
    @Militery_status = 'active',
    @Faculty = 'Engineering';
	DECLARE @SyUserName NVARCHAR(100);
SET @SyUserName = SYSTEM_USER;


select * from All_Students_View
select * from All_Questions_For_Course_View






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