(* File interp.ml *)
type id = string (* 構文木の型 *)
type op = Plus | Minus | Times | Div
type stm = Stmts of stm * stm
    | Assign of id * exp
    | Print of exp
and exp = ID of id
    | Num of int
    | Plus of exp * exp
    | Minus of exp * exp
    | Times of exp * exp
    | Div of exp * exp

(* 環境 *)
exception No_such_symbol 
let e0 = fun _ -> raise No_such_symbol
let update var vl env = fun v -> if v = var then vl else env v

(* 意味関数 *)
let rec trans_stmt ast env = 
    match ast with
        Stmts (s1,s2) -> let env' = trans_stmt s1 env in trans_stmt s2 env'
        | Assign (var,e) -> let vl = trans_exp e env in update var vl env
        | Print e -> let vl = trans_exp e env in (print_int vl; print_string "\n"; env)
and trans_exp ast env = 
    match ast with 
        ID v -> env v
        | Num n -> n
        | Plus (e1,e2) -> let vl1 = trans_exp e1 env in let vl2 = trans_exp e2 env in vl1 + vl2
        | Minus (e1,e2) -> let vl1 = trans_exp e1 env in let vl2 = trans_exp e2 env in vl1 - vl2
        | Times (e1,e2) -> let vl1 = trans_exp e1 env in let vl2 = trans_exp e2 env in vl1 * vl2
        | Div (e1,e2) -> let vl1 = trans_exp e1 env in let vl2 = trans_exp e2 env in vl1 / vl2

let prog = Stmts (Assign ("x",Plus (Num 1,Times (Num 2,Num 3))),
                  Stmts (Assign ("y",Div (ID "x",Num 4)), 
                         Print (ID "y")))

let interp ast = trans_stmt ast e0

let rec stmt_to_string ast = 
    match ast with
    | Stmts (s1,s2) -> "Stmts (" ^ stmt_to_string s1 ^ ", " ^ stmt_to_string s2 ^ ")"
    | Assign (var,e) -> "Assign (" ^ var ^ ", " ^ exp_to_string e ^ ")"
    | Print e -> "Print (" ^ exp_to_string e ^ ")"
and exp_to_string e =
    match e with
    | ID v -> "ID " ^ v 
    | Num n -> "Num " ^ string_of_int n
    | Plus (e1, e2) -> "Plus (" ^ exp_to_string e1 ^ ", " ^ exp_to_string e2 ^ ")"
    | Minus (e1, e2) -> "Minus (" ^ exp_to_string e1 ^ ", " ^ exp_to_string e2 ^ ")"
    | Times (e1, e2) -> "Times (" ^ exp_to_string e1 ^ ", " ^ exp_to_string e2 ^ ")"
    | Div (e1, e2) -> "Div (" ^ exp_to_string e1 ^ ", " ^ exp_to_string e2 ^ ")"

let print_ast ast = print_string (stmt_to_string ast)