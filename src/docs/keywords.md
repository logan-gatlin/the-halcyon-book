# Keywords
---
## module, end   
All halcyon programs must be wrapped in a module by using `module [name] =`.
All modules, and therefore halcyon programs, must end with `end`.
Module declarations can be broken up into multiple sections.
### Example 
```halcyon
module demo =
    let my_list = list::Nil () (* access specific modules using '::' *)
end
module demo = 
    let my_other_list = demo::my_list |> list::push 5
end
module demo2 = 
    let list1 = demo::my_list
    let list2 = demo::my_other_list
    (* list1 == nil *)
    (* list2 == 5 > nil *)
end
```
---
## import 
---
## let  
`let` is used to declare constants and functions.
### Notes
Let expressions can contain patterns, but only if the pattern is 'irrefutable', or always matched for any member of the type.
### Example
```halcyon
let my_constant = 2
let my_function = fn a => a + 1
let my_new_constant = my_function 2
```
---
## if, then, else  
`if`, `then`, and `else` are used for conditional statements.
In Halcyon, `if` and `else` are expressions, since they produce a value.
### Example
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
---
## match, with  
`match` and `with` are used for pattern matching, which compares a value (called the discriminant) with one or more patterns. 
### Notes
The branch of the first pattern that is matched (from top to bottom) will be taken.
While pattern matching, underscores `_` and identifiers match any value.
`with` can be used without an accompanying `match` when declaring a function with a single parameter.
Doing so adds an implicit extra parameter to the function, which gets matched in the match expression.
### Example
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

    let function = fn with 
    | true => string::print "Yep!"
    | false => string::print "Nope!"
    (* single parameter function using with *)
end
```
---
## fn
`fn` is used to declare functions.
### Notes
Since the halcyon compiler uses currying to reduce functions to a single parameter, functions like `add1` in the following example can be created and used.
### Example
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
---
## type
`type` is used to declare new types. 
Types can be aliases for other types or sum types.
### Notes
Types can optionally have no data attached, which essentially recreates the behavior and use cases of an enum.
### Example 1
```halcyon
module TypeAliasDemo =
    (* aliases *)
    import std
    type MyInt = std::integer
    type MyReal = std::real
     (* We can give new names to the primitive types
      * in the std module *)
    type MyThreeIntegers = MyInt * MyInt * MyInt

    (* sum type *)
    type Class = Knight of std:unit | Rogue of std:unit | Priest of std:unit
    (* the same sum type with no data *)
    type BetterClass = Knight | Rogue | Priest
    (* parametric sum type *)
    type list = fn I => Pair of I * (list I) | Nil of std:unit
    
end
```
---
## of
`of` is a keyword used to denote the type(s) that a constructor name contains.
It is used when declaring new types to specify what a constructor is composed of, as in Example 1.
`of` is also used when pattern matching to deconstruct types based on what they are composed of, as in Example 2. 
### Example 1
```halcyon
type list = fn I => Pair of I * (list I) | Nil of std::unit
```
### Example 2
```halcyon
let print_list_item = fn list => match list with
    | Pair of (head, tail) => string::print head (* the head constructor contains an I and a t I, 'of' lets us access the I *)
    | Nil of () -> () (* do nothing *)
```
---
## in 
`in` is a scope modifier keyword used in the body of function declarations. 
It is used when you need to declare a local constant or function that you only need to access within another function.
Example 1 shows `in` being used in the string module to declare a local function.
Example 2 shows `in` being used to declare multiple constants by chaining `in` statements together.
### Example 1
```halcyon
let from_integer = 
    fn x => 
      let digit_to_string = fn x => match x with (* <-- local function declared within from_integer *)
        | 0 => "0"
        | 1 => "1"
        | 2 => "2"
        | 3 => "3"
        | 4 => "4"
        | 5 => "5"
        | 6 => "6"
        | 7 => "7"
        | 8 => "8"
        | 9 => "9"
        | _ => "?"
      in    (* <-- in *)
    match x with
      | 0 => ""
      | x => (x % 10)
        |> digit_to_string  (* <-- previously declared local function being used *)
        |> let a = from_integer (x / 10) in
          string::concatenate a

let thing = digit_to_string 5 (* this is a compile error: out of scope *)
```
### Example 2
```halcyon
 let quicksort = fn op list => match (list::length list) with
  | 0 => list::Nil ()
  | 1 => list
  | length =>
    let pivot = (list::nth length/2 list |> opt::unwrap) in
    match partition (op pivot) list with
    | (a,b) => 
      let middle = filter (fn operand => operand == pivot) b in (* in 1 *)
      let right = filter (fn operand => operand != pivot) b in (* in 2 *)
      quicksort op right |> list::concatenate middle |> list::concatenate (quicksort op a) (* using local constants *)
```
---