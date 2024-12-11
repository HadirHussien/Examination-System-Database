
---- Stored procedure for Training manager to add instructor to course
EXEC Proc_AddInstructorToCourse @CourseID = 1, @CourseName = 'hhh', @InstructorID = 2;


---- Stored procedure for Training manager to update instructor to course
EXEC Proc_UpdateInstructorID @CourseID = 4, @newInstructorID = 5


---- Stored procedure for Training manager to delete instructor to course
EXEC Proc_DeleteInstructorID @CourseID = 2

---------------------------------------------------------------------------------------
--- View for the training manager to view all tracks
--- be on the training manager Hadir
Select * from View_Tracks


---------------------------------------------------------------------------------------
---- TEST on prevent student to add question
INSERT INTO question.questions (Question_Text, Question_Type, degree, course_id)
VALUES ('What is 2+2?', 'MCQ', 1, 1)

SELECT * FROM question.questions ;



---------------------------------------------------------------------------------------
---- TEST on prevent student to update question
UPDATE question.questions
SET Question_Text = 'What is 3+3?'
WHERE Question_ID = 2 ;

SELECT * FROM question.questions WHERE Question_ID = 2;



--------------------------------------------------------------------------------------
--- TEST on prevent student to delete question
DELETE FROM question.questions
WHERE Question_ID = 2;

SELECT * FROM question.questions WHERE Question_ID = 2;

