Let's find sum of all the ages.
We can solve this, using another aggregate function called `SUM`.

<Editor lang="sql" dbName="students1.db">
<code>
SELECT SUM(age)
FROM students
</code>
</Editor>

`SUM` will return the sum of all the not-null values in the column.
