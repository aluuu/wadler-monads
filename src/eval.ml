type term = Con of int | Div of (term * term)

let rec eval = function
  | Con a -> a
  | Div (t, u) -> eval t / eval u
