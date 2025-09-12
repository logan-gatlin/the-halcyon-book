# Appendix A: Keywords
The following list contains keywords that are reserved for current or future use by the Halcyon language. As such, they cannot be used as identifiers.
## Keywords Currently in Use
The following is a list of keywords currently in use, with their functionality described.
|Keyword|Use|Example
|--|--|--|
|`module`, `end` |Declares the beginning and end of a module respectively|`module demo = ... end`|
|`import`| Imports a function from another language, such as JavaScript or C| 
|`let`| Defines a variable|`let myint = 5`|
|`do`| Executes an expression (like a `main` function)|`do string::print "Hi"`|
|`type`| Defines a new type, or type alias|`type twoints = (std::int, std::int)`|
|`match`, `with`| Matches a discriminant with one or more patterns| `match myint with \|4 => ... \|5 => ...`|
|`if`,`then`,`else`| Evaluates to a value based on a boolean expression|`if myint == 5 then ... else ...`|
|`fn`|Declares a function|`let myfn = fn a => a + 1`|
|`of`|Denotes types that a constructor name contains|`type result = fn A B => Ok of A \| Error of B`|
|`in`|Limits a variable's scope to the next expression|`let myint = 5 in let mynewint = myint + 1`|

