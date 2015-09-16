type term = Con of int | Div of (term * term)

val eval : term -> int
