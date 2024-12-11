
alter table exam
add inst_ID int 
go
alter table exam
add constraint FK_ins_id foreign key (inst_ID) references users(User_ID) 

alter table Question.Questions
add inst_ID int 
go
alter table Question.Questions
add constraint FK_ins_id foreign key (inst_ID) references users(User_ID) 
go
------------------------------------------------------------------------------------------------
update Question.Questions
 set inst_ID = 2 where course_id=2
 go
 update Question.Questions
 set inst_ID = 3 where course_id=3
 go
 update Question.Questions
 set inst_ID = 1 where course_id=1
go
 update Question.Questions
 set inst_ID = 4 where course_id=4
go


 update Question.Questions
 set inst_ID = 1 where course_id=5
go

 update Question.Questions
 set inst_ID = 2 where course_id=6
go
