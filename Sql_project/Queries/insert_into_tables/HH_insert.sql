
insert into Question.Questions( Question_Text ,Question_Type ,degree ,course_id )
-- INSERT ARTICLE QUESTIONS
values ('What is a namespace in C#?', 'ART', 1, 2),
 ('What is the difference between value types and reference types in C#?', 'ART', 1, 2),
 ('What is the purpose of using the "using" statement in C#?', 'ART', 1, 2),
 ('What is the difference between "string" and "StringBuilder" in C#?', 'ART', 1, 2),
 ('What are delegates in C#?', 'ART', 1, 2),
 ('What is the purpose of the "finally" block in a try-catch-finally statement?', 'ART', 1, 2),
 ('What is the difference between "IEnumerable" and "IQueryable" in C#?', 'ART', 1, 2),
 ('What is the purpose of the "var" keyword in C#?', 'ART', 1, 2),
 ('Explain the concept of boxing and unboxing in C#.', 'ART', 1, 2),
 ('What is the difference between "readonly" and "const" in C#?', 'ART', 1, 2),

-- INSERT TF QUESTIONS
 ('C# is a case-sensitive programming language.', 'TF', 1, 2),
 ('In C#, a struct can inherit from another struct.', 'TF', 1, 2),
 ('The "++" operator in C# increments a variable by 2.', 'TF', 1, 2),
 ('The "sealed" keyword in C# is used to prevent a class from being inherited.', 'TF', 1, 2),
 ('C# supports multiple inheritance.', 'TF', 1, 2),
 ('The "catch" block in C# is optional when using a try-catch-finally statement.', 'TF', 1, 2),
 ('The "this" keyword in C# refers to the current instance of a class or struct.', 'TF', 1, 2),
 ('C# does not support operator overloading.', 'TF', 1, 2),
 ('A derived class can access private members of its base class.', 'TF', 1, 2),
 ('In C#, a variable declared as "const" can be modified.', 'TF', 1, 2),

-- INSERT MCQ QUESTIONS
 ('Which keyword is used to define a class in C#?', 'MCQ', 1, 2),
 ('Which of the following is an example of a value type in C#?', 'MCQ', 1, 2),
 ('In C#, which access modifier allows a member to be accessed from anywhere within the same assembly?', 'MCQ', 1, 2),
 ('What is the default access modifier for members of a class in C#?', 'MCQ', 1, 2),
 ('Which keyword is used to create an instance of a class in C#?', 'MCQ', 1, 2),
 ('What is the correct way to declare a variable of type int in C#?', 'MCQ', 1, 2),
 ('Which of the following access modifiers allows a member to be accessed only within its own class?', 'MCQ', 1, 2),
 ('What is the purpose of the using statement in C#?', 'MCQ', 1, 2),
 ('How do you define a method that does not return any value in C#?', 'MCQ', 1, 2),
 ('What is the default value of an int variable in C# if it is not explicitly initialized?', 'MCQ', 1, 2)
 
insert into Question.Article_Question(Art_Question_ID ,best_correct_answer)
values (66, 'A namespace in C# is a way to organize and group related classes and types. It provides a hierarchical naming structure to prevent naming conflicts and improve code organization.'),
 (67, 'Value types store their actual value directly, whereas reference types store a reference to the location of the value. Value types are stored on the stack, while reference types are stored on the managed heap.'),
 (68, 'The "using" statement in C# is used for automatic disposal of resources. It ensures that IDisposable objects are properly disposed of when they are no longer needed, improving memory management and preventing resource leaks.'),
 (69, 'The "string" type in C# is immutable, meaning its value cannot be changed once it is created. "StringBuilder" is mutable and provides better performance when manipulating large strings frequently.'),
 (70, 'Delegates in C# are type-safe function pointers that allow methods to be passed as parameters or stored in variables. They enable event handling, callbacks, and asynchronous programming.'),
 (71, 'The "finally" block in a try-catch-finally statement is used to specify code that should be executed regardless of whether an exception is thrown or not. It ensures cleanup tasks or resource releases are performed.'),
 (72, '"IEnumerable" is used for querying in-memory collections, while "IQueryable" is used for querying external data sources such as databases. "IQueryable" provides deferred execution and supports complex query operations.'),
 (73, 'The "var" keyword in C# allows the compiler to infer the type of a variable based on its initialization value. It provides syntactic sugar to reduce code verbosity when the type is evident.'),
 (74, 'Boxing is the process of converting a value type to the corresponding reference type (boxing it into an object). Unboxing is the reverse process of extracting the value type from the boxed object.'),
 (75, '"readonly" variables can be assigned a value either at the time of declaration or within the constructor, and their value cannot be changed afterward. "const" variables are compile-time constants with a fixed value that cannot be modified.')


insert into Question.True_Or_False_Question (TF_Question_ID , correct_answer)
values (76, 1),
 (77, 0),
 (78, 0),
 (79, 1),
 (80, 0),
 (81, 0),
 (82, 1),
 (83, 0),
 (84, 0),
 (85, 0)

insert into Question.Multichoice_Question (MC_Question_ID, Choice1, Choice2, Choice3, Choice4, correct_answer)
values (86, 'class', 'struct', 'interface', 'abstract', 'class'),
 (87, 'string', 'int[]', 'List&lt;int&gt;', 'DateTime', 'int[]'),
 (88, 'private', 'protected', 'internal', 'public', 'internal'),
 (89, 'private', 'protected', 'internal', 'public', 'private'),
 (90, 'new', 'create', 'instance', 'make', 'new'),
 (91, 'variable int', 'int variable', 'int = variable', 'var = int', 'int variable'),
 (92, 'public', 'private', 'protected', 'internal ', 'private'),
 (93, 'To declare a new variable', 'To define a new class', 'To import namespaces', 'To create a loop', 'To import namespaces'),
 (94, 'void', 'int', 'string', 'double', 'void'),
 (95, '0', '1', 'null', 'It depends on the context', '0')



