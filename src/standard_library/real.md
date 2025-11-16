# real
`real` is a module that provides functions for operating on reals.
## Functions
---
### abs: `real -> real`
Returns the absolute value of the passed real.
#### Example
```halcyon
let fourpointfive = real::abs -4.5
let alsofourpointfive = real::abs 4.5
```
---
### truncate: `real -> real`
Truncates the passed real by removing the decimal component.
#### Example
```halcyon
let four = real::truncate 4.5
```
