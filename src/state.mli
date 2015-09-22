module type State = sig
  type t
  val empty : t
end

module Make(State:State) : sig
  type state = State.t

  type 'a t = state -> ('a * state)

  include Monad.S with type 'a t := 'a t

  val run : state -> 'a t -> ('a * state)

  val get : state t

  val set : state -> unit t
end

val run : unit -> unit
