Apart from the first and last child,
you can also select a specific child
element using the `:nth-child` pseudo-class:

<codeblock language="css" type="lesson">
<code>
<panel language="html">
<ul>
  <li>Home</li>
  <li>About</li>
  <li>Services</li>
  <li>Contact</li>
</ul>
</panel>
<panel language="css">
ul {
  list-style-type: none;
  margin: 0 0 40px -40px;
}
ul > li {
  display: inline-block;
  padding-right: 20px;
}
li:nth-child(2) {
  color: orange;
}
</panel>
</code>
</codeblock>

Here `:nth-child(2)`
selects the **2nd** child.
Try changing the number to 1, 3 or 4
to see a different child being selected.

The child count starts
from **1**. Hence `:nth-child(1)` is
same as `:first-child`.

Using the `nth-child`
pseudo-class, you can also select
**even** or **odd** numbered child
elements, as shown below.
Try changing `odd` to `even` in
the following example:

<codeblock language="css" type="lesson">
<code>
<panel language="html">
<h2>Planets of the Solar System</h2>
<ul>
  <li>Mercury</li>
  <li>Venus</li>
  <li>Earth</li>
  <li>Mars</li>
  <li>Jupiter</li>
  <li>Saturn</li>
  <li>Uranus</li>
  <li>Neptune</li>
</ul>
</panel>
<panel language="css">
ul {
  list-style-type: none;
  margin-left: -40px;
}
li {
  padding: 10px;
}
li:nth-child(odd) {
  background-color: #f0f1f6;
}
</panel>
</code>
</codeblock>

Try all these values in the
example that follows:

**`:nth-child(n+3)`** - Selects all matching child elements starting from 3rd one<br>
**`:nth-child(3n)`** - Selects every 3rd matching child element<br>
**`:nth-child(3n-2)`** - Selects every 3rd matching child element starting from the first one


<codeblock language="css" type="lesson">
<code>
<panel language="html">
<div>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
</div>
</panel>
<panel language="css">
span {
  display: inline-block;
  width: 20px;
  height: 20px;
  background-color: lightgray;
  margin-right: 5px;
}
span:nth-child(n+3) {
  background-color: teal;
}
</panel>
</code>
</codeblock>