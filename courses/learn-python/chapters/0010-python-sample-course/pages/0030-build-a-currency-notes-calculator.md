Monica has to pay her monthly rent to the landlord. She currently only has 10 rupee notes, 50 rupee notes and 100 rupee notes.
Given the amount, help her calculate the number of 10 rupee notes, 50 rupee notes and 100 rupee notes she will need to pay to her landlord.


**Example**

Rent: ₹7890

Monica will require:

- 7 x ₹100 notes
- 1 x ₹50 notes
- 4 x ₹10 notes

<a/>

<codeblock language="python" type="exercise" testMode="fixedInput">
<code>
rent = 9330
no_100_notes = 0
no_50_notes = 0
no_10_notes = 0

# Calculate the number of notes required to meet the given rent amount



# Print the result
print("Monica will require:")
print(str(no_100_notes) + " x ₹100 notes")
print(str(no_50_notes) + " x ₹50 notes")
print(str(no_10_notes) + " x ₹10 notes")
</code>

<hints>
<hint>
rent = 5520

no_100_notes = rent // 100  # number of ₹100 notes i.e 5
rent = rent % 100 # left over amount i.e 20
</hint>
</hints>

<solution>
rent = 9330
no_100_notes = 0
no_50_notes = 0
no_10_notes = 0

# Calculate the number of notes required to meet the given rent amount
no_100_notes = rent // 100
rent = rent % 100

no_50_notes = rent // 50
rent = rent % 50

no_10_notes = rent // 10
rent = rent % 10

# Print the result
print("Monica will require:")
print(str(no_100_notes) + " x ₹100 notes")
print(str(no_50_notes) + " x ₹50 notes")
print(str(no_10_notes) + " x ₹10 notes")
</solution>
</codeblock>