
## Part One

**TL;DR:** `assoc` methods cannot update multiple properties at a time. `merge` methods can update multiple properties with a single statement.

The important difference between `mergeLeft` and `mergeRight` is which part will be overwritten. Another simpler way to think about this is which side will be kept intact during merging, that is, in `mergeLeft` it will be `left` argument and in `mergeRight` it will be `right` argument.

Let's see what `mergeLeft` does:

```js
mergeLeft({name: "ORD2"}, order);
/*
{
  id: 1,
  name: "ORD2",
  quantity: 10,
  customer: {
    name: "John",
    address: {
      city: "Miami",
      pin: 111111,
    }
  }
}
*/
```

So as you can see in the above example, the properties of `order` was overwritten by the left value, that is `{name: "ORD2"}`.

Let's see how `mergeRight` is different:

```js
const tmpOrder = {
  id: 2,
  name: "ORD2",
  quantity: 10,
  customer: {
    firstName: "John",
    lastName: "Smith",
  }
};
awf
mergeRight(tmpOrder, order);
/*
{
  id: 1,
  name: "ORD1",
  quantity: 10,
  customer: {
    name: "John",
    address: {
      city: "Miami",
      pin: 111111,
    }
  }
}
*/
```
## Part Two
So as you can see in the above example, the properties of `tmpOrder` was overwritten by the right value, that is of `order`.

Apart from `id`, `name` properties, the non-primitive `customer` property also got overwritten. Like it was mentioned at the start, `mergeRight`, "overwrites" the first `object` with the second one. So essentially the following happened underneath the hood:

```js
{
  ...tmpOrder,
  ...order,
}
```
## Part Three

So the `customer` key of `tmpOrder` got fully overwritten by the `customer` key of `order`.
