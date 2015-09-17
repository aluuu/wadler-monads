module Eval = struct
  type term = Con of int | Div of (term * term)

  let rec eval = function
    | Con a -> a
    | Div (t, u) -> eval t / eval u
end


module Naive_exception = struct
  type 'a t = Raise of string | Return of 'a

  let rec eval = function
    | Eval.Con a -> Return a
    | Eval.Div (t, u) ->
      match eval t with
      | Raise e -> Raise e
      | Return a -> match eval u with
        | Raise e -> Raise e
        | Return b -> match b with
          | 0 -> Raise "Zero devision error"
          | _ -> Return (a / b)
end


module Exception = struct
  type 'a t = Raise of string | Return of 'a

  let unit x = Return x

  let bind m f = match m with
    | Raise exc -> Raise exc
    | Return x -> f x

  let raise' e = Raise e

  let rec eval term =
    match term with
    | Eval.Con a -> unit a
    | Eval.Div (t, u) ->
      bind (eval u) (fun u' ->
          bind (eval t) (fun t' ->
              match u' with
              | 0 -> raise' "Zero division error"
              | _ -> unit (t' / u')))
end

let run () =
  let term = Eval.(Div (Con 20, Con 0)) in
  let monadic_result () = Exception.eval term in
  let naive_result () = Naive_exception.eval term in
  let raw_result () = Eval.eval term in
  (match monadic_result () with
    | Exception.Return a -> Printf.printf "Eval result = %d \n" a;
    | Exception.Raise e -> Printf.printf "Eval failed with '%s'\n" e);
  (match naive_result () with
   | Naive_exception.Return a ->
     Printf.printf "Eval result = %d \n" a;
   | Naive_exception.Raise e ->
     Printf.printf "Eval failed with '%s'\n" e);
  Printf.printf "Eval result = %d \n" (raw_result ());
