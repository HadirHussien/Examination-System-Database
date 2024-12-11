
----------procedure for making exam randomly
ALTER PROCEDURE make_random_exam_proc 
    @course_Id INT, 
    @no_of_ART INT,
    @no_of_mcq INT, 
    @no_of_TF INT,
    @year INT,
    @total_degree INT,
    @exam_date DATE,
    @start_time TIME,
    @end_time TIME,
    @type VARCHAR(20)
AS
BEGIN
if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
    IF NOT EXISTS (
        SELECT u.User_ID 
        FROM users u 
        JOIN Courses c ON u.User_ID = c.Instractor_ID 
        WHERE u.Name = SYSTEM_USER 
          AND (u.role = 'Instructor' OR u.role = 'Training_Manager') 
          AND c.Course_ID = @course_Id
    )
    BEGIN 
        PRINT 'You cannot make exam as you are not an instructor or you are not an instructor for this course';
    END
    ELSE 
    BEGIN 
        DECLARE @currentExamNumber INT;
        DECLARE @newExamName VARCHAR(50);
        DECLARE @systemUserName VARCHAR(50) = SYSTEM_USER;

        -- Get the current exam number and increment it
        SELECT @currentExamNumber = Last_Exam_Number FROM Exam_Counter;
        SET @currentExamNumber = @currentExamNumber + 1;
        SET @newExamName = 'exam' + CAST(@currentExamNumber AS VARCHAR);

        -- Update the counter with the new exam number
        UPDATE Exam_Counter SET Last_Exam_Number = @currentExamNumber;

        -- Drop temporary tables if they already exist
        IF OBJECT_ID('tempdb..#Essay_questions') IS NOT NULL DROP TABLE #Essay_questions;
        IF OBJECT_ID('tempdb..#MCQ_questions') IS NOT NULL DROP TABLE #MCQ_questions;
        IF OBJECT_ID('tempdb..#TF_questions') IS NOT NULL DROP TABLE #TF_questions;

        -- Create and populate Essay_questions temporary table
        SELECT Art_Question_ID, COALESCE(Question_Text, '') AS Question_Text INTO #Essay_questions
        FROM (
            SELECT Art_Question_ID, Question_Text, ROW_NUMBER() OVER (ORDER BY NEWID()) AS rn
            FROM Question.Article_Question
            WHERE course_id = @course_Id 
        ) AS randomized
        WHERE rn <= @no_of_ART;
        
        -- Create and populate MCQ_questions temporary table
        SELECT MC_Question_ID, 
               COALESCE(question_text, '') AS question_text, 
               COALESCE(Choice1, '') AS Choice1, 
               COALESCE(Choice2, '') AS Choice2, 
               COALESCE(Choice3, '') AS Choice3, 
               COALESCE(Choice4, '') AS Choice4 
        INTO #MCQ_questions
        FROM (
            SELECT MC_Question_ID, question_text, Choice1, Choice2, Choice3, Choice4, ROW_NUMBER() OVER (ORDER BY NEWID()) AS rn
            FROM Question.Multichoice_Question
            WHERE course_id = @course_Id
        ) AS randomized
        WHERE rn <= @no_of_mcq;

        -- Create and populate TF_questions temporary table
        SELECT TF_Question_ID, COALESCE(Question_Text, '') AS Question_Text INTO #TF_questions
        FROM (
            SELECT TF_Question_ID, Question_Text, ROW_NUMBER() OVER (ORDER BY NEWID()) AS rn
            FROM Question.True_Or_False_Question
            WHERE course_id = @course_Id
        ) AS randomized
        WHERE rn <= @no_of_TF;

        -- Insert the questions into Exam_Questions table
        INSERT INTO Exam_Questions (Exam_Name, Question_Id, Question_Type, Question_Text, course_id)
        SELECT @newExamName, Art_Question_ID, 'Essay', Question_Text, @course_Id FROM #Essay_questions;

        INSERT INTO Exam_Questions (Exam_Name, Question_Id, Question_Type, Question_Text, Choice1, Choice2, Choice3, Choice4, course_id)
        SELECT @newExamName, MC_Question_ID, 'MCQ', question_text, Choice1, Choice2, Choice3, Choice4, @course_Id FROM #MCQ_questions;

        INSERT INTO Exam_Questions (Exam_Name, Question_Id, Question_Type, Question_Text, course_id)
        SELECT @newExamName, TF_Question_ID, 'TF', Question_Text, @course_Id FROM #TF_questions;

        -- Insert exam details into Exam_Details table
        INSERT INTO Exam_Details (Exam_Name, Year, Total_Degree, Exam_Date, Start_Time, End_Time, Type, Created_By)
        VALUES (@newExamName, @year, @total_degree, @exam_date, @start_time, @end_time, @type, @systemUserName);

        -- Select the new exam questions and details
        SELECT Exam_Name, Question_Id, Question_Type, Question_Text, course_id,
               ISNULL(Choice1, '') AS Choice1, 
               ISNULL(Choice2, '') AS Choice2, 
               ISNULL(Choice3, '') AS Choice3, 
               ISNULL(Choice4, '') AS Choice4
        FROM Exam_Questions 
        WHERE Exam_Name = @newExamName;

        SELECT Exam_Name, Year, Total_Degree, Exam_Date, Start_Time, End_Time, Type, Created_By
        FROM Exam_Details
        WHERE Exam_Name = @newExamName;
    END 
END;






exec  make_random_exam_proc  5,5,5,5,2024



-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
CREATE TABLE Exam_Questions (
    Exam_Id INT IDENTITY(1,1) PRIMARY KEY,
    Exam_Name NVARCHAR(100),
    Question_Id INT,
    Question_Type NVARCHAR(20),
    Question_Text NVARCHAR(MAX),
    Choice1 NVARCHAR(MAX),
    Choice2 NVARCHAR(MAX),
    Choice3 NVARCHAR(MAX),
    Choice4 NVARCHAR(MAX)
);
go
alter TABLE Exam_Questions
add course_id int

----------------------------
CREATE TABLE Exam_Counter (
    Last_Exam_Number INT
);
select *from Exam_Counter
------------------------------------
-- Initialize with zero if the table is empty
IF NOT EXISTS (SELECT 1 FROM Exam_Counter)
BEGIN
    INSERT INTO Exam_Counter (Last_Exam_Number) VALUES (0);
END;
go
---------------------------------------------------------
alter proc Read_Past_Exams (@Exam_Name nvarchar(100),@course_id int)
as 
begin
if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
if not exists (select  u.User_ID  from users u , Courses c where u.Name=SYSTEM_USER and u.role='Instructor' or u.role='Training_Manager'  and u.User_ID=c.Instractor_ID and c.Course_ID=@course_id)
begin 

	
	print ' You cannot make exam as you are not instructor or you are not instructor in this course'

end
else
begin
select* from Exam_Questions where Exam_Name=@Exam_Name and course_id=@course_id
end
end



exec Read_Past_Exams exam10,5


CREATE TABLE Exam_Details (
    Exam_ID INT IDENTITY(1,1) PRIMARY KEY,
    Exam_Name VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    Total_Degree INT NOT NULL,
    Exam_Date DATE NOT NULL,
    Start_Time TIME NOT NULL,
    End_Time TIME NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Created_By VARCHAR(50) NOT NULL,
    Created_At DATETIME DEFAULT GETDATE()
);
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--==> proc for making exam manually 

alter PROCEDURE make_manual_exam_proc 
    @course_Id INT, 
    @ART_Questions NVARCHAR(MAX), -- List of ART question IDs separated by commas
    @MCQ_Questions NVARCHAR(MAX), -- List of MCQ question IDs separated by commas
    @TF_Questions NVARCHAR(MAX),  -- List of TF question IDs separated by commas
    @year INT,
    @total_degree INT,
    @exam_date DATE,
    @start_time TIME,
    @end_time TIME,
    @type VARCHAR(20)
AS
BEGIN
if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
    IF NOT EXISTS (
        SELECT u.User_ID 
        FROM users u 
        JOIN Courses c ON u.User_ID = c.Instractor_ID 
        WHERE u.Name = SYSTEM_USER 
          AND (u.role = 'Instructor' OR u.role = 'Training_Manager') 
          AND c.Course_ID = @course_Id
    )
    BEGIN 
        PRINT 'You cannot make exam as you are not an instructor or you are not an instructor for this course';
    END
    ELSE 
    BEGIN 
        DECLARE @currentExamNumber INT;
        DECLARE @newExamName VARCHAR(50);
        DECLARE @systemUserName VARCHAR(50) = SYSTEM_USER;

        -- Get the current exam number and increment it
        SELECT @currentExamNumber = Last_Exam_Number FROM Exam_Counter;
        SET @currentExamNumber = @currentExamNumber + 1;
        SET @newExamName = 'exam' + CAST(@currentExamNumber AS VARCHAR);

        -- Update the counter with the new exam number
        UPDATE Exam_Counter SET Last_Exam_Number = @currentExamNumber;

        -- Insert the essay questions into Exam_Questions table
        INSERT INTO Exam_Questions (Exam_Name, Question_Id, Question_Type, Question_Text, course_id)
        SELECT @newExamName, Art_Question_ID, 'Essay', Question_Text, @course_Id 
        FROM Question.Article_Question
        WHERE course_id = @course_Id 
          AND Art_Question_ID IN (SELECT value FROM STRING_SPLIT(@ART_Questions, ','));

        -- Insert the MCQ questions into Exam_Questions table
        INSERT INTO Exam_Questions (Exam_Name, Question_Id, Question_Type, Question_Text, Choice1, Choice2, Choice3, Choice4, course_id)
        SELECT @newExamName, MC_Question_ID, 'MCQ', question_text, Choice1, Choice2, Choice3, Choice4, @course_Id 
        FROM Question.Multichoice_Question
        WHERE course_id = @course_Id 
          AND MC_Question_ID IN (SELECT value FROM STRING_SPLIT(@MCQ_Questions, ','));

        -- Insert the TF questions into Exam_Questions table
        INSERT INTO Exam_Questions (Exam_Name, Question_Id, Question_Type, Question_Text, course_id)
        SELECT @newExamName, TF_Question_ID, 'TF', Question_Text, @course_Id 
        FROM Question.True_Or_False_Question
        WHERE course_id = @course_Id 
          AND TF_Question_ID IN (SELECT value FROM STRING_SPLIT(@TF_Questions, ','));

        -- Insert exam details into Exam_Details table
        INSERT INTO Exam_Details (Exam_Name, Year, Total_Degree, Exam_Date, Start_Time, End_Time, Type, Created_By)
        VALUES (@newExamName, @year, @total_degree, @exam_date, @start_time, @end_time, @type, @systemUserName);

        -- Select the new exam questions and details
        SELECT Exam_Name, Question_Id, Question_Type, Question_Text, course_id,
               ISNULL(Choice1, '') AS Choice1, 
               ISNULL(Choice2, '') AS Choice2, 
               ISNULL(Choice3, '') AS Choice3, 
               ISNULL(Choice4, '') AS Choice4
        FROM Exam_Questions 
        WHERE Exam_Name = @newExamName;

        SELECT Exam_Name, Year, Total_Degree, Exam_Date, Start_Time, End_Time, Type, Created_By
        FROM Exam_Details
        WHERE Exam_Name = @newExamName;
    END 
END;


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

----PROC TO READ QUESTIONS IN HIS COURSE ONLY SO HE CAN SELECT THE IDS OF THE QUESTIONS MANUALLY--


alter PROC read_questions_in_my_course (@course_id int)
as 
begin 
if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
 IF NOT EXISTS (
        SELECT u.User_ID 
        FROM users u 
        JOIN Courses c ON u.User_ID = c.Instractor_ID 
        WHERE u.Name = SYSTEM_USER 
          AND (u.role = 'Instructor' OR u.role = 'Training_Manager') 
          AND c.Course_ID = @course_Id
    )
    BEGIN 
        PRINT 'You cannot make exam as you are not an instructor or you are not an instructor for this course';
    END
    ELSE 
	begin
	select * from Question.Article_Question  where course_id=@course_Id
	select * from Question.Multichoice_Question  where course_id=@course_Id
	select * from Question.True_Or_False_Question  where course_id=@course_Id
	end
end


---------------------------------------------------------
--------------------------------------------------------
---------------------------------------------------------

select * from users
select * from Exam_Details



CREATE TABLE Student_Exams (
    Student_Id INT NOT NULL,
    Exam_Id INT NOT NULL,
    Assigned_Date DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (Student_Id, Exam_Id),
    constraint Student_Id_fk FOREIGN KEY (Student_Id) REFERENCES users(User_ID),
    constraint Exam_id_fk FOREIGN KEY (Exam_Id) REFERENCES Exam_Details(Exam_Id))
	go





-----instructor assign student in specific exam ------------------------------------

ALTER PROCEDURE assign_student_to_exam 
    @student_Id INT, 
    @exam_Id INT,
    @course_id INT
AS
BEGIN
if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
    -- Check if the user executing the procedure is an instructor for the specified course
    IF NOT EXISTS (
        SELECT 1
        FROM users u
        JOIN Courses c ON u.User_ID = c.Instractor_ID
        WHERE u.Name = SYSTEM_USER
          AND (u.role = 'Instructor' OR u.role = 'Training_Manager')
          AND c.Course_ID = @course_id
    )
    BEGIN
        PRINT 'You cannot assign a student to the exam as you are not an instructor or you are not an instructor for this course';
        RETURN;
    END

    -- Check if the exam exists
    IF NOT EXISTS (SELECT 1 FROM Exam_Details WHERE Exam_Id = @exam_Id)
    BEGIN
        PRINT 'Exam does not exist';
        RETURN;
    END

    -- Check if the user is a student
    IF NOT EXISTS (SELECT 1 FROM users WHERE User_ID = @student_Id AND role = 'Student')
    BEGIN
        PRINT 'The specified user is not a student';
        RETURN;
    END

    -- Check if the student is already assigned to the exam
    IF EXISTS (
        SELECT 1
        FROM Student_Exams s
        JOIN users u ON s.Student_Id = u.User_ID
        WHERE s.Student_Id = @student_Id
          AND s.Exam_Id = @exam_Id
          AND u.role = 'Student'
    )
    BEGIN
        PRINT 'Student is already assigned to this exam';
        RETURN;
    END

    -- Assign the student to the exam
    INSERT INTO Student_Exams (Student_Id, Exam_Id, Assigned_Date)
    VALUES (@student_Id, @exam_Id, GETDATE());

    PRINT 'Student assigned to exam successfully';
END;

---------------------------------------
----------------------------------------------------------
---------------------------------------------------------------------
-------proc to-retrieve exam for student---------------
---------------------------------------
----------------------------------------------------------
---------------------------------------------------------------------
alter PROCEDURE get_student_exam 
    @student_Id INT, 
    @exam_Id INT
AS
BEGIN
if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
    -- Check if the current user is the student
    IF NOT EXISTS (
        SELECT 1 
        FROM users 
        WHERE Name = SYSTEM_USER 
          AND User_ID = @student_Id 
          AND role = 'Student'
    )
    BEGIN
        PRINT 'Wrong ID or you are not a student';
        RETURN;
    END

    -- Check if the student is assigned to the exam
    IF NOT EXISTS (
        SELECT 1 
        FROM Student_Exams 
        WHERE Student_Id = @student_Id 
          AND Exam_Id = @exam_Id
    )
    BEGIN
        PRINT 'Student is not assigned to this exam';
        RETURN;
    END

    -- Retrieve the exam details
    SELECT ed.Exam_Id, ed.Year, ed.Total_Degree, ed.Exam_Date, ed.Start_Time, ed.End_Time, ed.Type, ed.Created_By
    FROM Exam_Details ed
    WHERE ed.Exam_Id = @exam_Id;

    -- Retrieve the exam questions
    SELECT eq.Question_Id, eq.Question_Type, eq.Question_Text, isnull(eq.Choice1,'')as a, isnull(eq.Choice2,'')as b,isnull( eq.Choice3,'')as c,isnull( eq.Choice4,'') as d
    FROM Exam_Questions eq , Exam_Details ed
    WHERE ed.Exam_Id = @exam_Id;
END;


-----------------------------------------
---create table to take exam answers
------------------------------------------

CREATE TABLE Student_Answers (
    Answer_Id INT IDENTITY PRIMARY KEY,
    Student_Id INT,
    Exam_Id INT,
    Question_Id INT,
    Question_Type VARCHAR(20),
    Answer_Text VARCHAR(MAX),
    Answer_Date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Student_Id) REFERENCES users(User_ID),
    FOREIGN KEY (Exam_ID) REFERENCES Exam_Details(Exam_ID),
    FOREIGN KEY (Question_Id) REFERENCES Question.Questions(Question_Id)
);

------------------------------------------------------------
------------------------------------------------------------
---proc to submit student answers----------
Alter PROCEDURE submit_exam_answers 
    @student_Id INT, 
    @exam_Id INT,
    @question_ids NVARCHAR(MAX),
    @question_types NVARCHAR(MAX),
    @answer_texts NVARCHAR(MAX)
AS
BEGIN
if ( SYSTEM_USER='AdminUser')
    -- Debugging: Print input parameters to check formatting
    PRINT 'Input Parameters:';
    PRINT '@question_ids: ' + @question_ids;
    PRINT '@question_types: ' + @question_types;
    PRINT '@answer_texts: ' + @answer_texts;

    -- Check if the current user is the student
    IF NOT EXISTS (
        SELECT 1 
        FROM users 
        WHERE Name = SYSTEM_USER 
          AND User_ID = @student_Id 
          AND role = 'Student'
    )
    BEGIN
        PRINT 'Wrong ID or you are not a student';
        RETURN;
    END

    -- Check if the student is assigned to the exam
    IF NOT EXISTS (
        SELECT 1 
        FROM Student_Exams 
        WHERE Student_Id = @student_Id 
          AND Exam_Id = @exam_Id
    )
    BEGIN
        PRINT 'Student is not assigned to this exam';
        RETURN;
    END

    -- Check if the student has already submitted answers for the exam
    IF EXISTS (
        SELECT 1 
        FROM Student_Answers 
        WHERE Student_Id = @student_Id 
          AND Exam_Id = @exam_Id
    )
    BEGIN
        PRINT 'You have already submitted answers for this exam';
        RETURN;
    END

    -- Check if the current date and time are before the exam end date and time
    DECLARE @currentDateTime DATETIME = GETDATE();
    DECLARE @examEndDateTime DATETIME;

    SELECT @examEndDateTime = CAST(Exam_Date AS DATETIME) + CAST(End_Time AS DATETIME)
    FROM Exam_Details 
    WHERE Exam_Id = @exam_Id;

    IF @currentDateTime > @examEndDateTime
    BEGIN
        PRINT 'You cannot submit answers after the exam end date and time';
        RETURN;
    END

    -- Parse the input parameters
    DECLARE @question_id_table TABLE (Id INT IDENTITY(1,1), Question_Id INT);
    DECLARE @question_type_table TABLE (Id INT IDENTITY(1,1), Question_Type VARCHAR(20));
    DECLARE @answer_text_table TABLE (Id INT IDENTITY(1,1), Answer_Text NVARCHAR(MAX));

    INSERT INTO @question_id_table (Question_Id) SELECT value FROM STRING_SPLIT(@question_ids, ',');
    INSERT INTO @question_type_table (Question_Type) SELECT value FROM STRING_SPLIT(@question_types, ',');

    -- Split answers by ", and remove leading/trailing quotes
    DECLARE @pos INT = 0;
    DECLARE @nextpos INT = 0;
    DECLARE @answer NVARCHAR(MAX);

    WHILE CHARINDEX(',"', @answer_texts, @pos + 1) > 0
    BEGIN
        SET @nextpos = CHARINDEX(',"', @answer_texts, @pos + 1) + 1;
        SET @answer = SUBSTRING(@answer_texts, @pos + 1, @nextpos - @pos - 1);
        SET @answer = REPLACE(@answer, '"', '');
        INSERT INTO @answer_text_table (Answer_Text) VALUES (@answer);
        SET @pos = @nextpos;
    END

    -- Handle the last or only element
    SET @answer = SUBSTRING(@answer_texts, @pos + 1, LEN(@answer_texts) - @pos);
    SET @answer = REPLACE(@answer, '"', '');
    INSERT INTO @answer_text_table (Answer_Text) VALUES (@answer);

    -- Validate that the counts of questions, types, and answers match
    DECLARE @question_count INT = (SELECT COUNT(*) FROM @question_id_table);
    DECLARE @type_count INT = (SELECT COUNT(*) FROM @question_type_table);
    DECLARE @answer_count INT = (SELECT COUNT(*) FROM @answer_text_table);

    IF @question_count <> @type_count OR @question_count <> @answer_count
    BEGIN
        PRINT 'Mismatch in the number of questions, types, and answers';
        PRINT '@question_count: ' + CAST(@question_count AS NVARCHAR(10));
        PRINT '@type_count: ' + CAST(@type_count AS NVARCHAR(10));
        PRINT '@answer_count: ' + CAST(@answer_count AS NVARCHAR(10));
        RETURN;
    END

    -- Insert each answer into the Student_Answers table
    DECLARE @i INT = 1;
    WHILE @i <= @question_count
    BEGIN
        DECLARE @question_id INT;
        DECLARE @question_type VARCHAR(20);
        DECLARE @answer_text NVARCHAR(MAX);

        SELECT @question_id = Question_Id FROM @question_id_table WHERE Id = @i;
        SELECT @question_type = Question_Type FROM @question_type_table WHERE Id = @i;
        SELECT @answer_text = Answer_Text FROM @answer_text_table WHERE Id = @i;

        -- Debugging: Print the values to be inserted
        PRINT 'Inserting:';
        PRINT 'Question_Id: ' + CAST(@question_id AS NVARCHAR(10));
        PRINT 'Question_Type: ' + @question_type;
        PRINT 'Answer_Text: ' + @answer_text;

        -- Insert the answer into Student_Answers table
        INSERT INTO Student_Answers (Student_Id, Exam_Id, Question_Id, Question_Type, Answer_Text, Answer_Date)
        VALUES (@student_Id, @exam_Id, @question_id, @question_type, @answer_text, GETDATE());

        SET @i = @i + 1;
    END

    PRINT 'Answers submitted successfully';
END;


------------------------------------------------
------------------------------------------------
--------------------------------------------------create table to save the data of exam result 

CREATE TABLE Exam_Results (
    Result_ID INT IDENTITY(1,1) PRIMARY KEY,
    Student_Id INT NOT NULL,
    Exam_Id INT NOT NULL,
    Course_Id INT NOT NULL,
    Total_Mark INT NOT NULL,
    Exam_Date DATE NOT NULL,
    Exam_Time TIME NOT NULL,
    FOREIGN KEY (Student_Id) REFERENCES users(User_ID),
    FOREIGN KEY (Exam_Id) REFERENCES Exam_Details(Exam_Id),
    FOREIGN KEY (Course_Id) REFERENCES Courses(Course_ID)
);

--------------------------------------

------------------------------------------------
------------------------------------------------create proc to correct the exam
------------------------- function to split words and call it in procedure correct_exam_answers to return essay best correct answers------------------------------
----------------------------------------------------------------------------------------
CREATE FUNCTION dbo.SplitString (@string NVARCHAR(MAX), @delimiter CHAR(1))
RETURNS @output TABLE (word NVARCHAR(MAX))
AS
BEGIN
    DECLARE @start INT, @end INT
    SET @start = 1
    WHILE @start <= LEN(@string)
    BEGIN
        SET @end = CHARINDEX(@delimiter, @string, @start)
        IF @end = 0 
            SET @end = LEN(@string) + 1
        INSERT INTO @output (word) 
        VALUES (SUBSTRING(@string, @start, @end - @start))
        SET @start = @end + 1
    END
    RETURN
END

-------------------------------------------------- 
ALTER PROCEDURE correct_exam_answers
    @student_Id INT,
    @exam_Id INT,
    @course_id INT
AS  
BEGIN
if ( SYSTEM_USER='AdminUser')
    -- Check if the user is an instructor or training manager
    IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE Name = SYSTEM_USER AND (role = 'Instructor' OR role = 'Training_Manager')
    )
    BEGIN
        PRINT 'You are not an instructor or training manager';
        RETURN;
    END

    -- Check if the student is assigned to the exam
    IF NOT EXISTS (SELECT 1 FROM Student_Exams WHERE Student_Id = @student_Id AND Exam_Id = @exam_Id)
    BEGIN
        PRINT 'Student is not assigned to this exam';
        RETURN;
    END

    -- Variables to hold total marks
    DECLARE @total_marks INT = 0;
    DECLARE @question_type VARCHAR(20);
    DECLARE @question_id INT;
    DECLARE @correct_answer NVARCHAR(MAX);
    DECLARE @student_answer NVARCHAR(MAX);

    -- Cursor to iterate over student's answers
    DECLARE answer_cursor CURSOR FOR
    SELECT sa.Question_Id, eq.Question_Type, sa.Answer_Text
    FROM Student_Answers sa
    JOIN Exam_Questions eq ON sa.Question_Id = eq.Question_Id
    WHERE sa.Student_Id = @student_Id AND sa.Exam_Id = @exam_Id;

    OPEN answer_cursor;
    FETCH NEXT FROM answer_cursor INTO @question_id, @question_type, @student_answer;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Processing Question ID: ' + CAST(@question_id AS VARCHAR);
        PRINT 'Question Type: ' + @question_type;
        PRINT 'Student Answer: ' + @student_answer;

        IF @question_type = 'Essay'
        BEGIN
            -- Fetch the correct answer for the essay question
            SELECT @correct_answer = Question_Text
            FROM Question.Article_Question
            WHERE Art_Question_ID = @question_id;

            PRINT 'Correct Answer (Essay): ' + @correct_answer;

            -- Split the correct answer into keywords
            DECLARE @correct_words TABLE (word NVARCHAR(MAX));
            INSERT INTO @correct_words (word)
            SELECT word FROM dbo.SplitString(@correct_answer, ' ');

            -- Check if the student's answer contains at least a certain percentage of keywords
            DECLARE @total_keywords INT;
            SELECT @total_keywords = COUNT(*) FROM @correct_words;

            DECLARE @matched_keywords INT = 0;
            DECLARE @word NVARCHAR(MAX);

            DECLARE keyword_cursor CURSOR FOR
            SELECT word FROM @correct_words;

            OPEN keyword_cursor;
            FETCH NEXT FROM keyword_cursor INTO @word;

            WHILE @@FETCH_STATUS = 0
            BEGIN
                IF @student_answer LIKE '%' + @word + '%'
                BEGIN
                    SET @matched_keywords = @matched_keywords + 1;
                END
                FETCH NEXT FROM keyword_cursor INTO @word;
            END

            CLOSE keyword_cursor;
            DEALLOCATE keyword_cursor;

            -- Assuming a threshold for similarity (e.g., 50% of keywords matched)
            IF @matched_keywords >= (@total_keywords / 2) -- Adjust the threshold value as needed
            BEGIN
                SET @total_marks = @total_marks + 1; -- Adjust the marking scheme as needed
                PRINT 'Correct Essay Answer';
            END
        END
        ELSE IF @question_type = 'MCQ'
        BEGIN
            SELECT @correct_answer = Correct_Answer
            FROM Question.Multichoice_Question
            WHERE MC_Question_ID = @question_id;

            PRINT 'Correct Answer (MCQ): ' + @correct_answer;

            -- Remove punctuation and whitespace for comparison
            IF REPLACE(REPLACE(REPLACE(REPLACE(@correct_answer, ' ', ''), ',', ''), '.', ''), ')', '') = REPLACE(REPLACE(REPLACE(REPLACE(@student_answer, ' ', ''), ',', ''), '.', ''), ')', '')
            BEGIN
                SET @total_marks = @total_marks + 1; -- Adjust the marking scheme as needed
                PRINT 'Correct MCQ Answer';
            END
        END
        ELSE IF @question_type = 'TF'
        BEGIN
            SELECT @correct_answer = Correct_Answer
            FROM Question.True_Or_False_Question
            WHERE TF_Question_ID = @question_id;

            PRINT 'Correct Answer (TF): ' + @correct_answer;

            -- Direct comparison for TF questions
            IF @correct_answer = @student_answer
            BEGIN
                SET @total_marks = @total_marks + 1; -- Adjust the marking scheme as needed
                PRINT 'Correct TF Answer';
            END
        END

        FETCH NEXT FROM answer_cursor INTO @question_id, @question_type, @student_answer;
    END

    CLOSE answer_cursor;
    DEALLOCATE answer_cursor;

    PRINT 'Total Marks: ' + CAST(@total_marks AS VARCHAR);

    -- Insert the exam result into Exam_Results table
    INSERT INTO Exam_Results (Student_Id, Exam_Id, Course_Id, Total_Mark, Exam_Date, Exam_Time)
    VALUES (@student_Id, @exam_Id, @course_id, @total_marks, CAST(GETDATE() AS DATE), CAST(GETDATE() AS TIME));

    PRINT 'Exam corrected successfully';
END;



select * from student_exams
select * from Exam_Results
select*from Exam_Details

delete  from student_exams
delete  from Exam_Results
delete from student_answers
delete  from Exam_Results
----------------------------------------
-------------------procedure to view exam results ------------
---------------------

alter PROCEDURE proc_toview_Exam_results
AS 
BEGIN
if ( SYSTEM_USER='AdminUser')
    -- Check if the current user is allowed to see the data
    IF NOT EXISTS (
        SELECT u.User_ID 
        FROM users u 
        JOIN Exam_Details e ON u.Name = e.Created_By
        WHERE u.Name = SYSTEM_USER 
          AND (u.role = 'Instructor' OR u.role = 'Training_Manager')
    )
    BEGIN 
        PRINT 'You are not allowed to see this data';
    END
    ELSE 
    BEGIN
        -- Check if the view already exists and drop it if it does
        IF OBJECT_ID('V_Exam_Results', 'V') IS NOT NULL
        BEGIN
            DROP VIEW V_Exam_Results;
        END

        -- Create the view
        EXEC('CREATE VIEW V_Exam_Results AS
            SELECT se.*, er.* 
            FROM student_exams se
            JOIN Exam_Results er ON se.Student_Id = er.Student_Id AND se.Exam_Id = er.Exam_Id;');
        
        PRINT 'View V_Exam_Results created successfully';
    END
END;
----------------------------------------------
-----------------proc for instructor  to insert questions in his course only---------------------------------
-----------------
alter proc insert_questions (@course_id  int , @question_text nvarchar(max),@question_type nvarchar(max),@degree int)
as 

begin
if ( SYSTEM_USER='AdminUser')
IF NOT EXISTS (
        SELECT u.User_ID 
        FROM users u 
        JOIN Courses c ON u.User_ID = c.Instractor_ID 
        WHERE u.Name = SYSTEM_USER 
          AND (u.role = 'Instructor' OR u.role = 'Training_Manager') 
          AND c.Course_ID = @course_id
    )
    BEGIN 
        PRINT 'You cannot make exam as you are not an instructor or you are not an instructor for this course';
    END
    ELSE 
	begin 
	insert into Question.Questions (Question_Text,Question_Type,degree,course_id,inst_ID)
	values (@question_text,@question_type,@degree,@course_id,(SELECT u.User_ID FROM users u WHERE u.Name = SYSTEM_USER ))


end;
End;
go


