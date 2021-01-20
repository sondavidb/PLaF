open Ast
open Ds

(** [eval_expr e] evaluates expression [e] *)
let rec eval_expr : expr -> int result =
  fun e ->
  match e with
  | Int n      -> Ok n
  | Add(e1,e2) ->
    (match eval_expr e1 with
     | Error s -> Error s
     | Ok m -> (match eval_expr e2 with
                | Error s -> Error s
                | Ok n -> Ok (m+n)))
  | Sub(e1,e2) ->
    (match eval_expr e1 with
     | Error s -> Error s
     | Ok m -> (match eval_expr e2 with
                | Error s -> Error s
                | Ok n -> Ok (m-n)))
  | Mul(e1,e2) ->
    (match eval_expr e1 with
     | Error s -> Error s
     | Ok m -> (match eval_expr e2 with
                | Error s -> Error s
                | Ok n -> Ok (m*n)))
  | Div(e1,e2) ->
    (match eval_expr e1 with
     | Error s -> Error s
     | Ok m -> (match eval_expr e2 with
                | Error s -> Error s
                | Ok n -> if n==0 
                          then Error "Division by zero" 
                          else Ok (m/n)))
  | _ -> Error "Not implemented yet!"


(** [parse s] parses string [s] into an ast *)
let parse (s:string) : expr =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast


(** [interp s] parses [s] and then evaluates it *)
let interp (e:string) : int result =
  e |> parse |> eval_expr
  

