# opt
Option is a type that represents an optional value: every Option is either Some and contains a value, or None, and does not.
```
type t = fn T => Some of T | None of std:unit
```
## Functions 
### Some: '0 -> (opt '0)
Constructor for a Some option.
#### Example
```
let my_some = opt:Some (12)
```
### None: ()
Constructor for a None option.
#### Example
```
let my_none = opt:None ()
```
### is_some: (opt:t '0) -> std:boolean
Returns true if the passed option is Some, otherwise returns false.
#### Example
```
let value = opt:Some (12) |> is_some 
(* value is true *)
```
### is_none: (opt:t '0) -> std:boolean
Returns true if the passed option is None, otherwise false.
```
let value = opt:None () |> is_none 
(* value is true *)
```
### unwrap: (opt:t '0) -> '0
If the passed option is a some, returns the enclosed value, otherwise panics.
#### Example
```
let value = opt:Some (12) |> opt:unwrap
(* value == 12 *)
let other_value = opt:None () |> opt:unwrap
(* panics *)
```
### map: ('0 -> '1) -> (opt:t '0) -> (opt:t '1)
If the passed option is a Some, returns a copy of the passed option with the passed function applied to its value. Otherwise, returns None.
#### Example
```
let my_opt = opt:Some (2)
let () = my_opt |> opt:map (fn a => a * 2) |> opt:unwrap |> string:from_integer |> std:print_string
(* prints 4 *) 
```
### iterate: ('0 -> '1) -> (opt:t '0) -> std:unit
If the passed option is a Some, runs passed function on the passed option, then returns unit. Otherwise, returns unit.
#### Example
```
let () = opt:Some ("Teto") |> opt:iterate std:print_string
(* prints "Teto" *)
```