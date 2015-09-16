module Exc = struct
  type 'a t = Raise of string | Return of 'a

  let unit x = Return x

  let bind m f = match m with
    | Raise exc -> Raise exc
    | Return x -> f x

  let (>>=) = bind

  let raise' x = Raise x
end

let (>>=) = Exc.(>>=)

let rec eval = function
  | Eval.Con a -> Exc.unit a
  | Eval.Div (t, u) ->
    eval u >>= (fun u' ->
        eval t >>= (fun t' ->
            if u' == 0 then
              Exc.raise' "zero division error"
            else
              Exc.unit (t' / u')))
