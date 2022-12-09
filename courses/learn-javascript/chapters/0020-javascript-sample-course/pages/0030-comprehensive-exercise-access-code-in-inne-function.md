Access `authCode` returned by the dummy decode function, inside the authentication function `Auth` inside the MainApp, and return the same.

1. Try to acheive it with a one line change.

<codeblock language="javascript" type="exercise" testMode="multipleInput">
<code>
const mainApp = (code, decode) => {
const authCode = decode(code);
const Auth = () => {
      // your code here
    }
}
</code>

<hints>
<hint>
const mainApp = (code, decode) => {
    const authCode = decode(code);
    const Auth = () => {
        // return a value here
    }
}
</hint>
</hints>

<solution>
const mainApp = (code, decode) => {
    const authCode = decode(code);
    const Auth = () => {
        return authCode;
    }
    return Auth();
}
</solution>

<testcases>
<caller>
console.log(mainApp(code, decode));
</caller>
<testcase>
<i>
const code = '4X2&rs%#7D';
const decode = (value) => {
  return 'decodedValue';
}
</i>
</testcase>
<testcase>
<i>
const code = '5f2!*r43%2^&';
const decode = () => {
  return 'decodedValue';
}
</i>
</testcase>
</testcases>
</codeblock>