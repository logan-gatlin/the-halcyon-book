# result
Result is a type that represents either success (Ok) or failure (Error).
Every result is either an Ok or an Error, both of which contain a value.
```halcyon
type result = fn a b => Ok of a | Error of b
```
## Functions
### Ok: `'0 -> (result '0 '1)`
Constructor for an Ok result.
### Error: `'1 -> (result '0 '1)`
Constructor for an Error result.
### is_ok: `(result '0 '1) -> boolean`
Returns true if the provided result is Ok, otherwise returns false.
#### Example
```halcyon
let my_result = result:Ok (2)
if result:is_ok my_result then
    std:print_string "Ok!"
else
    std:print_string "Error!"

(* prints "Ok!" *)
```
### is_err: `(result '0 '1) -> boolean`
Returns true if the provided result is Error, otherwise returns false.
#### Example 
```halcyon
let my_result = result:Error (2)
if result:is_err my_result then
    std:print_string "Error!"
else
    std:print_string "Ok!"

(* prints "Error!" *)
```
### unwrap_ok: `(result '0 '1) -> '0`
Returns the value contained in an Ok result.
Panics if the result is Error.
It is recommended that you use pattern matching in most cases instead of this.
#### Example
```halcyon
let my_result = result:Ok ("Hatsune Miku")
let () = my_result |> result:unwrap_ok |> std:print_string

(* prints "Hatsune Miku" *)
```
### unwrap_err: `(result '0 '1) -> '1`
Returns the value contained in an Error result.
Panics if the result is Ok.
It is recommended that you use pattern matching in most cases instead of this.
#### Example
```halcyon
let my_result = result:Error ("Kasane Teto")
let () = my_result |> result:unwrap_err |> std:print_string

(* prints "Kasane Teto" *)
```
### res_and: `(result '0 '1) -> (result '0 '1) -> (result '0 '1)`
If the first result passed is Ok, returns the second one.
Otherwise, return the first result, which is an Error.
#### Example
```halcyon
let my_result = result:Ok ("Akita Neru") |> resukt:res_and Error("Hatsune Miku") 
match my_result with
| result:Ok of a => std:print_string a
| result:Error of b => std:print_string b
(* prints "Hatsune Miku" *)

let new_result = result:Error ("Kasane Teto") |> result:res_and Error("Hatsune Miku")
match new_result with
| result:Ok of a => std:print_string a
| result:Error of b => std:print_string b
(* prints "Kasane Teto" *)
```
### expect: `string -> (result '0 '1) -> '0`
Returns the enclosed result value if the passed result is Ok.
If the passed result is an Error, prints the passed string, then panics.
#### Example
```halcyon
let () = result:Ok ("Akita Neru") |> result:expect ("Try doing it right next time") |> std:print_string 
(* prints "Akita Neru" *)

let () = result:Error ("Akita Neru") |> result:expect ("Try doing it right next time") |> std:print_string 
(* prints "Try doing it right next time", then panics *)
```
### res_or: `(result '0 '1) -> (result '0 '1) -> (result '0 '1)`
Returns the first passed result if it is Ok, otherwise returns the second passed result.
#### Example
```halcyon
let () = result:Ok ("Akita Neru") |> result:res_or Error ("Kasane Teto") |> result:unwrap_ok |> std:print_string 
(* prints "Akita Neru" *)

let () = result:Error ("Akita Neru") |> result:res_or Error ("Kasane Teto") |> result:unwrap_err |> std:print_string 
(* prints "Kasane Teto" *)

let () = result:Error ("Akita Neru") |> result:res_or Ok ("Kasane Teto") |> result:unwrap_ok |> std:print_string 
(* prints "Kasane Teto" *)
```
### unwrap_or: `(result '0 '1) -> '0 -> '0`
Returns the value enclosed in the first passed result if its Ok, otherwise return the second passed value.
#### Example
```halcyon
let () = result:Ok ("Hatsune Miku") |> result:unwrap_or "Kasane Teto" |> std:print_string 
(* prints "Hatsune Miku" *)

let () = result:Error ("Hatsune Miku") |> result:unwrap_or "Kasane Teto" |> std:print_string 
(* prints "Kasane Teto" *)
```
### and_then: `(result '0 '1) -> ('0 -> '1) -> (result '0 '1)`
If the passed result is Ok, returns a new result with an enclosed value equal to the passed result's enclosed value with the passed function appplied to it.
Otherwise, returns the passed Error.
#### Example
```halcyon
let () = result:Ok ("Kasane Teto") |> result:and_then (fn a => string:concatenate a " is my favorite") |> result:unwrap_ok |> std:print_string
(* prints "Kasane Teto is my favorite" *)

let () = result:Error ("Kasane Teto") |> result:and_then (fn a => string:concatenate a " is my favorite") |> result:unwrap_err |> std:print_string
(* prints "Kasane Teto" *)
```
