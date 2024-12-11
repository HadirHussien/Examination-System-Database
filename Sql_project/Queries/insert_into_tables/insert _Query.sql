--insert values to branch
insert into branch
values
    (1,'cairo','2000-01-01','Ali','iti cairo'),
	(2,'mansoura','2000-01-01','Eslam','iti mansoura'),
	(3,'assiut','2000-01-01','Basma','iti assiut'),
	(4,'alex','2000-01-01','Elham','iti alex'),
	(5,'minia','2000-01-01','Hadir','iti minia'),
	(6,'smart','2000-01-01','Nabil','iti smart'),
	(7,'banisuaf','2000-01-01','Omar','iti banisuaf'),
	(8,'fayom','2000-01-01','Faris','iti fayom'),
	(9,'sohag','2000-01-01','Mohamed','iti sohag'),
	(10,'newcapital','2000-01-01','Ahmed','iti newcapital')
--insert values to intake
insert into	intake
values
	(1,1,2024,1),
	(2,2,2024,1),
	(3,3,2024,1)
--insert values to department
insert into	department
values
	(1,1,'Information Technology'),
	(2,2,'Networks'),
	(3,3,'Grafics')
--insert values to track
insert into	track
values
	(1,1,'full stack web development using .Net'),
	(2,2,'system adminstration'),
	(3,3,'social media')
--insert values to users
insert into	users
values
(1,'Sarah_Salah','123456789','Sarah Salah','01024356879','Instructor','saeah@gmail.com'),
(2,'Ali_abozaid','1111','Ali','01024356812','Instructor','Ali@gmail.com'),
(3,'Basma_S','2222','Basma','01024356821','Instructor','Basma@gmail.com'),
(4,'Hadir_S','3333','Hadir','01024356834','Training_Manager','Hadir@gmail.com'),
(5,'Elham_S','4444','Elham','01024356843','Student','Elham@gmail.com'),
(6,'Eslam_S','5555','Eslam','01024356856','Student','Eslam@gmail.com'),
(7,'Karim_S','6666','Karim_','01024356865','Student','Karim@gmail.com'),
(8,'Faris_Sh','7777','Faris','010243568778','Student','Faris@gmail.com'),
(9,'mohamed_S','8888','mohamed','01024356887','Student','mohamed@gmail.com'),
(10,'ahmed_S','9999','ahmed','01024356889','Student','ahmed@gmail.com'),
(11,'nawal_S','11111','nawal','01024356898','Student','nawal@gmail.com'),
(12,'mariem_S','22222','mariem','01024356899','Student','mariem@gmail.com'),
(13,'abdelrahmen_Sa','33333','abdelrahmen','01024356888','Student','abdelrahmen@gmail.com'),
(14,'naser_S','44444','naser','01024312549','Student','naser@gmail.com'),
(15,'abdelRahem','55555','abdelRahem','01023542212','Student','abdelRahem@gmail.com'),
(16,'hassn_S','66666','hassan','01024356821','Student','hassn@gmail.com'),
(17,'hussin_S','77777','hussin','0111234356834','Student','hussin@gmail.com'),
(18,'lekaa_S','88888','lekaa','01234356843','Student','lekaa@gmail.com'),
(19,'israa_S','99999','israa','01054356856','Student','israa@gmail.com'),
(20,'walaa_S','111111','walaa','01044356865','Student','walaa@gmail.com'),
(21,'mahmoud_Shf','222222','mahmoud ali','011643568778','Student','mahmoud_Shf@gmail.com'),
(22,'nabil_S','333333','nabil','01034356887','Student','nabil@gmail.com'),
(23,'taki_S','444444','taki','01044356889','Student','taki@gmail.com'),
(24,'mina_S','555555','mina','01054356898','Student','mina@gmail.com'),
(25,'mena_S','666666','mena','01064356899','Student','mena@gmail.com'),
(26,'rana_Sa','777777','rana','01074356888','Student','rana@gmail.com')

-----insert to UserRoles
INSERT INTO UserRoles 
VALUES 
(1, 'Instructor'),
(2, 'Instructor'),
(3, 'Instructor')
(4, 'Training_Manager');


--insert values to Instuctors
INSERT INTO Instructors 
VALUES 
(1, 5, 4, 'Training_Manager', 'FULL STACK WEB DEVELOPMENT USING .NET'),
(2, 5, 4, 'Training_Manager', 'FULL STACK WEB DEVELOPMENT USING PYTHON'),
(3, 5, 4, 'Training_Manager', 'FULL STACK WEB DEVELOPMENT USING .NET'),
(4, 5, 4, 'Training_Manager', 'FULL STACK WEB DEVELOPMENT USING MERN');


-------------Insert courses table
Insert into Courses
Values 
(1,'SQL','The course covers the basics of SQL, including creating tables, manipulating data, and querying databases',100,60,1),
(2,'OOP','Object-oriented programming is a computer programming model that organizes software design around data,or objects,functions and logic.',100,60,2),
(3,'C#','C# supports object oriented techniques such as inheritance and polymorphism for class types.',100,60,3),
(4,'Python','Python is a widely-used general-purpose, object-oriented, high-level programming language.',100,60,4),
(5,'Html5','HTML stands for Hyper Text Markup Language. It is used to design web pages using a markup language.',100,60,1),
(6,'Css3','CSS is the language we use to style an HTML document.',100,60,2);

-------------Insert Courses_In_Track table
INSERT INTO Courses_In_Track (Course_ID, track_ID) 
VALUES 
(1 , 1),
(1 , 2),
(1 , 3),
(2 , 1),
(2 , 2),
(2 , 3),
(3 , 1),
(3 , 2),
(3 , 3),
(4 , 1),
(5 , 2),
(6 , 3);

---------Insert Students Table
Insert Into Students
Values
(5,5,1,3,'N/A','Faculty of Computer and Information'),
(6,5,1,3,'Fulfilled','Faculty of Computer and Information'),
(7,5,2,3,'Fulfilled','Faculty of Engineering'),
(8,5,3,3,'Exemption','Faculty of Engineering'),
(9,5,2,3,'Fulfilled','Faculty of Computing and Information'),
(10,5,1,3,'Fulfilled','Faculty of Engineering'),
(11,5,1,3,'N/A','Faculty of Science'),
(12,5,2,3,'N/A','Faculty of Engineering'),
(13,5,1,3,'Exemption','Faculty of Science'),
(14,5,3,3,'Fulfilled','Faculty of Engineering'),
(15,5,1,3,'Exemption','Faculty of Science'),
(16,5,2,3,'Fulfilled','Faculty of Engineering'),
(17,5,1,3,'Fulfilled','Faculty of Engineering'),
(18,5,2,3,'N/A','Faculty of Computing and Information'),
(19,5,3,3,'N/A','Faculty of Engineering'),
(20,5,2,3,'N/A','Faculty of Science'),
(21,5,2,3,'Exemption','Faculty of Engineering'),
(22,5,1,3,'N/A','Faculty of Engineering'),
(23,5,2,3,'Fulfilled','Faculty of Science'),
(24,5,3,3,'Fulfilled','Faculty of Engineering'),
(25,5,3,3,'N/A','Faculty of Engineering'),
(26,5,2,3,'N/A','Faculty of Computing and Information');





