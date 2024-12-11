insert into dbo.Courses
values
(1, 1, 'SQL', 'Structured Query Language is a proprietary relational database management system', 100, 50, null),
(2, 1, 'C#', 'Versatile, modern programming language.', 100, 50, null),
(3, 1, 'OOP', 'Object-Oriented Programming', 100, 50, null)



-- Inserting True/False Questions
insert into Question.Questions(Question_Text, Question_Type, degree, course_id)
values
('SQL Server supports both Windows and SQL Server authentication.', 'TF', 1, 1),
('A primary key in SQL Server can contain NULL values.', 'TF', 1, 1),
('SQL Server uses the Transact-SQL (T-SQL) language.', 'TF', 1, 1),
('SQL Server Agent is used to schedule and execute jobs.', 'TF', 1, 1),
('A clustered index is an index where the logical order of the rows matches the physical order of rows.', 'TF', 1, 1),
('SQL Server Management Studio (SSMS) is a separate product from SQL Server.', 'TF', 1, 1),
('SQL Server does not support foreign key constraints.', 'TF', 1, 1),
('A single SQL Server instance can host multiple databases.', 'TF', 1, 1),
('SQL Server Integration Services (SSIS) is a platform for data integration.', 'TF', 1, 1),
('SQL Server does not support the execution of stored procedures.', 'TF', 1, 1);

-- Inserting Multiple Choice Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('What is the default port number for SQL Server?', 'MCQ', 1, 1),
('Which tool is used to create and manage SQL Server databases?', 'MCQ', 1, 1),
('What is a clustered index?', 'MCQ', 1, 1),
('What is the maximum size of a row in SQL Server?', 'MCQ', 1, 1),
('Which feature allows for the execution of tasks at scheduled times in SQL Server?', 'MCQ', 1, 1),
('What type of join returns all rows from the left table and the matched rows from the right table?', 'MCQ', 1, 1),
('Which data type is used to store variable-length character strings in SQL Server?', 'MCQ', 1, 1),
('What does the acronym T-SQL stand for?', 'MCQ', 1, 1),
('What is a foreign key?', 'MCQ', 1, 1),
('What is SQL Server Reporting Services (SSRS) used for?', 'MCQ', 1, 1);

-- Inserting Article Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('Describe the differences between clustered and non-clustered indexes in SQL Server.', 'ART', 1, 1),
('Explain the role and importance of SQL Server Agent in database management.', 'ART', 1, 1),
('Discuss the advantages and disadvantages of using SQL Server Integration Services (SSIS).', 'ART', 1, 1),
('What are the benefits of using SQL Server Management Studio (SSMS) for database administration?', 'ART', 1, 1),
('Explain how foreign key constraints help maintain data integrity in SQL Server.', 'ART', 1, 1),
('Describe the process of creating and using stored procedures in SQL Server.', 'ART', 1, 1),
('What are the key features of SQL Server Reporting Services (SSRS) and how do they support business intelligence?', 'ART', 1, 1),
('Discuss the impact of indexing on query performance in SQL Server.', 'ART', 1, 1),
('Explain the concept of transactions in SQL Server and how they ensure data consistency.', 'ART', 1, 1),
('Describe the steps involved in setting up a backup and restore strategy in SQL Server.', 'ART', 1, 1);


insert into Question.True_Or_False_Question(TF_Question_ID, correct_answer)
values
(1, 1),
(2, 0),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 0),
(8, 1),
(9, 1),
(10, 0);


insert into Question.Multichoice_Question (MC_Question_ID, Choice1, Choice2, Choice3, Choice4, correct_answer)
values
(11, '3306', '5432', '1433', '1521', '1433'),
(12, 'SQL Developer', 'MySQL Workbench', 'SQL Server Management Studio (SSMS)', 'pgAdmin', 'SQL Server Management Studio (SSMS)'),
(13, 'An index where the logical order of the rows matches the physical order of rows.', 'An index used only for text columns.', 'An index that does not affect the physical order of rows.', 'An index that can only be created on primary keys.', 'An index where the logical order of the rows matches the physical order of rows.'),
(14, '4 KB', '8 KB', '16 KB', '64 KB', '8 KB'),
(15, 'SQL Profiler', 'SQL Server Agent', 'Database Engine Tuning Advisor', 'Integration Services', 'SQL Server Agent'),
(16, 'Inner join', 'Right join', 'Full join', 'Left join', 'Left join'),
(17, 'CHAR', 'VARCHAR', 'TEXT', 'NVARCHAR', 'VARCHAR'),
(18, 'Technical SQL', 'Text SQL', 'Transact-SQL', 'Transactional SQL', 'Transact-SQL'),
(19, 'A unique identifier for a row.', 'A key used to enforce a link between two tables.', 'A column that cannot have duplicate values.', 'A key used to encrypt the database.', 'A key used to enforce a link between two tables.'),
(20, 'Data integration', 'Data analysis', 'Data reporting', 'Data transformation', 'Data reporting');


insert into Question.Article_Question (Art_Question_ID, best_correct_answer)
values
(21, 'Clustered indexes sort and store the data rows in the table based on their key values, whereas non-clustered indexes store a pointer to the data rows.'),
(22, 'SQL Server Agent automates and schedules tasks, making database management more efficient.'),
(23, 'SSIS offers powerful data integration capabilities but can be complex and resource-intensive.'),
(24, 'SSMS provides a user-friendly interface for managing databases, running queries, and configuring settings.'),
(25, 'Foreign key constraints ensure that the data between related tables remains consistent.'),
(26, 'Stored procedures encapsulate T-SQL code, providing reusability, security, and performance benefits.'),
(27, 'SSRS supports comprehensive reporting capabilities, enhancing decision-making processes.'),
(28, 'Indexes improve query performance by allowing faster data retrieval but can slow down data modification operations.'),
(29, 'Transactions ensure data consistency by treating a sequence of operations as a single unit of work.'),
(30, 'A well-defined backup and restore strategy protects data from loss and ensures business continuity.');


--------------------------------------------------------------------------------------------------
-- insert questions of oop course 
insert into Question.Questions 
values ('Explain the four fundamental principles of Object-Oriented Programming (OOP) in C#. Provide examples to illustrate each principle.','ART',1,3),
('Differences between interfaces and abstract classes','ART',1,3),
('Explain the concept of exception handling in C#. How does exception handling contribute to robust software development? Provide an example to illustrate your explanation.','ART',1,3),
('Discuss the concept of delegates and events in C#. How do they enable decoupled and flexible code design? Provide an example demonstrating their usage.','ART',1,3),
('Describe the concept of classes and objects in C#. How do they form the foundation of Object-Oriented Programming? Provide an example.','ART',1,3),
('Explain the difference between method overloading and method overriding in C#. Provide examples to illustrate each concept.','ART',1,3),
('What are constructors in C#, and how do they differ from methods? Explain the different types of constructors with examples.','ART',1,3),
('What are properties in C#, and how do they differ from fields? Provide examples to demonstrate the usage of properties.','ART',1,3),
('What is the difference between value types and reference types in C#? Provide examples and explain how they are stored in memory.','ART',1,3),
('Explain the concept of inheritance in C#. How does it promote code reusability? Provide an example to illustrate your explanation.','ART',1,3)
go
insert into Question.Questions 
values (' Which is not a feature of OOP in general definitions?','MCQ',1,3),
('Which was the first purely object oriented programming language developed?','MCQ',1,3),
(' Which feature of OOP indicates code reusability?','MCQ',1,3),
(' Which header file is required in C++ to use OOP?','MCQ',1,3),
(' Why Java is Partially OOP language?','MCQ',1,3),
(' Which among the following doesn’t come under OOP concept?','MCQ',1,3),
('Which is the correct syntax of inheritance?','MCQ',1,3),
(' The feature by which one object can interact with another object is','MCQ',1,3),
(' Which among the following, for a pure OOP language, is true?','MCQ',1,3),
('  In multilevel inheritance, which is the most significant feature of OOP used?','MCQ',1,3)
go
insert into Question.Questions 
values (' OOP stands for Object-Oriented Programming.','TF',1,3),
('In OOP, a class is an instance of an object.','TF',1,3),
('Encapsulation is the concept of wrapping data and methods into a single unit.','TF',1,3),
('Polymorphism allows methods to have the same name but behave differently.','TF',1,3),
('Inheritance is the ability of a class to derive properties and behaviors from another class.','TF',1,3),
('Abstraction means hiding the implementation details and showing only the functionality.','TF',1,3),
('A constructor is a special method that is called when an object is created.','TF',1,3),
('In C# public is an access modifier that makes members accessible from outside the class.','TF',1,3),
('Static methods can be called on an instance of the class.','TF',1,3),
('In C#, the =>this keyword refers to the current instance of the class.','TF',1,3)


select *from Question.Questions
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
insert into question.Article_Question
values (36,'Encapsulation,Inheritance,Polymorphism,Absraction'),
(37,'Interfaces define method signatures without any implementation, allowing multiple inheritance and facilitating loose coupling. Abstract classes can contain method implementations, fields, and constructors, supporting single inheritance and providing a base for subclasses to extend and specialize functionality.'),
(38,'Interfaces in C# define only method signatures that classes must implement, promoting loose coupling and multiple interface inheritance. Abstract classes can include method implementations and fields, supporting single class inheritance and providing a base for subclasses to extend and specialize functionality.'),
(39,'Exception handling in C# allows developers to manage and respond to runtime errors gracefully, contributing to robust software by preventing crashes and maintaining application stability'),
(40,'Classes in C# define the blueprint or template for objects, while objects are instances of classes that encapsulate data and behavior, forming the foundation of Object-Oriented Programming by promoting code reuse and modularity.'),
(41,'Method overloading in C# involves defining multiple methods with the same name but different parameters within the same class, while method overriding occurs when a derived class provides a specific implementation of a method already defined in its base class.'),
(42,'Constructors in C# are special methods used to initialize objects when they are created, differing from regular methods by having the same name as the class and no return type; types include default constructors, parameterized constructors, and static constructors.'),
(43,'Properties in C# provide controlled access to fields by encapsulating them with getters and setters, while fields are variables that directly store data in a class or struct.'),
(44,'Value types in C# store data directly, whereas reference types store references to the location of the data in memory.'),
(45,'Inheritance in C# allows a class to inherit properties and methods from another class, promoting code reusability by enabling the reuse of existing code and extending functionality as needed.')

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
insert into Question.True_Or_False_Question 
values 
(56,1),
(57,0),
(58,1),
(59,1),
(60,1),
(61,1),
(62,1),
(63,1),
(64,0),
(65,1)
select *from Question.Questions
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
insert into [Question].[Multichoice_Question]
values (46,'a)Efficient Code','b) Code reusability','c) Modularity','d) Duplicate/Redundant data','d) Duplicate/Redundant data'),
(47,'a) Kotlin','b) SmallTalk','c) Java','d) C++','b) SmallTalk'),
(48,'a) Abstraction','b) Polymorphism','c) Encapsulation','d) Inheritance','d) Inheritance'),
(49,'a) OOP can be used without using any header file','b) stdlib.h','c) iostream.h','d) stdio.h','a) OOP can be used without using any header file'),
(50,'a) It allows code to be written outside classes','b) It supports usual declaration of primitive data types','c) It does not support pointers','d) It doesn’t support all types of inheritance','b) It supports usual declaration of primitive data types'),
(51,'a) Data hiding','b) Message passing','c) Platform independent','d) Data binding','c) Platform independent'),
(52,'a) class base_classname :access derived_classname{ /*define class body*/ };','b) class derived_classname : access base_classname{ /*define class body*/ };','c) class derived_classname : base_classname{ /*define class body*/ };','d) class base_classname : derived_classname{ /*define class body*/ };','b) class derived_classname : access base_classname{ /*define class body*/ };'),
(53,'a) Message reading','b) Message Passing','c) Data transfer','d) Data Binding','b) Message Passing'),
(54,'a) The language should follow at least 1 feature of OOP','b) The language must follow only 3 features of OOP','c) The language must follow all the rules of OOP','d) The language should follow 3 or more features of OOP','c) The language must follow all the rules of OOP'),
(55,'a) Code efficiency','b) Code readability','c) Flexibility','d) Code reusability','d) Code reusability')




----Insert QUESTION FOR PYTHON
---- Inserting True/False Questions

insert into Question.Questions(Question_Text, Question_Type, degree, course_id)
values
('Python supports both procedural and object-oriented programming paradigms.','TF',1,4),
('In Python, lists are immutable.','TF',1,4),
('The "pass" statement in Python is used to create a placeholder for future code.','TF',1,4),
('The "lambda" keyword in Python is used to define anonymous functions.','TF',1,4),
('Python"s "range()" function generates a list.','TF',1,4),
('In Python, indentation is optional.','TF',1,4),
('Python is "try"statement must always be followed by an "except" statement.','TF',1,4),
('The "len()" function in Python can be used to determine the length of any iterable.','TF',1,4),
('Tuples in Python can contain elements of different data types.','TF',1,4),
('In Python, the "==" operator checks for object identity.','TF',1,4);

----- Inserting Multiple Choice Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('What is the correct file extension for Python files?','MCQ',1,4),
('Which of the following is used to define a block of code in Python?','MCQ',1,4),
('What is the output of the following code? print(type([]))','MCQ',1,4),
('Which of the following functions can be used to find the length of a string in Python?','MCQ',1,4),
('What is the output of the following code?','MCQ',1,4),
('Which of the following is not a core data type in Python?','MCQ',1,4),
('What is the output of the following code?  x = ["a", "b", "c"]  print(x[1])','MCQ',1,4),
('How do you insert comments in Python code?','MCQ',1,4),
('Which of the following statements is used to create a function in Python?','MCQ',1,4),
('What is the output of the following code? print(2 ** 3)','MCQ',1,4);

-- Inserting Article Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('What is the primary use of the self keyword in Python?','ART',1,4),
('Which Python data type is an ordered collection of items that can be changed?','ART',1,4),
('What is the result of the expression "Python"[::-1]?','ART',1,4),
('What will the following code output: print(bool(0), bool(3.14))?','ART',1,4),
('What is the purpose of the _init_ method in Python classes?','ART',1,4),
('What does the pass statement do in Python?','ART',1,4),
(' Which of the following will raise a SyntaxError: x = 10, 
print("Hello, World!"), for i in range(5), or def func():?','ART',1,4),
(' What will be the output of the following code:x = [1, 2, 3, 4]
y = x
y.append(5)
print(x)','ART',1,4),
('Which function is used to convert an object to a string in Python?','ART',1,4),
('What will be the output of the following code:
def add(a, b=2):
    return a + b
print(add(3))','ART',1,4);


------ANSWERS ------------
insert into Question.True_Or_False_Question(TF_Question_ID, correct_answer)
values
(96,1),
(97,0),
(98,1),
(99,1),
(100,0),
(101,0),
(102,0),
(103,1),
(104,1),
(105,0);

insert into [Question].[Multichoice_Question]
VALUES
(106,'A) .pyth','B) .pt','C) .py','D) .python','C) .py'),
(107,'A) Curly braces {}','B) Parentheses ()','C) Indentation','D) Square brackets []','C) Indentation'),
(108,'A) <class "list">','B) <class "dict">','C) <class "set">','D) <class "tuple">','A) <class "list">'),
(109,'A) size()','B) length()','C) len()','D) count()','C) len()'),
(110,'A) hello hello hello','B) hellohellohello','C) Error','D) hello 3 times','A) hello hello hello'),
(111,'A) List','B) Dictionary','C) Tuples','D) Class','D) Class'),
(112,'A) a','B) b','C) c','D) Error','B) b'),
(113,'A) //','B) <!-- -->','C) #','D) /* */','C) #'),
(114,'A) function myFunction():','B) create myFunction():','C) def myFunction():','D) define myFunction():','C) def myFunction():'),
(115,'A) 6','B) 8','C) 9','D) 11','Answer: B) 8');

----------------------------------------------
insert into question.Article_Question
VALUES
(116,' The self keyword is used in instance methods to refer to the instance of the class that is being operated on. 
It allows access to the attributes and methods of the class in object-oriented programming.'),
(117,'The list data type is an ordered collection of items that can be changed (mutable). 
Lists are defined using square brackets, e.g., my_list = [1, 2, 3].'),
(118,'The result is "nohtyP". The slice notation [::-1] reverses the string.'),
(119,' The output will be False True. In Python, the integer 0 converts to False, and any non-zero number (like 3.14) converts to True.'),
(120,'The _init_ method is the constructor method in Python. 
It is automatically called when an instance of the class is created and is used to initialize the instance variables'),
(121,'The pass statement is a null operation; it is used as a placeholder in loops, functions, classes, or conditionals where code will be added later.'),
(122,' for i in range(5) will raise a SyntaxError because it lacks a colon (:) at the end, which is required to indicate the start of the for-loop block.'),
(123,'The output will be [1, 2, 3, 4, 5]. Lists are mutable and are passed by reference. The variable y references the same list as x. Therefore, appending to y also changes x.'),
(124,'The str() function is used to convert an object to its string representation'),
(125,'The output will be 5. The function add has a default argument b set to 2. Calling add(3) passes 3 as a, and b remains the default value 2. Therefore, the function returns 3 + 2 = 5.');



---------HTMLquestions 

insert into Question.Questions(Question_Text, Question_Type, degree, course_id)
values
('HTML stands for HyperText Markup Language.','TF',1,5),
('The <div> element is used to create hyperlinks in an HTML document.','TF',1,5),
('The <head> element contains metadata about the HTML document, such as the title and links to stylesheets.','TF',1,5),
('You can use HTML to create dynamic content without any additional scripting languages.','TF',1,5),
('The <img> element is used to embed images in an HTML document.','TF',1,5),
('The <title> element must be placed inside the <body> element.','TF',1,5),
('HTML comments are written using <!-- and -->.','TF',1,5),
('The <br> element is used to create a horizontal line in an HTML document.','TF',1,5),
('The <table> element is used to define a table in HTML.','TF',1,5),
('The <p> element is used to define paragraphs in an HTML document.','TF',1,5);
insert into Question.True_Or_False_Question(TF_Question_ID, correct_answer)
values
(126,1),
(127,0),
(128,1),
(129,0),
(130,1),
(131,0),
(132,1),
(133,0),
(134,1),
(135,1);
-----

--HTML--- Inserting Multiple Choice Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('What does HTML stand for?','MCQ',1,4),
('Which HTML element is used to create a hyperlink?','MCQ',1,4),
('Where in an HTML document is the correct place to refer to an external stylesheet?','MCQ',1,4),
('Which HTML element is used to define important text?','MCQ',1,4),
('Which HTML element is used to define important text?','MCQ',1,4),
('What is the correct HTML element for inserting a line break?','MCQ',1,4),
('Which HTML element is used to specify a footer for a document or section?','MCQ',1,4),
('What is the purpose of the <alt> attribute in the <img> tag?','MCQ',1,4),
('Which attribute is used to provide a unique identifier for an HTML element?','MCQ',1,4),
('Which HTML element is used to define a section of navigation links?','MCQ',1,4);

insert into [Question].[Multichoice_Question]
values (136,'a) HyperText Markup Language','b) Hyperlinks and Text Markup Language','c) Home Tool Markup Language','d) Hyperlinking Text Marking Language','a) HyperText Markup Language'),
(137,'a) <a>','b) <link>','c) <href>','d) <nav>','a) <a>'),
(138,'a) In the <body> section','b) At the end of the document','c) In the <head> section','d) In the <title> section','c) In the <head> section'),
(139,'a) <strong>','b) <em>','c) <b>','d) <i>','a) <strong>'),
(140,'a) <ul>','b) <ol>','c) <list>','d) <dl>','<ol>'),
(141,'a) <break>','b) <br>','c) <lb>','d) <line>','<br>'),
(142,'a) <bottom>','b) <footer>','c) <section>','d) <end>','<footer>'),
(143,'a) To specify the URL of the image','b) To specify alternative text for the image','c) To specify the size of the image','d) To specify the alignment of the image','b) To specify alternative text for the image'),
(144,'a) class','b) id','c) name','d) key','b) id'),
(145,'a) <nav>','b) <section>','c) <header>','d) <footer>','a) <nav>')


insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
(' What is the purpose of the <meta> tag in an HTML document?', 'ART', 1, 5),
('Explain the significance of the DOCTYPE declaration in an HTML document.', 'ART', 1, 5),
('How does the <form> element facilitate user input in an HTML document?', 'ART', 1, 5),
('Describe the role of the <head> element in an HTML document.', 'ART', 1, 5),
('What is the function of the <script> tag in HTML?', 'ART', 1, 5),
('How does the <table> element structure data in an HTML document?', 'ART', 1, 5),
('Explain the use of the href attribute in the <a> tag.', 'ART', 1, 5),
('What is the purpose of the class attribute in HTML?', 'ART', 1, 5),
('How does the <section> element help in structuring an HTML document?', 'ART', 1, 5),
('Describe the importance of the <title> tag in an HTML document.', 'ART', 1, 5);

insert into Question.Article_Question (Art_Question_ID, best_correct_answer)
values
(146, 'The <meta> tag is used to provide metadata about the HTML document, such as character set, page description, and keywords.'),
(147, ' The DOCTYPE declaration defines the document type and version of HTML being used, which helps browsers to render the page correctly.'),
(148, 'The <form> element creates an interactive form for user input, containing various input elements like text fields, checkboxes, and submit buttons.'),
(149, ' The <head> element contains metadata, links to stylesheets, scripts, and other resources essential for the document is head section.'),
(150, 'The <script> tag is used to embed or reference JavaScript code within an HTML document, enabling dynamic content and interactive features.'),
(151, 'The <table> element structures data in a grid format using rows (<tr>) and cells (<td>), allowing for organized presentation of tabular data.'),
(152, 'The href attribute specifies the URL of the page or resource that the hyperlink (<a> tag) points to.'),
(153, 'The class attribute assigns a CSS class to an HTML element, enabling the application of specific styles or behaviors to elements with the same class.'),
(154, 'The <section> element defines a thematic grouping of content, helping to organize the document into distinct, meaningful sections.'),
(155, 'The <title> tag sets the title of the HTML document, which appears in the browser s title bar or tab, providing a brief description of the page content.');



---CSS3 

insert into Question.Questions(Question_Text, Question_Type, degree, course_id)
values
('CSS3 stands for Cascading Style Sheets Level 3.','TF',1,6),
('CSS3 allows the use of multiple background images on an element.','TF',1,6),
('The border-radius property in CSS3 is used to create rounded corners on elements.','TF',1,6),
('CSS3 does not support animations or transitions.','TF',1,6),
('The @font-face rule in CSS3 allows custom fonts to be loaded on a webpage.','TF',1,6),
('The flexbox layout module in CSS3 is used for creating grid-based layouts.','TF',1,6),
('The rgba color model in CSS3 includes an alpha channel for opacity.','TF',1,6),
('CSS3 does not support media queries for responsive design.','TF',1,6),
('The box-shadow property in CSS3 is used to add shadow effects to elements.','TF',1,6),
('CSS3 allows for the creation of gradients without the use of images.','TF',1,6);

insert into Question.True_Or_False_Question(TF_Question_ID, correct_answer)
values
(156,1),
(157,1),
(158,1),
(159,0),
(160,1),
(161,0),
(162,1),
(163,0),
(164,1),
(165,1);
-----

--HTML--- Inserting Multiple Choice Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('Which CSS3 property is used to change the background color of an element?','MCQ',1,6),
('How do you add a shadow to a text in CSS3?','MCQ',1,6),
('Which CSS3 property is used to change the font of an element?','MCQ',1,6),
('Which CSS3 module is used for creating flexible layouts?','MCQ',1,6),
('Which CSS3 property allows you to create rounded corners?','MCQ',1,6),
('How do you make an element semi-transparent in CSS3?','MCQ',1,6),
('Which CSS3 property is used to apply a shadow to an elements box?','MCQ',1,6),
('What is the CSS3 property for setting the spacing between lines of text?','MCQ',1,6),
('Which CSS3 property is used to control the layout of multiple columns?','MCQ',1,6),
('How do you specify that an element should be hidden in CSS3?','MCQ',1,6);

insert into [Question].[Multichoice_Question]
values (166,'a) background-color','b) color','c) bg-color','d) background','a) background-color'),
(167,'a) text-shadow','b) text-outline','c) font-shadow','d) text-glow','a) text-shadow'),
(168,'a) font-style','b) font-family','c) font-weight','d) font-variant','b) font-family'),
(169,'a) grid','b) flexbox','c) float','d) position','b) flexbox'),
(170,'a) corner-radius','b) border-radius','c) border-round','d) radius','b) border-radius'),
(171,'a) opacity','b) transparency','c) visibility','d) filter','a) opacity'),
(172,'a) box-shadow','b) element-shadow','c) box-outline','d) shadow','a) box-shadow'),
(173,'a) line-spacing','b) text-spacing','c) line-height','d) text-height','c) line-height'),
(174,') multi-column','b) column-count','c) column-width','d) columns','b) column-count'),
(175,'a) display: none','b) visibility: hidden','c) hidden: true','d) a and b','d) a and b')


insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('What is the purpose of the flexbox layout in CSS3?', 'ART', 1, 6),
('Question: How does the grid layout differ from the flexbox layout in CSS3?', 'ART', 1, 6),
('What are media queries and how are they used in CSS3?', 'ART', 1, 6),
('Explain the purpose of the box-shadow property in CSS3.', 'ART', 1, 6),
('What is the @keyframes rule in CSS3 and how is it used?', 'ART', 1, 6),
('How does the transition property enhance user experience in CSS3?', 'ART', 1, 6),
('What role does the border-radius property play in modern web design?', 'ART', 1, 6),
('Describe the use of the rgba color model in CSS3.', 'ART', 1, 6),
('What is the purpose of the flex property in CSS3 flexbox layout?', 'ART', 1, 6),
('Explain how the calc() function is utilized in CSS3.', 'ART', 1, 6);

insert into Question.Article_Question (Art_Question_ID, best_correct_answer)
values
(176, 'The flexbox layout in CSS3 is used to design a flexible and efficient layout structure for distributing space among items in a container.'),
(177, ' The grid layout in CSS3 allows for two-dimensional layout control with rows and columns, whereas the flexbox layout is primarily one-dimensional.'),
(178, 'Media queries in CSS3 are used to apply different styles based on the characteristics of the device, such as screen size and resolution.'),
(179, 'The box-shadow property in CSS3 is used to add shadow effects to an element"s frame, enhancing its visual appearance.'),
(180, 'The @keyframes rule in CSS3 defines the intermediate steps of a CSS animation, specifying how the animation progresses at various stages.'),
(181, 'The transition property in CSS3 allows for smooth changes between property values, creating a more interactive and visually appealing user experience.'),
(182, 'The border-radius property in CSS3 is used to create rounded corners on elements, contributing to a modern and softer design aesthetic.'),
(183, 'The rgba color model in CSS3 specifies colors using red, green, blue, and alpha (opacity) values, allowing for semi-transparent elements.'),
(184, 'The flex property in CSS3 flexbox layout specifies how a flex item will grow or shrink relative to the other items in the container.'),
(185, 'The calc() function in CSS3 is used to perform calculations to determine CSS property values, allowing for more dynamic and responsive design adjustments.');


select * from Question.Article_Question


delete from Question.Article_Question where Art_Question_ID between 171 and 180