module type State = sig
  type t
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
  end)

let run () =
  let open State in
  let (>>=) = bind in
  let op v = unit (v * 2) in
  let tick v =
    get >>= fun st ->
    set (st + 1) >>= fun () ->
    unit v
  in
  let (value, state) = run 0 (
      unit 1 >>=
      op >>= tick >>= op >>= tick >>=
      op >>= tick >>= op >>= tick) in
  Printf.printf "=== Final value: %d\n=== Final state: %d" value state;
  flush stdout;
  ()
