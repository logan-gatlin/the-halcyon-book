# list
list is a type used to represent a linked list data structure.
Every list is either Pair and contains two values (head, tail) or is Nil, and contains no values
```halcyon
type t = fn I => Pair of I * (t I) | Nil of std:unit
```
## Functions
### Nil: `std:unit -> (list:t '0)`
The constructor for an empty list item.
This should only be located at the end of a list.
#### Example
```halcyon
let my_empty_list = Nil ()
```
### Pair: `('0 * (list:t '0)) -> (list:t '0)`
The constructor for a non-empty list item
#### Example
```halcyon
let my_list = list:Pair ("item", list:Nil ())
```
### push: `'0 -> (list '0) -> (list '0)`
Creates a copy of the passed list with the passed element appended to the end.
#### Example
```halcyon
let my_list = list:Nil ()
(* my_list: Nil *)
let my_new_list = list:push "item" my_list 
(* my_new_list: "item" > Nil *)
```
### iterate: `('0 -> std:unit) -> (list '0) -> std:unit`
Runs the passed operation on each element of the passed list, but doesn't create or return a new one.
#### Example
```halcyon
let my_list = list:Nil () |> list:push "Hello" |> list:push " World!"
let () = list:iterate std:print_string my_list
(* prints "Hello World!" *)
```
### map: `('0 -> '1) -> (list '0) -> (list '1)`
Creates and returns a new list by applying the passed operation to each element in the passed list.
#### Example
```halcyon
let my_list = list:Nil () |> list:push 3 |> list:push 4 
(* my_list: 3 > 4 > Nil *)
let my_mapped_list = list:map (fn a => a * 2) my_list
(* my_mapped_list: 6 > 8 > Nil *)
```
### length: `(list '0) -> std:integer`
Returns the length of the passed list.
#### Example
```halcyon
let length = list:Nil () |> list:push 0 |> list:push 1 |> list:length
let () = string:from_int length |> std:print_string
(* prints 2 *)
```
### nth: `std:integer -> (list '0) -> '0`
Returns the value of the passed list item at the position of the passed index.
#### Example
```halcyon
let my_list = list:Nil ()|> list:push "one" |> list:push "two" |> list:push "three"
let () = list:nth 2 my_list |> std:print_string
(* prints "two" *)
```
### concatenate: `(list '0) -> (list '0) -> (list '0)`
Adds the second passed list to the end of the first passed list.
#### Example
```halcyon
let my_list = list:Nil ()|> list:push "one" |> list:push "two" 
let my_second_list = list:Nil ()|> list:push "three" |> list:push "four" 
let my_final_list = list:concatenate my_list my_second_list
(* my_list: "one" > "two" > Nil *)
(* my_second_list: "three" > "four" > Nil *)
(* my_final_list: "one" > "two" > "three" > "four" > Nil*)
```
### fold: `('0 -> '1 -> '0) -> '0 -> (list:t '1) -> '0`
Reduces the passed list to a single element using the passed function.
#### Example
```halcyon
let my_list = list:Nil () |> list:push 1 |> list:push 2 |> list:push 3
let () = list:fold (fn a b => if a < b then a else b) 10 my_list |> string:from_integer |> std:print_string
(* prints 1 *)
```
