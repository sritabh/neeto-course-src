Set `background-color` to
**orange** for every 4th
child element that is a `span`:

<codeblock language="css" type="exercise" testMode="fixedInput">
<code>
<panel language="html">
<div>
  <span>Eve Smith</span>
  <span>Sam Smith</span>
  <span>Renu Sen</span>
  <span>Lao Xun</span>
  <span>John Doe</span>
  <span>Linh Tran</span>
  <span>Jane Doe</span>
  <span>Chinua Achebe</span>
  <span>Carlos Alberti</span>
</div>
</panel>
<panel language="css">
span {
  display: inline-block;
  margin-right: 4px;
  padding: 5px 8px;
  border-radius: 3px;
  background-color: lightgray;
}
</panel>
</code>

<hints>
<hint>
span {
  display: inline-block;
  margin-right: 4px;
  padding: 5px 8px;
  border-radius: 3px;
  background-color: lightgray;
}
span:pseudo-class(4n) {
  background-color: orange;
}
</hint>
</hints>

<solution>
span {
  display: inline-block;
  margin-right: 4px;
  padding: 5px 8px;
  border-radius: 3px;
  background-color: lightgray;
}
span:nth-child(4n) {
  background-color: orange;
}
</solution>
</codeblock>