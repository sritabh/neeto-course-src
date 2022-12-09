If the length of **name** is
more than 4 letters,
then print **long name**.
Otherwise, print **small name**.
Use ternary operator to
solve this problem.

<codeblock language="ruby" type="exercise" testMode="fixedInput">
<code>
name = "Mary"
</code>

<hints>
<hint>
age = 22
can_vote =  age > 10 ? "yes" : "no"
puts can_vote
</hint>
</hints>

<solution>
name = "Mary"
puts name.length > 4 ? "long name" : "small name"
</solution>
</codeblock>