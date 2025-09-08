# btree
`btree` is a type that represents a binary tree.
Every btree is either a Node that contains a value and two children (Node or Nil), or it is Nil and contans no values.
```halcyon
type t = fn I => Node of I * (t I) * (t I) | Nil of std::unit
```
## Functions
---
### Nil: `std::unit -> (btree '0)`
The constructor for a Nil btree.
This is used to represent an empty child.
#### Example
```halcyon
let my_empty_tree = btree::Nil()
```
---
### Node: `'0 * btree '0 * btree '0 -> btree '0`
The constructor for a Node btree.
#### Example
```halcyon
let my_tree = btree:Node (1, btree::Nil(), btree::Nil())
(* my_tree ==  1
              / \
            nil nil
*)
```
---
### insert: `'0 -> ('0 -> '0 -> std::boolean) -> (btree '0) -> (btree '0)`
Returns a copy of the passed tree with the passed value inserted according to the passed operation.
#### Notes
`insert` checks if the function is true with the passed value and the current tree value, if it is, it will attempt to insert the passed value as the left child. Otherwise, it will attempt to insert the passed value as the right child. This process is repeateded recursively until a `Node` has a `Nil` child in the appropriate position.
#### Example
```halcyon
let my_tree = btree:Node (5, btree::Nil(), btree::Nil())
let my_new_tree = btree:insert 2 (fn a b => a < b) my_tree
(* my_new_tree == 5
*                / \
*               2  
*)
let my_newer_tree = btree:insert 7 (fn a b => a < b) my_new_tree
(* my_newer_tree == 5
*                  / \
*                 2   7 
*                / \ / \ 
*)
let my_newest_tree = btree:insert 9 (fn a b => a < b) my_newer_tree
(* my_newest_tree == 5
*                   / \
*                  2   7 
*                 / \ / \
*                        9
*)
```
---
### iterate_tree_df: `('0 -> std::unit) -> (btree '0) -> std::unit`
Runs the passed function on each element in the tree depth-first, then returns unit.
#### Example
```halcyon
let lt = fn a b => a < b  
let my_tree = btree::Nil () |> 5 lt |> 2 lt |> 7 lt |> 8 lt |> 3 lt |> 1 lt
let () = btree::iterate_tree_df (fn a => string:from_int |> std:print_string) my_tree
(* my_tree == 5
*            / \
*           2   7 
*          / \ / \
*         1  3    8 
*)
(* prints 123578 *)

```
---
### iterate_tree_bf: `('0 -> std:unit) -> (btree '0) -> std:unit`
Runs the passed function on each element in the tree breadth-first, then returns unit.
#### Example
```halcyon
let lt = fn a b => a < b  
let my_tree = btree::Nil () |> 5 lt |> 2 lt |> 7 lt |> 8 lt |> 3 lt |> 1 lt
let () = btree::iterate_tree_bf (fn a => string::from_int |> std::print_string) my_tree
(* my_tree == 5
*            / \
*           2   7 
*          / \ / \
*         1  3    8 
*)
(* prints 521378 *)
```
---
### map_tree: `('0 -> '1) -> (btree '0) -> (btree '1)`
Returns a copy of the passed tree with the passed function applied to each element.
#### Examples
```halcyon
let lt = fn a b => a < b  
let my_tree = btree::Nil () |> 5 lt |> 2 lt |> 7 lt |> 8 lt |> 3 lt |> 1 lt
(* my_tree == 5
*            / \
*           2   7 
*         / \ / \
*        1  3    8 
*)
let my_mapped_tree = btree:map_tree (fn a => a * 2) my_tree
(* my_mapped_tree == 10
*                    / \
*                   4   14 
*                  / \ / \
*                 2  6    16 
*)
```
