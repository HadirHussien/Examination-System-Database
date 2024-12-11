select * from Courses 
go

----SQL
create schema SQL 
go
select * into SQL.SQL_Questions_ART
from Question.Article_Question where Art_Question_ID between 21 and 30


go
select * into SQL.SQL_Questions_True_Or_False
from Question.True_Or_False_Question where TF_Question_ID between 1 and 10
go 


------------OOP 
create schema OOP
go
select * into OOP.OOP_Questions_ART
from Question.Article_Question where Art_Question_ID between 36 and 45
go 

select * into OOP.OOP_True_Or_False_Question
from  Question.True_Or_False_Question where TF_Question_ID between 56 and 65
go

select * into OOP.OOP_Multichoice_Question
from  Question.Multichoice_Question where MC_Question_ID  between 46 and 55
go 


-----------C#
create schema C#
go
select * into C#.C#_Questions_ART
from Question.Article_Question where Art_Question_ID between 66 and 75
go 

select * into C#.C#_True_Or_False_Question
from  Question.True_Or_False_Question where TF_Question_ID between 76 and 85
go

select * into C#.C#_Multichoice_Question
from  Question.Multichoice_Question where MC_Question_ID  between 86 and 95
go 

-----HTML
create schema python
go
select * into python.python_Questions_ART
from Question.Article_Question where Art_Question_ID between 116 and 125
go 

select * into python.python_True_Or_False_Question
from  Question.True_Or_False_Question where TF_Question_ID between 96 and 105
go

select * into python.python_Multichoice_Question
from  Question.Multichoice_Question where MC_Question_ID  between 106 and 115
go 

select * from python.python_Questions_ART
select * from python.python_True_Or_False_Question
select * from python.python_Multichoice_Question
go
--------html
create schema HTML
go
select * into HTML.HTML_Questions_ART
from Question.Article_Question where Art_Question_ID between 146 and 155
go 

select * into HTML.HTML_True_Or_False_Question
from  Question.True_Or_False_Question where TF_Question_ID between 126 and 135
go

select * into HTML.HTML_Multichoice_Question
from  Question.Multichoice_Question where MC_Question_ID  between 136 and 145
go 

----------------CSS
create schema CSS
go
select * into CSS.CSS_Questions_ART
from Question.Article_Question where Art_Question_ID between 176 and 185
go 

select * into CSS.CSS_True_Or_False_Question
from  Question.True_Or_False_Question where TF_Question_ID between 156 and 165
go

select * into CSS.CSS_Multichoice_Question
from  Question.Multichoice_Question where MC_Question_ID  between 166 and 175
go 


select * from Question.Questions
go
select * from Question.True_Or_False_Question
go
select* from Question.Article_Question
go
select* from Question.Multichoice_Question


select*from C#.C#_Multichoice_Question





alter table Question.Article_Question
add course_id int
alter table Question.Article_Question
add constraint course_id_fk foreign key(course_id) references courses(Course_ID)

alter table Question.Article_Question
add question_text nvarchar(200)