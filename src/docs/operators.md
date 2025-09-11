# Operators
The following is the full list of operators in Halcyon, in order of their precedence:
| Symbol | Operation |
|--------|-----------|
|unary - and -.| arithmetic negation |
|unary not | logical negation |
|\* and *. | multiplication |
|/ and /. | division |
|% | modulus |
|\+ and +. | addition|
|\- and -. | subtraction |
|xor | logical XOR |
|or | logical OR |
|\|> | function composition |
|==, !=, <=, >=, < > | comparison |
|and | logical AND |
| ; | continue |

Operators can be used as functions, as in `let two = (+) 1 1` 

## Integer and Real Operators
To make the type system simpler and type inference more effective, reals and integers have a different set of operators.  
| Integers | Reals |
|----------|-------|
| \+       |\+.    |
| \-       |\-.    |
| \*       |\*.    |
| /        |/.     |
| %        |       |
## The ; Operator
The ; operator discards whatever value is to the left of it. 
This is useful for chaining together function calls when you don't care about their return values, like the print function.
### Example
```halcyon
let one = (); (); (); (); 1
let also_one = (;) () 1
```
## The |> Operator
"|>" is the function composition operator. 
This operator calls a function, but with the parameter on the left side and the function on the right side. 
Note that |> has a lower precedence than a normal function call. 
### Example
```halcyon
# module demo =
    let sum = fn a b => a + b
    let better_sum = 0
        |> sum 1
        |> sum 2
        |> sum 3
        |> sum 4
        |> sum 5

    (* Heres what we would have to write without |> *)
    let worse_sum = sum 5 (sum 4 (sum 3 (sum 2 (sum 1 0))))
# end
```

