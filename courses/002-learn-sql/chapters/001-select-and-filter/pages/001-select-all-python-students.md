Find all the students who are enrolled in the _Python_ course.

We need to use `where` condition.

<Editor lang="sql" dbName="students1.db">
<code>
SELECT *
FROM students
WHERE course = 'Python'
</code>
</Editor>If you click on "students" tab you can see that the students table has 18 records.
However out of 18 there are only 3 students whose are enrolled in the _Python_ course.
