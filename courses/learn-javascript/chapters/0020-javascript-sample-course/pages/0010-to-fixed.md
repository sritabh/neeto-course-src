Sometimes,
we need to fix the precision
for our decimal numbers.
For example,
we might need **2.43519**
to be represented as **2.44**,
which means we only
want two digits
after the decimal point.
In such cases,
the method `toFixed()`
can help us.
It fixes the number
of digits returned
after the decimal point.

<codeblock language="javascript" type="lesson">
<code>
let myNum = 2.34567;
let result = myNum.toFixed(2);
console.log(result);
</code>
</codeblock>

To get the last digit
in the result,
it rounds the given
number as shown
in the example above.
