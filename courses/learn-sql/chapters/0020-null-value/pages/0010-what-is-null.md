Before we discuss null first let's look at the students information.

<codeblock language="sql" dbName="students1.db" type="lesson">
<code>
SELECT *
FROM students
</code>
</codeblock>

In the students table scroll down and see the age of "Edgar" or of "Tonya".
We do not have any age information for them.

Similarly, look at the grade information for "Abraham" or course information for
"Hugh".
These information are also missing.

We can't put zero for missing information because their age or grade is not zero.
If we put zero as age then that would mean that the age of the student is zero.
However it is different from age information is missing.

In database we represent missing information as NULL.