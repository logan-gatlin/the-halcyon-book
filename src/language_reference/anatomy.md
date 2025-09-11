# Anatomy of a program
Lets examine a Halcyon program piece by piece.
Here is a Fizz Buzz program:
```halcyon
{{ #include ../../examples/fizzbuzz.hc }}
```

## Modules
A Halcyon source file contains one or more modules.
```
{{ #include ../../examples/fizzbuzz.hc:1 }}
(* ... *)
{{ #include ../../examples/fizzbuzz.hc:15 }}
```
Modules contain four kinds of statements:
* `let` defines a variable
* `do` executes an expression (like a `main` function)
* `type` defines a new type, or type alias (described later)
* `import` imports a function from another language, such as JavaScript of C
Statements do not require whitespace or semicolons to separate them.

A module acts as a namespace.
To access a value or type from another module, the `::` symbol is used.
For example, `std::println` refers to the `println` function in the `std` module.

## Functions
Functions are a kind of expression.
They are defined using the syntax `fn [parameters] => [body]`.
Here, a function is defined with two parameters `number` and `max`.
```halcyon
{{ #include ../../examples/fizzbuzz.hc:2 }}
```
The body of a function is a single expression after the `=>` operator.
The functions return value is the value of this expression, there is no `return` keyword.

The syntax for function calls is significantly different from other languages.
If the argument to a function is a literal (numbers, strings, booleans, arrays, structures, etc), no parenthesis are required.
```halcyon
do std::println "Hello World!"
```
If an argument is an expression, it must be wrapped in parenthesis.
```halcyon
do add_integers (5 - 1) 4
```
An alternative way to call a function is with the `|>` operator.
This operator calls a function on the right with an argument on the left.
```halcyon
do "Hello World!" |> std::println
```

It is even possible to combine both syntax.
The `|>` operator has a lower precedence than a regular function call, so the argument to the left of it will come last.
```halcyon
do "World!"
  |> string::concatenate "Hello "
  (* Equivalent to:
   * string::concatenate "Hello " "World!" *)
  |> std::println
  (* Prints "Hello World!" *)
```
## Match expressions
The `match` expression is the most important control flow in Halcyon.
It is similar to, but much more powerful than `switch` statements in other languages.
A match expression consists of an expression to match on (the discriminant), and a list of cases.
Here, the program is matching on the tuple `(number % 3, number % 5)`:
```halcyon
{{ #include ../../examples/fizzbuzz.hc:3:7 }}
```
A match case has the syntax `| [pattern] => [expression]`.
The discriminant is compared with each pattern in order.
The entire expression evaluates to the case of the first pattern matched.
For example, consider the case:
```halcyon
{{ #include ../../examples/fizzbuzz.hc:4 }}
```
The pattern `(0, 0)` is matched *only* when the discriminant is equal to `(0, 0)`.
However, this pattern:
```halcyon
{{ #include ../../examples/fizzbuzz.hc:5 }}
```
only requires the first value in the tuple to be `0`.
The `_` symbol, or any identifier, is a 'wildcard' that matches anything.

This match expression evaluates to `"FizzBuzz"` if `number` is a multiple of 3, and 5,
`"Fizz"` if `number` is only a multiple of 3,
`"Buzz"` if `number` is only a multiple of 5,
and `format::integer number` otherwise.
This is string is then printed.
```halcyon
{{ #include ../../examples/fizzbuzz.hc:8 }}
```
```admonish note
The `;` symbol is an operator like in bash.
Its purpose is to join together two expressions.
```

## If expressions
The `if` expression works exactly the same as in other lanuguages, with the exception that the `else` clause is mandatory.
This is because `if` is an expression, not a statement, and so it must evaluate to *something* in either case.
Here, the program recursively calls `fizz_buzz` if `number` is less than `max`.
Otherwise, the function returns `()` (similar to `void` or `None` in other languages).
```halcyon
{{ #include ../../examples/fizzbuzz.hc:9:12 }}
```

## Comments
There are two kinds of comments, single line and block.
A single line comments begin with two dashes `--`.
Block comments begin with `(*` and end in `*)`, and may be nested inside other block comments.
It is conventional to begin every line of a block comment with `*`, but this is not required.
```halcyon
-- This is a line comment
(*
 * This is a block comment,
 * it can span multiple lines
   (*
    * This is a nested block comment
   *)
*)
```

## Non-features
### Mutable variables
Every variable in Halcyon is constant.
Once a variable is defined, it cannot be changed.
### Loops
Halcyon does not have `for` or `while` loops.
Instead, all looping is done through recursion.
The compiler performs [tail call optimization](https://en.wikipedia.org/wiki/Tail_call) to convert recursive functions into simple loops.
This means that your program will not overflow its stack no matter how deeply it recurses.

```admonish warning
Tail call optimizization is only possible in certain circumstances. 
It is only done when the recursive call is the *last* operation performed in the function.
The fizzbuzz example is tail recursive.
```

### Exceptions and null
Halcyon does not have exceptions or null.
Functions that may fail instead return an `opt` or `result`.
These are covered more in-depth in their respective doc pages.

