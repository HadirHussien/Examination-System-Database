--exec  make_random_exam_proc  4,5,5,5,2024,15,'2024-07-18','09:00','11:00','Regular'
/*EXEC make_random_exam_proc 
    @course_Id = 1, 
    @no_of_ART = 2, 
    @no_of_mcq = 3, 
    @no_of_TF = 1,
    @year = 2024,
    @total_degree = 100,
    @exam_date = '2024-07-20',
    @start_time = '09:00',
    @end_time = '11:00',
    @type = 'Regular';*/



	---
	--- example of making manual exam in his course and select questions 

         ----PROC TO READ QUESTIONS IN HIS COURSE ONLY SO HE CAN SELECT THE IDS OF THE QUESTIONS MANUALLY--
	--EXEC read_questions_in_my_course (@course_id int)
	/*EXEC read_questions_in_my_course 4

	EXEC make_manual_exam_proc 
    @course_Id = 4, 
    @ART_Questions = '116,119,122', -- List of ART question IDs
    @MCQ_Questions = '109,114,106', -- List of MCQ question IDs
    @TF_Questions = '96,101,100,105', -- List of TF question IDs
    @year = 2024,
    @total_degree = 10,
    @exam_date = '2024-07-20',
    @start_time = '09:00',
    @end_time = '11:00',
    @type = 'Regular';*/

	----------------------------------------------------------------
-------------- just to see the past exams he had made before in his course only -------
--EXEC Read_Past_Exams (@Exam_Name nvarchar(100),@course_id int)
-- example of execution
--EXEC  Read_Past_Exams 'exam1',4



-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------

/* instructor assign student into specific exam */ 

----------------------------------
/*EXEC assign_student_to_exam 
    @student_Id INT, 
    @exam_Id INT*/

	EXEC assign_student_to_exam 5,1,4
----------------------------------------------------------



--proc to correct the exam ----


  /*EXEC correct_exam_answers 
    @student_Id INT, 
    @exam_Id INT,
    @course_Id INT
	*/

	EXEC correct_exam_answers 5,1,4 

