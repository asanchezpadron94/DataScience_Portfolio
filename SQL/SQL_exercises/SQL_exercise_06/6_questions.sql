-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists

-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
SELECT b.name as Scientist, c.name AS Project, c.hours 
FROM ex_06.assignedto AS a
LEFT JOIN ex_06.scientists AS b ON a.scientist = b.ssn
LEFT JOIN ex_06.projects AS c ON a.project = c.code
ORDER BY c.name, b.name
;

-- 6.2 Select the project names which are not assigned yet
SELECT c.name AS Project
FROM ex_06.assignedto AS a
RIGHT JOIN ex_06.projects AS c ON a.project = c.code
WHERE a.scientist IS NULL
;