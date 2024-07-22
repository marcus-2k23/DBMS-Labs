-- assignment01.sql
-- Assignment 01 Fall 2023
-- Revision History:
-- , Section 01, 2023.09.30: Created
-- , Section 01, 2023.09.30: Updated


Print 'F23 PROG8080 Section 1';
Print 'Assignment 1';
Print '';
Print '';
Print '';
Print GETDATE();
Print '';

USE SIS;

-- Question 1
Print'***Question 1: list of all data in academicStatus***';
Print'';
select * from AcademicStatus;

-- Question 2
Print'***Question 2: no. and code for all students who discontinued***';
Print'';
select number, academicStatusCode from Student
where academicStatusCode='D'
order by number desc;

-- Question 3
Print'***Question 3: students who have been discontinued or suspended.***';
Print'';
select number, academicStatusCode from Student
where academicStatusCode<>'N';

-- Question 4
Print'***Question 4:  province code once from person order by desc***';
Print'';
select distinct provinceCode from Person
order by provinceCode desc;

-- Question 5
Print'***Question 5***';
Print'';
select distinct provinceCode from Person
where provinceCode is not NULL;

-- Question 6
Print'***Question 6***';
Print'';
select number, lastName, firstName, city, countryCode from Person
where provinceCode is NULL;

-- Question 7
Print'***Question 7***';
Print'';
select number, lastName, firstName, city, countryCode from Person
where firstName like 'AND_';

-- Question 8
Print'***Question 8***';
Print'';
select * from Program
where name like 'Computer%';

-- Question 9
Print'***Question 9***';
Print'';
select code, acronym, name
from Program
where name like '%Coop%';

-- Question 10
Print'***Question 10***';
Print'';
select * from CourseStudent
where finalMark<55 AND finalMark <> 0;

-- Question 11
Print'***Question 11***';
Print'';
select number,capacity,memory from Room
where capacity>=40 AND isLab='true' AND memory = '4GB' AND campusCode='D';

-- Question 12
Print'***Question 12***';
Print'';
select * from Employee
where schoolCode='TAP' AND campusCode IN ('D','G','W');

-- Question 13
Print'***Question 13***';
Print'';
select lastName, Lower(SUBSTRING( firstName,1,1)) + LOWER(Left(lastName,7)) as "User ID" 
from Person
where lastName like 'J%'
order by "User ID" desc;

-- Question 14
Print'***Question 14***';
Print'';
select * from (select number, 
Format(birthdate,'MMMM dd, yyyy') as dob, 
(DATEDIFF(YEAR,birthdate,GETDATE())) as age 
from person) as seniorCitizen
where age>60;

-- Question 15
Print'***Question 15***';
Print'';
select number as 'Course Code', name as 'Course Name' from Course
where CHARINDEX('Game',name)>0;

-- Question 16
Print'***Question 16***';
Print'';
select * from (select item as 'Incidental Fee', 
amountPerSemester as 'Current Fee',
Convert(varchar(10),cast(0.1*amountPerSemester as money)) as 'Increased Fee'
from IncidentalFee) as incidentalFeeAlt
order by 'Current Fee';
