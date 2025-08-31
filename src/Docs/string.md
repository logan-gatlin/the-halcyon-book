# string
string is a module that provides functions for operating on strings
## Functions
### length: std:string -> std:integer
Returns the length of the passed string.
#### Example
```
let my_int = string:length "Hello"
(* my_int == 5 *)
```
### concatenate: std:strin -> std:string -> std:string
Adds the second string to the end of the first.
#### Example
```
let () = string:concatenate "Kasane" " Teto" |> std:print_string
(* prints "Kasane Teto" *)
```
### from_integer: std:integer -> std:string
Returns the passed integer as a string.
#### Example
```
let () = from_integer 1234 |> std:print_string
(* prints "1234" *)
```
