let run_eval () =
  let open Eval in
  let res1 () = eval (Div (Con 20, Con 2)) in
  let res2 () = eval (Div (Con 20, Con 0)) in
  Printf.printf "Eval result = %d \n" (res1 ());
  Printf.printf "Eval result = %d \n" (res2 ());
  flush stdout

let run_eval_exc () =
  let open Eval in
  let open Eval_exc in
  let res1 = eval (Div (Con 20, Con 2)) in
  let res2 = eval (Div (Con 20, Con 0)) in
  let output = function
    | Return a -> Printf.printf "Eval result = %d \n" a;
    | Raise e -> Printf.printf "Eval failed with '%s'\n" e in
  output res1;
  output res2;
  flush stdout

let run_eval_exc_monadic () =
  let open Eval in
  let open Eval_exc_monadic in
  let res1 = eval (Div (Con 20, Con 2)) in
  let res2 = eval (Div (Con 20, Con 0)) in
  let output = function
    | Exc.Return a -> Printf.printf "Eval result = %d \n" a;
    | Exc.Raise e -> Printf.printf "Eval failed with '%s'\n" e in
  output res1;
  output res2;
  flush stdout

let () =
  ignore(run_eval_exc_monadic ());
  ignore(run_eval_exc ());
  ignore(run_eval())
