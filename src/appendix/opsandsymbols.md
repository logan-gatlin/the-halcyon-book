# Appendix B: Operators and Symbols
This appendix contains a glossary of Halcyon's syntax, including operators and other symbols.
## Operators
| Symbol | Description |
|--------|-----------|
|(unary) `-` `-.`| arithmetic negation |
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
## Non-operator Symbols
The following list contains all symbols that don’t function as operators; that is, they don’t behave like a function.
|Symbol|Description|
|------|-----------|
| `ident : type` | Type constraint | 
|`()`|Unit literal/Empty tuple|
|`ident : ()`|Alias for std::unit|
|`(expr,)`|Single element tuple|
|`(expr, ...)`|Tuple expression|
|`(type,...)`|Tuple type|
|`[type]`|Array type|
|`[expr, ...]`|Array literal|
|`ident::ident`|Module path|
|`ident = expr`|Assignment|
|`{ident,...}`|Struct type|
|`{expr,...}`|Struct literal|
|`ident.ident`|Struct field access|
|`pat \| pat`| Pattern alternatives|
|`type \| type`| Sum type alternatives|
|`pat => expr`| Part of match arm syntax|
|`signature => expr`| Part of function syntax|
|`_`|Wildcard pattern match|
|`_`|“Ignored” pattern binding|
|`--`|Line comment|
|`(*...*)`|Block Comment|    

