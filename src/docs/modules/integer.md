# integer
`integer` is a module that provides functions for operating on integers.
## Functions
---
### abs: `std::integer -> std::integer`
Returns the absolute value of the passed integer.
#### Example
```halcyon
module demo =
    let five = integer::abs -5
    let alsofive = integer::abs 5
end
```
---
### pow: `std::integer -> std::integer -> std::integer`
Returns the first passed integer to the power of the second passed integer.
#### Example
```halcyon
module demo =
    let four = integer::pow 2 2
end
```
---
