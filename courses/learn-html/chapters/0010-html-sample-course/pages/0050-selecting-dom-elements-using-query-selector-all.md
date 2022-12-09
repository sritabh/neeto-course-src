`querySelectorAll` will select
all the HTML elements which match the
provided query. This is a versatile
selector
and
can match elements using any of the
CSS selectors, including class names, tag names,
id names or any complex selectors too.

The method returns an array-like
list of all the matched DOM elements. You
can iterate over it using loops, or
you can convert it to an array using
`Array.from()`.

<codeblock language="javascript" type="lesson">
<code>
<panel language="html">
<h2>Interesting Choice of Words</h2>
<p>A paragraph that states nothing new.</p>
<p class = "interesting-paragraph">A paragraph that could have been interesting.</p>
<p id = "brutal-paragraph"><span>This</span> paragraph <span>doesn't</span> inspire.</p>
</panel>
<panel language="javascript">
let allParagraphs = document.querySelectorAll('p');
allParagraphs.forEach(para => {
  para.style.border = "3px solid crimson";
});
// A complex selector
let inspirationConfirmation = document.querySelectorAll('#brutal-paragraph>span');
inspirationConfirmation.forEach(word => {
  if(word.textContent === "doesn't") word.textContent = "does";
});
</panel>
</code>
</codeblock>

The selectors that we pass in this
method are simply the selectors
that we have used in CSS. This means you
can use `#` to select using the id, `.` to
select the elements using their class.
You can go as detailed as possible
with your selectors.

For example, the `inspirationConfirmation`
variable gets its value through a complex
CSS selector in `document.querySelector('#brutal-paragraph>span')`.