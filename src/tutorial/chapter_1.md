# Tutorial
The goal of this tutorial is to teach the basics of Halcyon to programmers with a novice to intermediate level of experience. It will cover the basics of functional programming from an imperative perspective. Halcyon is heavily inspired by O'Caml, so if you already know that language you can safely skip or skim this.

Functional style program is very different from imperative programming in languages like C, Java, Python, etc. This tutorial will slowly build up to the more advanced topics, with the hope that it is digestible for programmers coming from these other languages.

## How to read this tutorial
The best way to learn is by doing. Open the online compiler in another browser window and split screen it with this one. This compiler runs fully in your browser, and re-compiles the code as you type. The compiler is pretty fast so this isn't much of a problem, but many browsers tend to stall or even crash when running complicated programs like this. This is not something I can fix, so keep the compiler in its own window!

There WILL be compiler bugs, and some of them might crash the page or your browser. Crashing your program may also cause bad behavior. If the compiler stops responding for any reason, copy your current code and refresh the window.

As you go through the tutorial, copy snippets of code into the compiler. Toy around with them, see what compiles and what doesn't. Break things and experiment. Report any bugs to me please!

## Introduction
Let's write the simplest possible program. Note that whitespace is not significant, you can put a line break anywhere in a program without changing its meaning.
```halcyon
module Demo = 
end
```
This code creates a module named Demo with no contents. Modules are how code is organized in Halcyon: all variables, functions, and types must be inside a module. This program runs and exits without producing any output. Lets create a variable called num inside our module using the let keyword.
```halcyon
module Demo =
    let num = 4
end
```
Unlike some languages like C and Java, Halcyon has full type inference. This means that the compiler can infer the type of variables and functions, and so you do not have to write them. In this case, num has the type integer. Here is the full list of primitive types (and their C equivalent):

- unit (void)
- integer (int)
- real (float)
- boolean (bool)
- glyph (char)
- string (string)
```halcyon
module PrimitiveExamples =
    let nothing  = ()             (* unit    *)
    let life     = 42             (* integer *)
    let pi       = 3.14159        (* real    *)
    let yes      = true           (* boolean *)
    let grade    = 'A'            (* glyph   *)
    let greeting = "Hello world!" (* string  *)
end
```
Variables in Halcyon are immutable, meaning they cannot be changed once they are created (like const in C). This is not as restrictive as it sounds; once you are comfortable writing code in a functional style, you will not miss mutable variables.

## Tuples
You may already be familiar with tuples from Python. A tuple is an ordered list that can contain any number of items of different types. Because there is only one possible tuple with nothing in it, we give it a special name: unit.
```halcyon
module TupleExample =
    let grocery_tuple = ("eggs", "bacon", "milk")
    (* type : string * string * string *)
    let many_typed_tuple = ("Hello", 15, 2.0, false)
    (* type : string * integer * real * boolean *)
    let nested_tuple = (0, (1, (2, (3, (4, 5)))))
    (* type : integer * (integer * ...) *)
end
```
Tuples are sometimes referred to as 'product types' and they belong to a special family called 'algebraic data types'. To understand why that is, lets consider the tuple (boolean, boolean). How many possible tuples are there with this type? The first item in the tuple has two possible values, as does the second - therefore the total number of possibilities is 2×2=4. For this reason, the type of this tuple is written as boolean * boolean.

## Operators
Halcyon has all of the operators you would expect, with a few caveats. Here is the full list, in order of their precedence:

- unary - and -. (arithmetic negation)
- unary not (logical negation)
- \* and *. (multiplication)
- / and /. (division)
- % (modulus)
- \+ and +. (addition)
- \- and -. (subtraction)
- xor (logical XOR)
- or (logical OR)
- |> (function composition)
- ==, !=, <=, >=, < > (comparison)
- and (logical AND)
- ;
There are a couple standouts in this list, firstly +. -. *. /.. These operators only work on reals, while + - * / % only work on integers. This is a tradeoff to make the type system simpler and type inference more effective. The ; operator simply discards whatever value is to the left of it. This is useful for chaining together function calls when you don't care about their return values, like the print function. Function composition |> will be covered later.
```halcyon
module OperatorExamples =
    let num_int = -5 + 6 / 3 * 10 % 3
    let num_real = -.5.0 +. 6.0 /. 3.0 *. 10.0
    let conditional = true and false xor true or false
    let equal = "Hello" != "World"
    let one = (); (); (); (); 1
end
```
## Functions
Because Halcyon is a functional language, the way it handles functions and function calls is much different from other languages. Lets write a function which takes two integers a and b, and returns their sum:
```halcyon
module FunctionExample = 
    let sum = fn a b => a + b
end
```
The syntax for defining a function is 'fn <p1> <p2> ... => <body>'. Again, we do not need to write the type of a and b, or the return type of sum, as they are all inferred by the compiler. The body of a function is just a single expression, and so there is no need for a return keyword. Functions are just ordinary values like integers and booleans, and so we can assign them to a variable using the let keyword. Lets try calling sum:
```halcyon
module FunctionExample = 
    let sum = fn a b => a + b
    let five = sum 3 2
end
```
Unlike in calling functions in other languages, you do not need to use parenthesis or to separate function arguments with commas. This syntax has the advantage of being very minimal and 'clean', but comes with a few gotchas. Here are a few ways NOT to call a function:
```halcyon
module FunctionExample = 
    let sum = fn a b => a + b

    let five = sum(3 2) 
    (* Parsed as `sum(3(2))` which is 
     * wrong because `3` is not a function! *)

    let five = sum(3, 2) 
    (* The syntax (a, b, ..) creates a tuple,
     * not what we want! *)

    let five = sum 1 + 1 3
    (* Parsed as `sum(1) + 1(3)` because function
     * calls have a higher precedence than the `+`
     * operator. 
     * You really want to do `sum (1 + 1) 3` here. *)
end
```
## Currying
Every function in Halcyon has exactly one parameter. But wait a second, didn't the function sum we just wrote have two parameters? Behind the scenes, the compiler uses a technique called 'currying' to convert the functions we write with any number of parameters into functions with just a single parameter. To understand how this works and why its useful, lets try calling our function sum with just one parameter:
```halcyon
module FunctionExample = 
    let sum = fn a b => a + b

    let add1 = sum 1
end
```
This code successfully compiles, even though we only provided one of the functions two parameters. The variable add1 is a new function that "remembers" the first parameter it was given. Lets try using this new function:
```halcyon
module FunctionExample = 
    let sum = fn a b => a + b
    let add1 = sum 1

    let _ = add1 4
    (* Produces 5 *)

    let _ = add1 7
    (* Produces 8 *)

    let _ = add1 (-10)
    (* Produces -9 *)
end
```
The syntax for writing function types is parameter_type -> return_type, where -> associates to the right. The type of the function sum is:
```
integer -> integer -> integer
(* which is the same as *)
integer -> (integer -> integer)
```
While the type of add1 is:
```
integer -> integer
```
Why is currying useful? Functional programming is all about the composition of functions. Composing functions means taking the output of one function, and feeding it into the input of another function. When every function has only one parameter, composition becomes much simpler.

## Function composition
This brings us to the function composition operator |>. This operator simply calls a function, but with the parameter on the left side and the function on the right side. Note that |> has a lower precedence than a normal function call. Lets see how we can combine currying and |>:
```halcyon
module FunctionExample = 
    let sum = fn a b => a + b
    let better_sum = 0
        |> sum 1
        |> sum 2
        |> sum 3
        |> sum 4
        |> sum 5

    (* Heres what we would have to write without |> *)

    let worse_sum = sum 5 (sum 4 (sum 3 (sum 2 (sum 1 0))))
end
```
Here, better_sum and worse_sum both add the numbers 0 through 5, but one is much easier to read and write than the other. When we have many nested function calls like in worse_sum, the code actually reads right to left because the inner-most calls happen first. Using currying and the |> operator, we can compose many functions together without the need for lots of parenthesis, or writing code 'inside out'. Try thinking of |> as "and then" in your head.

## Control flow and pattern matching
Halcyon has if and else, but here they are expressions rather than statements. This means they produce a value, and can be used as part of larger expressions. Here is a function that divides two numbers if the second is not 0, otherwise returning 0:
```halcyon
module Demo =
    let safe_divide = fn numerator denominator =>
        if denominator != 0 then
            numerator / denominator
        else
            0
    
    let test1 = safe_divide 10 5 
    (* Produces 2 *)
    let test2 = safe_divide 1 0 
    (* Produces 0 *)
end
```
The second way to do branching is with match, similar to switch in other languages. Like if, match is an expression that produces a value. The match expression compares a value (called the discriminant) with some patterns. The branch of the first pattern that is matched (from top to bottom) will be taken.

Let expressions can also contain patterns, but only if the pattern is 'irrefutable', or always matched for any member of the type.
```halcyon
module MatchDemo =
    let string_match = match "Hello World" with
        | "foobar" => 0
        | "barfoo" => 1
        | "Hello World" => 2 (* Matches! *)
    (* string_match == 2 *)

    let tuple_match = match (1, 2) with
        | (3, 4) => 34
        | (4, _) => 40
        (* matches when first item is 4, second item is any number *)
        | (9, num) => 90 + num
        (* matches when first item is 9,
         * second item is any. Creates a
         * variable `num` and assigns second
         * item to it.
        *)
        | (_, _) => 0
        (* matches any two-tuple *)
    (* tuple_match ==  0 *)

    let (big_num, no) = (999, false)
    (* 'unpacking' a tuple using pattern matching *)

    let int_match = match big_num with
        | 0 => "zero"
        | 1 => "one"
        | 2 => "two"
        | _ => "really big"
        (* `_` and identifiers are wildcards, match any value *)
        | 999 => "impossible"
        (* 
         * This also matches, but higher patterns
         * take priority
         *)
    (* int_match == "really big" *)

    let no_match = match 3.14159 with
        | 0.0 => false
        | 1.0 => true
    (* When no match is found, crash the program *)
end
```
## Importing modules
With that introduction to syntax and basic functional programming done, lets start actually putting things on the screen. To do this we will need to import the std module (short for 'standard'):
```halcyon
module Demo =
    import std
    let () = std:print_string "Hello World"
    (* std:print_string returns unit, and
     * this pattern lets us match it without
     * needing to create a named variable.
     * let () = ... is a very common pattern. *)
end
```
We finally have our Hello World program! I didn't make this the first example because then I would have to hand-wave away the let () and function call syntax. Now you have all the prerequisite knowledge to (hopefully) understand everything going on here!

The std module contains the primitive types, and a few helper functions:

- std:print_string : string -> unit
    - Prints a string to the screen
- std:panic : unit -> '0
    - Crash the program intentionally. We will discuss '0 more later, but for now know it stands for a non-existent type, because this function will never actually return
- std:assert : boolean -> unit
    - Crash the program if the parameter is false, otherwise do nothing and return unit
```halcyon
module StdDemo =
    import std
    let () = "Hello World" |> std:print_string
    let () = std:assert (1 + 1 == 2)
    let one = if true then 1 else std:panic ()
    (* Here, it looks like the branches of this if expression
     * have different types, `integer` vs `'0`, this usually is not
     * allowed. However, because `std:panic` never actually returns,
     * this is allowed. `std:panic` is the only function who's return
     * type can be coerced into any other type this way.
    *)
end
```
## Sum types
As we start to build more complicated types, we need to start giving them names. The type keyword works the same as let, but for declaring new types
```halcyon
module TypeAliasDemo =
    import std
    type MyInt = std:integer
    type MyReal = std:real
     (* We can give new names to the primitive types
      * in the std module *)
    type MyThreeIntegers = MyInt * MyInt * MyInt
end
```
We can now declare our first sum type. As you might have guessed, sum types are the second kind of algebraic data type. You can think of sum types as OR types, they can be one type OR another type.
```halcyon
module SumTypeDemo =
    import std
    type MaybeString = Some of std:string | None of std:unit
    (* This sum type has two variants, Some and None.
     * When we create a sum type, the compiler automatically
     * generates constructor functions with the same name as
     * the variants. *)
    
    let SomeString = Some "Hello!"  (* type : MaybeString *)
    let NotAString = None () (* type : MaybeString *)

    let maybe_print = fn maybe => match maybe with
        | Some of s => std:print_string s
        | None of () => std:print_string "Didn't find anything..."
    (* Just like tuples, we can deconstruct sum types with
     * pattern matching. *)
    (* type : MaybeString -> std:unit *)

    let () = maybe_print SomeString
    let () = maybe_print NotAString

    type Class = Knight of std:unit 
        | Rogue of std:unit 
        | Priest of std:unit
    (* Sum types also work great as a replacement for enums *)

    let class_greeting = fn class => match class with
        | Knight of () => std:print_string "I am a knight"
        | Rogue of () => std:print_string "I am a rogue"
        | Priest of () => std:print_string "I am a priest"
    (* type : Class -> std:unit *)

    let () = class_greeting (Knight ())
    let () = class_greeting (Rogue ())
    let () = class_greeting (Priest ())
end
```
The MaybeString example shows how sum types can be used as a safer alternative to C or Java's null pointers for when a value might not exist. The Class example shows how sum types can also work as a more extensive enum type, which may optionally have data attached to any of its variants. Sum types are a very useful tool; with this one feature, we can accomplish what other languages need many features to do.

Sum types are one of the few types allowed to be recursive. Lets see how we can implement a linked list using sum types:
```halcyon
module LinkedListDemo =
    import std
    type StringList = Pair of std:string * StringList 
        | Nil of std:unit

    let push = fn item list => match list with
        | Pair of (head, tail) => Pair (head, push item tail)
        | Nil of () => Pair (item, Nil ())
    (* type : std:string -> StringList -> StringList *)
    
    let strings = Nil ()
        |> push "one"
        |> push "two"
        |> push "three"
        |> push "four"
    (* type : StringList *)
    
    let print_string_list = fn list => match list with
        | Pair of (head, tail) => 
            std:print_string head; 
            print_string_list tail
        | Nil of () => ()
    (* type : StringList -> std:unit *)

    let () = print_string_list strings
end
```
## Polymorphic functions
I said before that the compiler will infer the type of your variables and functions from context. What type do you think the function below will have?
```halcyon
let identity = fn a => a
(* type : ? -> ? *)
```
This function simply returns the parameter it is given. You can try replacing the ? here with any type, and they will all work. So how does the compiler pick one? The answer is that it doesn't. The type of this function is:
```
'0 -> '0
```
You might remember that '0 is the return type of std:panic. It is known as a type variable, and can refer to any type. But why use a number? Lets look at another example:
```halcyon
let first = fn a b => a
(* type : '0 -> '1 -> '0 *)

let second = fn a b => b
(* type : '0 -> '1 -> '1 *)
```
The functions first and second both take two parameters, and return the first or second parameter respectively. Importantly, there is nothing saying that the first and second parameter must be the same type. Even though a and b can be conceivably any type, it is important to keep track of which types must be the same.
```halcyon
module PolyDemo =
    let identity = fn a => a

    let i = identity 1
    let g = identity 'a'
    let b = identity true

    let first = fn a b => a
    let one = first 1 false
    let yes = first true "Hello World"
end
```
## Polymorphic types
In the section on sum types, we created the types MaybeString and StringList. But what if we also wanted a IntegerList or RealList? It wouldn't be practical to write a list type and list functions for every type. Lets use type variables again, but this time inside of a type definition:

The syntax for this is experimental and significantly different from how similar languages accomplish this, so bare with me.
```halcyon
module ListDemo =
    import std
    type LinkedList = fn T =>
        Pair of T * LinkedList | Nil of std:unit
    
    let push = fn item list => match list with
        | Pair of (head, tail) => Pair (head, push item tail)
        | Nil of () => Pair (item, Nil ())
    (* Exactly the same as our first StringList push function,
     * except now it works for lists of any type *)
    (* type : '0 (LinkedList '0) -> (LinkedList '0)  *)

    let string_list = Nil ()
        |> push "Hello "
        |> push "World"
    (* type : (LinkedList std:string) *)

    let int_list = Nil ()
        |> push 1
        |> push 2
    (* type : (LinkedList std:integer) *)
        
    let print_string_list = fn list => match list with
        | Pair of (head, tail) => 
            std:print_string head; 
            print_string_list tail
        | Nil of () => ()
    (* We can still define functions that only works on
     * specific types of lists *)
    (* type : (LinkedList std:string) -> std:unit *)

    let () = print_string_list string_list

    (* This would be a type error: *)
    (* let () = print_string_list int_list *)
end
```
## Standard collections
The standard library provides an implementation of the list and maybe types in the list and opt (short for optional) modules respectively. 

- [std](../docs/modules/std.md)
- [list](../docs/modules/list.md)
- [opt](../docs/modules/opt.md)

