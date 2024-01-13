# AveSwiftHelpers
A collection of swift helpers


## `isEmptyOrNil`

`isEmptyOrNil` adds a helper function to both `Optional` and `Collection` that can be used to easily check if a (optional chained) collection is empty or nil:

```
if someObject?.someVariable?.someCollection.isEmptyOrNil == true {
  print("Empty")
}
```  

This is not super trivial to do, since if you add a `extension` on `Optional` for `isEmptyOrNil: Bool`, this will fail when optional chaining is involved, since you would be comparing `Bool? == true`, which is always false. `isEmptyOrNil` makes this work by using a custom Bool type as return, which has a custom `operator==`.
