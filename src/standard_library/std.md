# std
std is a module that contains the 6 primitive types, as well as some functions that most Halcyon programs will need access to.
## Primitives
---
### integer 
The 64 bit two's complement integer type.
The maximum 64 bit signed integer is 9,223,372,036,854,775,807.
Integer literals can be written in multiple ways

|Literal| Representation                           |
|--------|---------------------------------------|
|`9_999` | Decimal number|
|`0b1111`| Binary number (prefixed with 0b)|
|`0o777` | Octal number (prefixed with 0o)|
|`0xFF`  | Hexadecimal number (prefixed with 0x)|

Base prefixes and hexadecimal digits are case insensitive.
Integer literals may have underscore `_` characters in any position.

-----
### real
A 64 bit floating point number, similar to `float` in C.

---
### string 
The string type supports UTF-8 encoded characters.
Use "" for string literals.
There are a number of supported escape sequences.

| Escape Sequence | Name                          |
|-----------------|-------------------------------|
| \n              | new line|
| \r              | carriage return|
| \t              | tab|
| \b              | back space|
| \               | backslash|
| \\"              | double quote|
| \\'              | single quote|
| \x7F            | Byte character code (2 hex digits)|
| \w7FFF          | Word character code (4 hex digits)|

#### Examples
```
"abcdefghijklmnopqrstuvwxyz1234567890" (* valid *)
"Ͱऐቕ" (* valid *)
"🤓☝️" (* valid *)
"I love Halcyon\n It is awesome" (* valid *)
"I hate Halcyon\e It is not awesome" (* invalid *)
```
---
### glyph
The character type.
A glyph must contain only a single character or escape sequence.
Use '' for glyph literals.

---
### unit
A type used to represent nothing.
Similar to `void` in C.

---
### boolean
The boolean type is either `true` or `false`.

## Functions 
---
### panic: `() -> '0`
Panic crashes the program intentionally.
Since it returns `'0`, panic can be "returned" in any function without causing type issues.

---
### assert: `boolean -> ()`
Crash the program if the parameter is false, otherwise do nothing and return unit.
#### Variations `boolean -> boolean -> ()`
Assert has several variations that have the same behavior.
They crash if the condition is false, otherwise, they return unit.
| Function | Condition |
|----------|-----------|
|assert_eq |Equal      |
|assert_ne |Not Equal  |
|assert_ge |Greater or Equal|
|assert_le |Less or Equal|
|assert_gt |Greater|
|assert_lt |Less|
---
### println: `string -> ()`
Prints the passed string to the console.
