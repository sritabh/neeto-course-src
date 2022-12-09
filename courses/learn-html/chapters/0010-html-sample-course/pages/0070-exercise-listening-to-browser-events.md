When someone clicks on the `h2` element,
the text inside it should change to
**This text was clicked ✅**.

Use the `addEventListener`
method to achieve this.

<codeblock language="javascript" type="exercise" testMode="fixedInput">
<code>
<panel language="html">
<h2>
  This text was not clicked ❌
</h2>
</panel>
<panel language="javascript">

</panel>
</code>

<hints>
<hint>
elemName.addEventListener("eventName", () => alert("Something happened!"));
</hint>
</hints>

<solution>
let clickStatus = document.querySelector('h2');
clickStatus.addEventListener("click", (e) => clickStatus.textContent = "This text was clicked ✅");
</solution>

<domtestevents>
<event>
document.querySelector('h2').click();
</event>
</domtestevents>
</codeblock>