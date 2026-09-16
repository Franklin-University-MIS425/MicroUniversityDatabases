-- Read-only verification after setup; expect 281 total rows.
SELECT 'class' AS table_name, COUNT(*) AS actual_rows, 44 AS expected_rows FROM microuniversity.class
UNION ALL
SELECT 'course' AS table_name, COUNT(*) AS actual_rows, 28 AS expected_rows FROM microuniversity.course
UNION ALL
SELECT 'department' AS table_name, COUNT(*) AS actual_rows, 11 AS expected_rows FROM microuniversity.department
UNION ALL
SELECT 'employee' AS table_name, COUNT(*) AS actual_rows, 37 AS expected_rows FROM microuniversity.employee
UNION ALL
SELECT 'enroll' AS table_name, COUNT(*) AS actual_rows, 99 AS expected_rows FROM microuniversity.enroll
UNION ALL
SELECT 'professor' AS table_name, COUNT(*) AS actual_rows, 22 AS expected_rows FROM microuniversity.professor
UNION ALL
SELECT 'school' AS table_name, COUNT(*) AS actual_rows, 2 AS expected_rows FROM microuniversity.school
UNION ALL
SELECT 'student' AS table_name, COUNT(*) AS actual_rows, 38 AS expected_rows FROM microuniversity.student
ORDER BY table_name;
