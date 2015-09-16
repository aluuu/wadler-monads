type 'a exc_computation = Raise of string | Return of 'a

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
