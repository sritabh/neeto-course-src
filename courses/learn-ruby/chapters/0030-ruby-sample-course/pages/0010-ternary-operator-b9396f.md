Typically, we write
`if else` conditions like this:

<codeblock language="ruby" type="lesson">
<code>
age = 22
can_vote =  if age > 10
              "yes"
            else
              "no"
            end

puts can_vote
</code>
</codeblock>

We can also write that
code as shown below:

<codeblock language="ruby" type="lesson">
<code>
age = 22
can_vote =  age > 10 ? "yes" : "no"
puts can_vote
</code>
</codeblock>

As we can see, this style of
writing makes the code much simpler.
In this case, the question mark
is acting like a **ternary operator**.

We write the condition
before the question mark, `?`.
If the condition is true,
then the item before
`:` is returned.

And if the condition is false,
then the item after `:` is returned.

Let's see one more example.

<codeblock language="ruby" type="lesson">
<code>
party_type = "official"
dress_type = party_type == "casual" ? "dress casually" : "dress formally"
puts dress_type
</code>
</codeblock>