# Operators Reference
The following is the full list of operators in Halcyon, in order of their precedence:
| Symbol | Description |
|--------|-----------|
|(unary) `- -.`| arithmetic negation |
|(unary) `not` | logical negation |
| `*` `*.` | multiplication |
|`/` `/.`| division |
| `%` | modulus |
| `+` `+.` | addition|
| `-` `-.` | subtraction |
| (function call) | |
| `>>` `<<` | function composition |
| `xor` | logical XOR |
| `or` | logical OR |
| `\|>` | function pipe |
| `==` `!=` `<=` `>=` `<` `>` | comparison |
| `and` | logical AND |
| `;` |  |

```admonish warning
Currently, the comparison operators are only defined for primitive types.
Comparing other data types will cause a crash.
```

Operators are regular functions that are defined in the `std` module.
An operator's function can be accessed by surrounding it in parenthesis, like `( + ) 1 2 == 1 + 2`

```admonish warning
Always put whitespace around an operator when it is in parenthesis.
`(*)` is parsed as the beginning of a comment, while `( * )` is the multiplication operator.
```

## Integer and Real Operators
Because operators are functions, the operators for integers and reals are different.
| Integers | Reals |
|----------|-------|
| `+` | `+.` |
| `-` | `-.` |
| `*` | `*.` |
| `/` | `/.` |
| `%` | |
## The `;` Operator
The `;` simply returns the value to the right.
It is useful for chaining together function calls with side effects.
### Example
```halcyon
do  std::println "old pond";
    std::println "frog leaps in";
    std::println "water's sound";
    std::println " - Bashō'"
```
## The `|>` Operator
`|>` is the pipe operator. 
This operator calls a function on the right with an argument on the left.
The pipe operator helps create function "pipelines", where the return value of one function becomes the parameter of the next function.
```admonish note
Function calls have a higher precedence than `|>`
```

### Example
```halcyon
do format::real 3.14159
    (* Convert real to string *)
    |> string::concatenate "pi = "
    (* Prepend "pi = " *)
    |> std::println
    (* Prints "pi = 3.14159" *)
```

## The >> and << operator
The `>>` and `<<` operators perform function composition.
Given two functions `f` and `g`, `f >> g` is equivalent to `fn x => g(f(x))`.
The reverse operation `f << g` is equivalent to `fn x => f(g(x))`.


