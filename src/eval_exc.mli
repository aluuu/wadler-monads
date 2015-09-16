type 'a exc_computation = Raise of string | Return of 'a

val eval : Eval.term -> int exc_computation
