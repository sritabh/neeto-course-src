Using `querySelectorAll`, convert the text
inside all the paragraph elements to
😊😊😊.

<codeblock language="javascript" type="exercise" testMode="fixedInput">
<code>
<panel language="html">
<section>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
  <p>😔😔😔</p>
</section>
</panel>
<panel language="css">
body {
  background-color: steelblue;
}
section {
  display: flex;
  font-size: 2rem;
  text-shadow: 3px 3px 0px rgba(0,0,0,0.2);
}
</panel>
<panel language="javascript">

</panel>
</code>

<hints>
<hint>
let result = document.querySelectorAll("div");
result.forEach(div => {
  div.textContent = "Yes";
});
</hint>
</hints>

<solution>
let allParagraphs = document.querySelectorAll("p");
allParagraphs.forEach(para => {
  para.textContent = "😊😊😊";
});
</solution>
</codeblock>