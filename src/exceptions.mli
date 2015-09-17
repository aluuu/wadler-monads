module Eval : sig
  type term = Con of int | Div of (term * term)
  val eval : term -> int
end

module Naive_exception : sig
  type 'a t = Raise of string | Return of 'a
  val eval : Eval.term -> int t
end

module Exception : sig
  type 'a t = Raise of string | Return of 'a
  include Monad.S with type 'a t := 'a t

  val raise' : string -> 'a t
  val eval : Eval.term -> int t
end

val run : unit -> unit
