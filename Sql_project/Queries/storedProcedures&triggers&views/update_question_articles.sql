update [Question].[Article_Question]
set course_id= 1 
where Art_Question_ID between 21 and 30

update [Question].[Article_Question]
set course_id= 2 
where Art_Question_ID between 66 and 75

update [Question].[Article_Question]
set course_id= 4
where Art_Question_ID between 116 and 125

update [Question].[Article_Question]
set course_id= 5
where Art_Question_ID between 146 and 155




update [Question].[Article_Question]
set course_id= 6
where Art_Question_ID between 176 and 185


update [Question].[Article_Question]
set course_id= 3
where Art_Question_ID between 36 and 45


select * from Question.Questions
select * from Question.Article_Question
go

UPDATE aq
SET aq.question_text = q.Question_Text
FROM Question.Article_Question aq
JOIN Question.Questions q 
    ON aq.course_id = q.course_id 
    AND q.Question_ID = aq.Art_Question_ID
WHERE q.Question_Type = 'ART';

select * from Question.Article_Question

select * from Courses





