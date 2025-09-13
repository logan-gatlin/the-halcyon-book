# Advanced types
Some types must be explicitly defined and given a name before they may be used.

## Structures
A structure is like a tuple with named values.
It is similar to a struct or class in other languages.
Unlike primitive types, identical structures with different names *not* the same type.
Structures are defined using `type` statements:
```halcyon
type Vector2 = { x : std::real, y : std::real }

let origin : Vector2 = {
  x = 0.0,
  y = 0.0,
}
let x = origin.x
let y = origin.y
```

```admonish note
In rare cases, type inference for structures may fail.
This is because some structures may be exactly the same except for their name.
For this reason, it is best practice to write type annotations for structures.
```

## Sum types
Sum types are similar to enums in other languages.
```halcyon
type Class = Knight | Mage | Rogue

let class_greeting = fn class => std::println
  (match class with
    | Knight => "I am a knight"
    | Mage => "I am a mage"
    | Rogue => "I am a rogue")

do
  class_greeting Knight;
  class_greeting Mage;
  class_greeting Rogue
```

A sum type may contain data attached to one of its variants.
Imagine you are writing a function `safe_divide` that checks if the denominator is zero.
Using sum types, we can show that this function may fail to return a number:
```halcyon
type Result = Ok of std::real | DivisionError

let safe_divide = fn numerator denominator =>
  match denominator with
    | 0 => DivisionError
    | _ => Ok (numerator /. denominator)
```
The `Result` type defines two constructors, `Ok` and `DivisionError`.
Because `DivisionError` contains no data, it is actually just a constant with the type `Result`.
The `Ok` constructor does contain data, so it is a function with the type `real -> Result`.
Sum types are extremely flexible; Halcyon uses them as a substitute for null pointers, exceptions, and sub-types.
```admonish
A result type already exists in the standard library `result` module, including lots of useful functions for working with results.
See also: the `opt` module
```

## Implicit Polymorphism
We discussed earlier that Halcyon has full type inference.
What do you think the type of this function will be inferred to be?
```halcyon
let identity (* ? -> ? *) = fn a => a
```
The function `identity` simply returns whatever its parameter is.
There are no context clues forcing `a` to be any type in particular, and so `identity` is implicitly polymorphic.
In simple terms, this means that its argument may be any type:
```halcyon
do
  identity 1;
  identity false;
  identity "foo"
```
The exact type of `identity` is `'0 -> '0`, where `'0` is a *type variable*.
Type variables are a placeholder type that gets replaced when a function is actually called.
A functions type may have any number of type variables.
```halcyon
let first = fn a b => a
let second = fn a b => b

do std::println (first "foo" 2)
do std::println (second false "bar")
```
Here, `first` has the type `'0 -> '1 -> '0`, while `second` has the type `'0 -> '1 -> '1`.

## Explicit Polymorphism
Types can contain type variables just like functions.
Polymorphic types are called *type functions*, and follow slightly different rules from regular types.

The standard library defines the `opt` type, similar to the `Result` type above except that it can contain any type, not just `real`.
Let's see how it is implemented:
```halcyon
module opt = 
  type t = fn a => Some of a | None
end
```
Here, `opt`, is not a type per se, but rather a function that returns a type.
The parameters to a type function (in this case `a`) are other types.
When you use a polymorphic type, the compiler will infer the correct type parameter for you.
```halcyon
let safe_divide = fn numerator denominator =>
  match denominator with
    | 0 => opt::None
    | _ => opt::Some (numerator / denominator)
(* safe_divide : integer -> (opt::t integer) *)
```

