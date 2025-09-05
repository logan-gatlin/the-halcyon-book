# string
string is a module that provides functions for operating on strings
## Functions
---
### print: `std:string -> std:unit`
Prints the passed string to the console.
#### Example 
```halcyon
let () = string::print "Hi"
(* Prints "Hi" *)
```
---
### length: `std:string -> std:integer`
Returns the length of the passed string.
#### Example
```halcyon
let my_int = string::length "Hello"
(* my_int == 5 *)
```
### concatenate: `std:string -> std:string -> std:string`
Adds the second string to the end of the first.
#### Example
```halcyon
let () = string::concatenate "Kasane" " Teto" |> string::print
(* prints "Kasane Teto" *)
```
### from_integer: `std:integer -> std:string`
Returns the passed integer as a string.
#### Example
```halcyon
let () = string::from_integer 1234 |> string:::print
(* prints "1234" *)
```
