-- assignment02.sql
-- Activity 01 Fall 2023
-- Revision History:
-- , Section 01, 14-10-2023


Print 'F23 PROG8080 Section 1';
Print 'Activity 2';
Print '';
Print '';
Print '';
Print GETDATE();
Print '';

USE SIS;

--1
Print'***Question 1***';
WITH ProgramCourses AS (
    SELECT PC.programCode, PC.courseNumber, PC.semester, P.schoolCode
    FROM ProgramCourse PC
    INNER JOIN Program P ON PC.programCode = P.code
    WHERE P.code = '0066C'
)
SELECT PC.schoolCode, PC.programCode, PC.courseNumber, PC.semester
FROM ProgramCourses PC
ORDER BY PC.semester, PC.courseNumber;

--2
Print'***Question 2***';
SELECT CP.courseNumber AS 'Course Code', CP.prerequisiteNumber,
C.name AS 'Prereq Course Name'
FROM CoursePrerequisiteAnd CP
JOIN Course C ON CP.prerequisiteNumber = C.number
WHERE CP.courseNumber = 'COMP2280'
ORDER BY CP.prerequisiteNumber DESC;

--3
Print'***Question 3***';
SELECT P.number, P.firstName, P.lastName, P.city
FROM Person P
LEFT OUTER JOIN Student S ON P.number = S.number
WHERE S.number IS NULL
ORDER BY P.lastName;

--4
Print'***Question 4***';
select s.uniqueId, s.product
from Software s 
INNER JOIN LabSoftware ls
ON s.uniqueId = ls.softwareUniqueId INNER JOIN Room r
ON ls.roomId = r.id where r.number='2A205'
order by s.product;

--5
Print'***Question 5***';
SELECT E1.number AS 'Employee', E1.reportsTo AS 'Supervisor', E2.reportsTo 
AS 'Supervisor Reports To'
FROM Employee E1
LEFT JOIN Employee E2 ON E1.reportsTo = E2.number
ORDER BY E1.reportsTo;

--6
Print'***Question 6***';
select co.courseNumber Course, 
	MIN(cs.finalMark) [Lowest Mark], 
	ROUND(AVG(cs.finalMark),0) [Average Mark], 
	MAX(cs.finalMark) [Highest Mark]
from CourseOffering co 
INNER JOIN CourseStudent cs
on co.id = cs.CourseOfferingId where co.sessionCode='W10'
group by co.courseNumber;

--7
Print'***Question 7***';
select e.number as Employee,
UPPER(SUBSTRING(p.lastName,1,3))
+SUBSTRING(e.number,LEN(e.number)-2,3) [User ID],
COUNT(co.courseNumber) [# Courses Taught]
from Person p INNER JOIN Employee e ON p.number= e.number
INNER JOIN CourseOffering co
ON e.number=co.employeeNumber
where e.schoolCode='EIT' AND co.sessionCode IN ('F08','W08','F09','W09')
Group by e.number,p.lastName
order by [User ID];

--8
Print'***Question 8***';
SELECT P.acronym AS 'Program', P.name AS 'Program Name',
 FORMAT(SUM(PF.tuition * PF.coopFeeMultiplier), 'C', 'en-US') AS "Total Fees"
FROM Program P
JOIN ProgramFee PF ON P.code = PF.code
WHERE P.name LIKE '%Coop%'
GROUP BY P.acronym, P.name;

--9
Print'***Question 9***';
SELECT PA.studentNumber, P.lastName, P.firstName,
    SUM(PA.amount) AS 'Total Payment Amount'
FROM Payment PA
JOIN Person P ON PA.studentNumber = P.number
JOIN PaymentMethod PM ON PA.paymentMethodId = PM.id
WHERE PM.explanation IN ('Cash', 'Certified Cheque')
GROUP BY PA.studentNumber, P.lastName, P.firstName
HAVING SUM(PA.amount) >= 10000.00
ORDER BY SUM(PA.amount) DESC;
