# format
`format` is a module that provides functions for converting other types to strings.
## Functions
---
### integer: `integer -> string`
Returns the passed integer as a string.
#### Example
```halcyon
do format::integer 5
    |> string::print
(* prints "5" *)
```
---
### real: `real -> string`
Returns the passed real as a string.
#### Example
```halcyon
do format::real 5.4
    |> string::print
(* prints "5.4" *)
```
---
### boolean: `boolean -> string`
Returns the passed boolean as a string.
#### Example
```halcyon
do format::boolean true
    |> string::print
(* prints "true" *)
```
---
### unit: `unit -> string`
Returns unit as a string.
#### Example
```halcyon
do format::unit ()
    |> string::print
(* prints "()" *)
```
