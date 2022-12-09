Finish the method definition below.

Given a string `str` and another string `marker`, the method `split_string` should split the string `str` with `marker` and return the array that's generated.

Note: If value of `marker` is not provided, `split_string` should return `str` split by `" "`.

<codeblock language="ruby" type="exercise" testMode="multipleInput">
<code>
def split_string(str, marker = nil)
  # write your code here
end
</code>

<hints>
<hint>
def split_string(str, marker = nil)
  str.split(marker[0])
end
</hint>
</hints>

<solution>
def split_string(str, marker = nil)
  str.split(marker)
end
</solution>

<testcases>
<caller>
puts split_string(str, marker)
</caller>
<testcase>
<i>
str = "Michael Clarke Duncan"
marker = " "
</i>
</testcase>
<testcase>
<i>
str = "Haley Joel Osmont"
marker = nil
</i>
</testcase>
<testcase>
<i>
str = "Love, Death and Robots, "
marker = ", "
</i>
</testcase>
</testcases>
</codeblock>