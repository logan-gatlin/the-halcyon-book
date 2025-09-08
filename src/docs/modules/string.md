# string
`string` is a module that provides functions for operating on strings
## Functions
---
### print: `std::string -> std:unit`
Prints the passed string to the console.
#### Example 
```halcyon
# module demo = 
    let () = string::print "Hi"
    (* Prints "Hi" *)
# end
```
---
### length: `std::string -> std::integer`
Returns the length of the passed string.
#### Example
```halcyon
# module demo = 
    let my_int = string::length "Hello"
    (* my_int == 5 *)
# end
```
### concatenate: `std::string -> std::string -> std::string`
Adds the second string to the end of the first.
#### Example
```halcyon
# module demo = 
    let () = string::concatenate "Kasane" " Teto" |> string::print
    (* prints "Kasane Teto" *)
# end
```
