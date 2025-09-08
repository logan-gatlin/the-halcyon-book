# real
`real` is a module that provides functions for operating on reals.
## Functions
---
### abs: `std::real -> std::real`
Returns the absolute value of the passed real.
#### Example
```halcyon
# module demo =
    let fourpointfive = real::abs -4.5
    let alsofourpointfive = real::abs 4.5
# end
```
---
### truncate: `std::real -> std::real`
Truncates the passed real by removing the decimal component.
#### Example
```halcyon
# module demo =
    let four = real::truncate 4.5
# end
```
