module type State = sig
  type t
  val empty : t
end

module Make(State: State) = struct
  type state = State.t

  type 'a t = state -> ('a * state)

  let unit a = fun x -> (a, x)

  let run s m = m s

  let get = fun s -> (s, s)

  let set s = fun _ -> ((), s)

  let bind m k = fun s ->
    let (a, s') = run s m
    in run s' (k a)
end

module State = Make(struct
    type t = int
    let empty = 0
  end)

let run () =
  let open State in
  let (>>=) = bind in
  let print_state v =
    get >>= fun st ->
    set (st*2) >>= fun () ->
    let new_value = (String.concat ""
                       [v; (Printf.sprintf "\nIntermediate state: %d;" st)]) in
    unit new_value
  in
  let (value, state) = run 2 (unit "" >>=
                              print_state >>= print_state >>=
                              print_state >>= print_state >>=
                              print_state >>= print_state) in
  Printf.printf "=== Final value: %s\n=== Final state: %d" value state;
  flush stdout;
  ()
