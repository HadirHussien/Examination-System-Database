drop PROCEDURE make_random_exam_proc 
    @course_Id INT, 
    @no_of_ART INT,
    @no_of_mcq INT, 
    @no_of_TF INT
AS
BEGIN
    -- Variables for dynamic SQL
    DECLARE @sql NVARCHAR(MAX);
    DECLARE @tableName NVARCHAR(128);
    DECLARE @examName NVARCHAR(100);
    DECLARE @examId INT;

    -- Generate a unique exam name based on current date and time without special characters
    SET @examName = 'exam_' + REPLACE(CONVERT(NVARCHAR(30), GETDATE(), 120), ':', '_');
    SET @examName = REPLACE(@examName, ' ', '_');
    SET @tableName = 'exam.' + @examName;

    -- Log the created exam in the Exams table
    INSERT INTO exam.Exams (Exam_Name)
    VALUES (@examName);

    -- Retrieve the generated Exam_Id
    SET @examId = SCOPE_IDENTITY();

    -- Create the new table
    SET @sql = '
    CREATE TABLE ' + @tableName + ' (
        Exam_Question_Id INT IDENTITY(1,1) PRIMARY KEY,
        Exam_Id INT,
        Question_Id INT,
        Question_Type NVARCHAR(20),
        Question_Text NVARCHAR(MAX),
        Choice1 NVARCHAR(MAX) NULL,
        Choice2 NVARCHAR(MAX) NULL,
        Choice3 NVARCHAR(MAX) NULL,
        Choice4 NVARCHAR(MAX) NULL
    );
    ';
    EXEC sp_executesql @sql;

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

    -- Insert the questions into the new exam table
    SET @sql = '
    INSERT INTO ' + @tableName + ' (Exam_Id, Art_Question_ID, Question_Type, Question_Text, Choice1, Choice2, Choice3, Choice4)
    SELECT ' + CAST(@examId AS NVARCHAR) + ', Art_Question_ID, ''Essay'', Question_Text, NULL, NULL, NULL, NULL FROM #Essay_questions;

    INSERT INTO ' + @tableName + ' (Exam_Id, MC_Question_ID, Question_Type, Question_Text, Choice1, Choice2, Choice3, Choice4)
    SELECT ' + CAST(@examId AS NVARCHAR) + ', MC_Question_ID, ''MCQ'', question_text, Choice1, Choice2, Choice3, Choice4 FROM #MCQ_questions;

    INSERT INTO ' + @tableName + ' (Exam_Id, TF_Question_ID, Question_Type, Question_Text, Choice1, Choice2, Choice3, Choice4)
    SELECT ' + CAST(@examId AS NVARCHAR) + ', TF_Question_ID, ''TF'', Question_Text, NULL, NULL, NULL, NULL FROM #TF_questions;
    ';
    EXEC sp_executesql @sql;
END;


exec make_random_exam_proc 4,5,5,5 
go
create schema exam 
CREATE TABLE exam.Exams (
    Exam_Id INT IDENTITY(1,1) PRIMARY KEY,
    Exam_Name NVARCHAR(100),
    Creation_Time DATETIME DEFAULT GETDATE()
);

go


drop PROCEDURE read_exam_proc
    @Exam_Id INT
AS
BEGIN
    DECLARE @tableName NVARCHAR(128);
    DECLARE @sql NVARCHAR(MAX);

    -- Get the table name for the specified Exam_Id
    SELECT @tableName = 'exam.' + Exam_Name
    FROM exam.Exams
    WHERE Exam_Id = @Exam_Id;

    -- Construct the dynamic SQL to read from the specific exam table
    SET @sql = 'SELECT * FROM [' + @tableName + ']';
    
    -- Execute the dynamic SQL
    EXEC sp_executesql @sql;
END;




SELECT Exam_Id, Exam_Name, Creation_Time
FROM exam.Exams;

-- Read a specific exam by its ID
EXEC read_exam_proc @Exam_Id =5;
