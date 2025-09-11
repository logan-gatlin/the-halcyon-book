# The Type System
Halcyon is a statically typed language with full type inference.
Type inference means that the types of functions and variables do not need to be written, they can be guessed by the compiler.
Compare a function which adds two integers written in C versus in Halcyon:
```c
int add_integers(int x, int y) {
  return x + y;
}
```
```halcyon
let add_integers = fn x y => x + y
```

Type annotations can be added using `:`, but they are not necessary.
It is an error for a type annotation to be different from the actual type.
```halcyon
let add_integers : std::integer -> std::integer =
  fn (x : std::integer) (y : std::integer) => x + y
```
This book will often provide type annotations for clarity's sake, but this is not intended to imply they are best practice or required.

## Primitive types
The following is a list of the primitive types, as well as their equivalents in C:
| Halcyon type | C type |
|------|--------------|
| `()` or `unit` | `void` |
| `integer` | `int` or `long` |
| `real` | `double` |
| `boolean` | `bool` |
| `glyph` |  `wchar_t` |
| `string` | `wchar_t[]` |

```admonish note
The `glyph` and `string` types are UTF-8 encoded, not ASCII.
```

```admonish note
Primitive types are defined in the `std` module
```

~~~admonish example
```halcyon
let nothing : () = ()
let life : std::integer = 42
let pi : std::real = 3.14159
let yes : std::boolean = true
let grade : std::glyph = 'A'
let greeting : std::string = "Hello world!"
```
~~~

## Arrays
An array is a list of values of the same type, and that has a variable length.
To define an array, use square brackets:
```halcyon
let numbers : [std::integer] = [1, 2, 3, 4]
```

## Tuples
A tuple is a list of values that may be different types, and has a fixed length.
To define a tuple, use parenthesis:
```halcyon
let grocery_list = ("eggs", "bacon", "milk")
let favorite_numbers = (42, 2.718, '∞')
let list_of_lists = (grocery_list, favorite_numbers)
```

## Function types
A fundamental rule in Halcyon is that every function has a single parameter.
This is achieved using a process called currying.
Understanding this concept is extremely important, so lets work through an example.
Consider this function:
```halcyon
let add_integers = fn x y z => x + y + z
```
The compiler will automatically transform `add_integers` into the following:
```halcyon
let add_integers =
  fn x =>
    fn y =>
      fn z => x + y + z 
```
Let us see how the expression `add_integer 1 2 3` is evaluated.
First, substitute the variable name for its definition:
```halcyon
(fn x => fn y => fn z => x + y + z) 1 2 3
```
Next, call the outermost function with the first argument `1`:
```halcyon
(fn y => fn z => 1 + y + z) 2 3
```
Repeat with the next two arguments `2` and `3`:
```halcyon
(fn y => fn z => 1 + y + z) 2 3
(fn z => 1 + 2 + z) 3
1 + 2 + 3
6
```
The type of a function is written as `a -> b`, where `a` is the parameter type, and `b` is the return type.
The `->` operator, like `=>`, is right associative.
This means that `a -> b -> c` is interpreted as `a -> (b -> c)`.
The type of `add_integers` in the example above is:
```
integer -> integer -> integer -> integer
```
