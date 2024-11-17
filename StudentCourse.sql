-- This script creates a small Student Course database

-- Remove old tables, if they already exist.

DROP TABLE IF EXISTS Enrollment, Students, Courses;

-- Create the new tables

CREATE TABLE Students (
          StudentID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
          StudentName varchar(40),
          Birthdate date,
          Status varchar(7) 
             CHECK (Status in ('FR', 'SO', 'JR', 'SR', 'Grad', 'Unclass')),
          HighSchoolGPA real 
             CHECK (HighSchoolGPA>=0 and HighSchoolGPA<=4.0)
) Engine=InnoDB;

CREATE TABLE Courses (
          CourseCode char(7) NOT NULL PRIMARY KEY,
          Title varchar(40),
          credits int 
               CHECK (credits>=1 and credits<=12)
) Engine=InnoDB;

-- Note the use of Foreign key constraints.
-- The InnoDB engine is used for FK support

CREATE TABLE Enrollment (
          StudentID int NOT NULL, 
          CourseCode char(7) NOT NULL,
          Grade char(1)
                CHECK (Grade in ('A', 'B', 'C', 'D', 'F', 'I', ' ')),
          PRIMARY KEY (StudentID, CourseCode),
		  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
		  FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
) Engine=InnoDB;

-- Populate the tables

insert into Courses values ('CSCI111', 'Computer Science I', 3);
insert into Courses values ('CSCI112', 'Computer Science II', 3);
insert into Courses values ('CSCI211', 'Computer Science III', 3);
insert into Courses values ('CSCI223', 'Organization and Architecture', 3);
insert into Courses values ('ENGL101', 'Freshman Composition I', 3);
insert into Courses values ('LIBA102', 'Freshman Seminar', 3);
insert into Courses values ('MATH261', 'Calculus I', 3);
insert into Courses values ('MATH262', 'Calculus II', 3);
insert into Courses values ('MATH263', 'Calculus III', 3);

insert into Students (StudentName, Birthdate, Status, HighSchoolGPA) 
       values ('Hood, Lisa', '1983-03-31', 'JR', 2.86);
SELECT @lastID := LAST_INSERT_ID();
insert into Enrollment values (@lastID, 'MATH261', 'C');
insert into Enrollment values (@lastID, 'CSCI211', 'C');
insert into Enrollment values (@lastID, 'LIBA102', 'A');
insert into Enrollment values (@lastID, 'MATH262', 'B');

insert into Students (StudentName, Birthdate, Status, HighSchoolGPA) 
       values ('Reed, Veronica', '1984-07-16', 'FR', 3.25);
SELECT @lastID := LAST_INSERT_ID();
insert into Enrollment values (@lastID, 'MATH261', ' ');
insert into Enrollment values (@lastID, 'CSCI111', ' ');
insert into Enrollment values (@lastID, 'ENGL101', ' ');

insert into Students (StudentName, Birthdate, Status, HighSchoolGPA) 
       values ('Williams, George', '1980-03-31', 'SR', 3.5);
SELECT @lastID := LAST_INSERT_ID();
insert into Enrollment values (@lastID, 'ENGL101', 'B');
insert into Enrollment values (@lastID, 'LIBA102', 'A');
insert into Enrollment values (@lastID, 'MATH261', 'A');
insert into Enrollment values (@lastID, 'CSCI111', 'A');
insert into Enrollment values (@lastID, 'CSCI112', 'B');
insert into Enrollment values (@lastID, 'MATH262', 'C');
insert into Enrollment values (@lastID, 'CSCI211', 'B');
insert into Enrollment values (@lastID, 'MATH263', ' ');

insert into Students (StudentName, Birthdate, Status, HighSchoolGPA) 
       values ('Kirby, Marvin', '1982-08-12', 'JR', 3.18);
SELECT @lastID := LAST_INSERT_ID();
insert into Enrollment values (@lastID, 'MATH261', 'C');
insert into Enrollment values (@lastID, 'CSCI111', 'C');
insert into Enrollment values (@lastID, 'CSCI112', 'B');
insert into Enrollment values (@lastID, 'LIBA102', 'A');
insert into Enrollment values (@lastID, 'MATH262', 'B');
insert into Enrollment values (@lastID, 'CSCI211', ' ');
insert into Enrollment values (@lastID, 'MATH263', ' ');





