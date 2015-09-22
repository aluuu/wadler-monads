
let () =
  Printf.printf "\n*** State monad ***\n";
  ignore (State.run ());
  Printf.printf "\n*** Exceptions monad ***\n";
  ignore (Exceptions.run ());
  flush stdout
