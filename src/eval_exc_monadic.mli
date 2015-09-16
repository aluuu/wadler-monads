module Exc : sig
  type 'a t = Raise of string | Return of 'a
  include Monad.S with type 'a t := 'a t
end

val eval : Eval.term -> int Exc.t
