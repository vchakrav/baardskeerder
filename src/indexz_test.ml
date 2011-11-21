(*
 * This file is part of Baardskeerder.
 *
 * Copyright (C) 2011 Incubaid BVBA
 *
 * Baardskeerder is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Baardskeerder is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Baardskeerder.  If not, see <http://www.gnu.org/licenses/>.
 *)

open Indexz
open OUnit
open Pos

let assert_balanced z = 
  let m = Printf.sprintf "not balanced: %s" (iz2s z) in
  match z with
  | Loc ((_,l),r) -> 
    let ls = List.length l in
    let rs = List.length r in
    let b = (ls = rs + 1) in
    OUnit.assert_bool m b
  | Top _ -> OUnit.assert_bool m false

let t_balance() =
  let d = 2 in
  let z = Loc ((out 7,["q", out 22; "j", out 21; "d", out 14]),[]) in
  let z' = Indexz.balance d z in
  assert_balanced z'


let t_balance2 () =
  let d = 2 in
  let z = Top (out 0,["d", out 1; "j", out 2; "q", out 3]) in
  let z' = Indexz.balance d z in
  assert_balanced z'

let t_balance3 () =
  let d = 3 in
  let z = Top (out 0,["d", out 1; 
		      "j", out 2; 
		      "q", out 3; 
		      "t", out 4; 
		      "w", out 5]) 
  in
  let z' = Indexz.balance d z in
  assert_balanced z'

let t_balance4() =
  let d = 3 in
  let z = Loc ((out 16,["key_93", out 43; 
			"key_90", out 56; 
			"key_87", out 69; 
			"key_102", out 68]),
	       ["key_96",out 30]) in
  let z' = Indexz.balance d z in
  assert_balanced z'

let t_balance5() = 
  let d = 3 in
  let z = Loc
    ((out 74, [("key_63", out 271); 
	       ("key_109", out 270)]),
     [("key_72", out 222); 
      ("key_81", out 173); 
      ("key_90", out 124)]) in
  let z' = Indexz.balance d z in
  assert_balanced z'
    
let suite = "Indexz" >::: [
  "balance"    >:: t_balance;
  "balance2"   >:: t_balance2;
  "balance3"   >:: t_balance3;
  "balance4"   >:: t_balance4;
  "balance5"   >:: t_balance5;
]
