----------Stored Procedure For add new course in track in specific branch by training manager
-- Call to the Stored Procedure
EXEC AddCourseToTrackInBranch 
    @Course_ID = 7,
    @Course_Name = 'Java',
    @Course_Description = 'NEW Course', 
    @Max_Degree = 100,
    @Min_Degree = 50,
    @Instructor_ID = 3,
    @Track_ID = 2,
    @Branch_ID = 5;


-- Check addition
SELECT * FROM Courses;
SELECT * FROM Courses_In_Track;

-------------------------------------------------------

-- Stored Procedure For Delete course in track by training manager
-- Call to the Stored Procedure
EXEC DeleteCourseFromTrackInBranch
@Course_ID = 1,
@Track_ID = 1;  

---Check Deletion
SELECT * FROM Courses
SELECT * FROM Courses_In_Track

-------------------------------------------------------
-- Stored Procedure For Edit course in track 
-- Call to the Stored Procedure
EXEC EditCourseInTrack
    @Course_ID = 7,  
    @Course_Name = 'JAVASCRIPT',
    @Course_Description = 'Updated TO JAVASCRIPT',
    @Max_Degree = 100,
    @Min_Degree = 60,
    @Instructor_ID = 4,  
    @Track_ID = 1;  

---Check UPDATE
SELECT * FROM Courses
SELECT * FROM Courses_In_Track

-------------------------------------------------------
-- Stored Procedure For Update track 
-- Call to the Stored Procedure
EXEC UpdateTrack
    @Track_ID = 3, 
    @Dept_ID = 2,   
    @Track_Name = 'Software Development';  

---Check UPDATE
SELECT * FROM TRACK

--------------------------------------------------------------------

--- VIEW to ViewAllCourses TO TRAINIG MANAGER
----SELECT 
Select *
from ViewAllCourses

----------------------------------------------------------------
-----CREATE TRIGGER TO PREVENT INSTRUCTOR FROM ADD , UPDATE AND DELETE STUDENT
----Test Insert
INSERT INTO Students (User_ID, Branch_ID, Track_ID, Intake_ID, Militery_Status, Faculty)
VALUES (27, 1, 1, 1, 'N/A', 'Faculty Of Science');

------Test Update
UPDATE Students
SET Branch_ID = 5
WHERE User_ID = 7;

-----Test Delete
DELETE FROM Students
WHERE User_ID = 8;


-----------
SELECT * FROM Students;



