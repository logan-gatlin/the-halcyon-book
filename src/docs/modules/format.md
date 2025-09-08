# format
`format` is a module that provides functions for converting other types to strings.
## Functions
---
### integer: `std::integer -> std::string`
Returns the passed integer as a string.
#### Example
```halcyon
module demo =
    let () = format::integer 5 |> string::print
    (* prints "5" *)
end
```
---
### real: `std::real -> std::string`
Returns the passed real as a string.
#### Example
```halcyon
module demo =
    let () = format::real 5.4 |> string::print
    (* prints "5.4" *)
end
```
---
### boolean: `std::boolean -> std::string`
Returns the passed boolean as a string.
#### Example
```halcyon
module demo =
    let () = format::boolean true |> string::print
    (* prints "true" *)
end
```
---
### unit: `std::unit -> std::string`
Returns unit as a string.
#### Example
```halcyon
module demo =
    let () = format::unit () |> string::print
    (* prints "()" *)
end
```
