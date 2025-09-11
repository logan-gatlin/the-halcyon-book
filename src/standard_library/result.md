# result
`result` is a type that represents either success (Ok) or failure (Error).
Every result is either an Ok or an Error, both of which contain a value.
```halcyon
type result = fn a b => Ok of a | Error of b
```
## Functions
---
### Ok: `'0 -> (result::t '0 '1)`
Constructor for an Ok result.
#### Example
```halcyon
# module demo = 
    let my_OK = result::Ok (2)
# end
```
---
### Error: `'1 -> (result::t '0 '1)`
Constructor for an Error result.
#### Example
```halcyon
# module demo = 
    let my_Error = result::Error (2)
# end
```
---
### is_ok: `(result::t '0 '1) -> boolean`
Returns true if the passed result is Ok, otherwise returns false.
#### Example
```halcyon
# module demo = 
    let my_result = result::Ok (2)
    let () = 
    if result::is_ok my_result then
        string::print "Ok!"
    else
        string::print "Error!"

    (* prints "Ok!" *)
# end
```
---
### is_err: `(result::t '0 '1) -> boolean`
Returns true if the passed result is Error, otherwise returns false.
#### Example 
```halcyon
# module demo = 
    let my_result = result::Error (2)
    let () = 
    if result:is_err my_result then
        string::print "Error!"
    else
        string::print "Ok!"

    (* prints "Error!" *)
# end
```
---
### unwrap_ok: `(result::t '0 '1) -> '0`
Returns the value contained in the passed Ok result.
Panics if the result is Error.
#### Notes
It is recommended that you use pattern matching in most cases instead of this.
#### Example
```halcyon
# module demo = 
    let my_result = result::Ok ("Hatsune Miku")
    let () = my_result |> result::unwrap_ok |> string::print

    (* prints "Hatsune Miku" *)
# end
```
---
### unwrap_err: `(result::t '0 '1) -> '1`
Returns the value contained in the passed Error result.
Panics if the result is Ok.
#### Notes
It is recommended that you use pattern matching in most cases instead of this.
#### Example
```halcyon
# module demo = 
    let my_result = result::Error ("Kasane Teto")
    let () = my_result |> result::unwrap_err |> string::print

    (* prints "Kasane Teto" *)
# end
```
---
### res_and: `(result::t '0 '1) -> (result::t '0 '1) -> (result::t '0 '1)`
If the first result passed is Ok, returns the second one.
Otherwise, return the first result, which is an Error.
#### Example
```halcyon
# module demo = 
    let my_result = result::Ok ("Akita Neru") |> result::res_and Error("Hatsune Miku") 
    let () = match my_result with
    | result:Ok of a => string::print a
    | result:Error of b => string::print b
    (* prints "Hatsune Miku" *)

    let new_result = result::Error ("Kasane Teto") |> result::res_and Error("Hatsune Miku")
    let () = match new_result with
    | result::Ok of a => string::print a
    | result::Error of b => std::print b
    (* prints "Kasane Teto" *)
# end
```
---
### expect: `std::string -> (result::t '0 '1) -> '0`
Returns the enclosed result value if the passed result is Ok.
If the passed result is an Error, prints the passed string, then panics.
#### Example
```halcyon
# module demo = 
    let () = result::Ok ("Akita Neru") |> result::expect ("Try doing it right next time") |> string::print 
    (* prints "Akita Neru" *)

    let () = result::Error ("Akita Neru") |> result::expect ("Try doing it right next time") |> string::print 
    (* prints "Try doing it right next time", then panics *)
# end
```
---
### res_or: `(result::t '0 '1) -> (result::t '0 '1) -> (result::t '0 '1)`
Returns the first passed result if it is Ok, otherwise returns the second passed result.
#### Example
```halcyon
# module demo = 
    let () = result::Ok ("Akita Neru") |> result::res_or Error ("Kasane Teto") |> result::unwrap_ok |> string::print 
    (* prints "Akita Neru" *)

    let () = result::Error ("Akita Neru") |> result::res_or Error ("Kasane Teto") |> result::unwrap_err |> string::print
    (* prints "Kasane Teto" *)

    let () = result::Error ("Akita Neru") |> result::res_or Ok ("Kasane Teto") |> result::unwrap_ok |> string::print
    (* prints "Kasane Teto" *)
# end
```
---
### unwrap_or: `(result::t '0 '1) -> '0 -> '0`
Returns the value enclosed in the first passed result if its Ok, otherwise return the second passed value.
#### Example
```halcyon
# module demo = 
    let () = result::Ok ("Hatsune Miku") |> result::unwrap_or "Kasane Teto" |> string::print 
    (* prints "Hatsune Miku" *)

    let () = result::Error ("Hatsune Miku") |> result::unwrap_or "Kasane Teto" |> string::print 
    (* prints "Kasane Teto" *)
# end
```
---
### and_then: `(result::t '0 '1) -> ('0 -> '1) -> (result::t '0 '1)`
If the passed result is Ok, returns a new result with an enclosed value equal to the passed result's enclosed value with the passed function appplied to it.
Otherwise, returns the passed Error.
#### Example
```halcyon
# module demo = 
    let () = result::Ok ("Kasane Teto") |> result::and_then (fn a => string:concatenate a " is my favorite") |> result::unwrap_ok |> string::print
    (* prints "Kasane Teto is my favorite" *)

    let () = result::Error ("Kasane Teto") |> result::and_then (fn a => string:concatenate a " is my favorite") |> result::unwrap_err |> string::print
    (* prints "Kasane Teto" *)
# end
```
