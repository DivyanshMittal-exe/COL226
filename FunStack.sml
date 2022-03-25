signature STACK =
sig
    type 'a Stack = 'a list
    exception EmptyStack
    exception Error of string
    val create: unit -> 'a Stack
    val push : 'a * 'a Stack -> 'a Stack
    val pop : 'a Stack -> 'a Stack
    val top : 'a Stack -> 'a
    val empty: 'a Stack -> bool
    val poptop : 'a Stack -> ('a * 'a Stack) option
    val nth : 'a Stack * int -> 'a
    val drop : 'a Stack * int -> 'a Stack
    val depth : 'a Stack -> int
    val app : ('a -> unit) -> 'a Stack -> unit
    val map : ('a -> 'b) -> 'a Stack -> 'b Stack
    val mapPartial : ('a -> 'b option) -> 'a Stack -> 'b Stack
    val find : ('a -> bool) -> 'a Stack -> 'a option
    val filter : ('a -> bool) -> 'a Stack -> 'a Stack
    val foldr : ('a * 'b -> 'b) -> 'b -> 'a Stack -> 'b
    val foldl : ('a * 'b -> 'b) -> 'b -> 'a Stack -> 'b
    val exists : ('a -> bool) -> 'a Stack -> bool
    val all : ('a -> bool) -> 'a Stack -> bool
    val list2stack : 'a list -> 'a Stack (* Convert a list into a Stack *)
    val stack2list: 'a Stack -> 'a list (* Convert a Stack into a list *)
    val toString: ('a -> string) -> 'a Stack -> string
end

structure FunStack :> STACK =
struct
    type 'a Stack = 'a list
    exception EmptyStack
    exception Error of string
    fun create () = []
    fun push(element: 'a ,stck: 'a Stack) : 'a Stack = element::stck

    fun pop(stck: 'a Stack):'a Stack = 
        (case stck of 
            [] => raise EmptyStack
        |(element::stckLeft) => stckLeft)

    fun top (stck: 'a Stack):'a = 
        (case stck of
           [] => raise EmptyStack
         | (element::stckLeft) => element)

    fun empty (stck: 'a Stack) : bool = 
        (case stck of 
            [] => true
            | _ => false)

    fun poptop (stck: 'a Stack) : ('a * 'a Stack) option = 
        (case stck of 
            [] => NONE
            |(element::stckLeft) => SOME (element,stckLeft))
    fun nth (stck: 'a Stack, n: int) : 'a = 
        let
          fun get ((element::_),0) = element
            | get ([],_) = raise Error("Invalid Access")
            | get ((_::tail),n) = get(tail, n - 1)
        in
            if n >= 0 then get (stck,n) else raise Error("Invalid Access")
        end

    fun drop (stck: 'a Stack, n: int) : 'a Stack = 
        let
          fun dr (st,0) = st
            | dr ([],_) = raise Error("Invalid Access")
            | dr ((_::tail),n) = dr(tail, n - 1)
        in
            if n >= 0 then dr (stck,n) else raise Error("Invalid Access")
        end
    fun depth (stck: 'a Stack) : int = 
        let
            fun count (n, []) = n
                | count (n, _ :: l) = count (n + 1, l)
        in
            count (0, stck)
        end
    fun app (function :'a -> unit):'a Stack -> unit = 
        let
            fun applier [] = ()
            | applier (x :: xs) = (function x : unit; applier(xs))
        in
            applier
        end
    fun map (function :'a -> 'b): 'a Stack -> 'b Stack = 
        let
          fun mapper [] = []  
            | mapper(x::xs) = (function x) :: mapper(xs)
        in
          mapper
        end
    fun mapPartial (function :'a -> 'b option): 'a Stack -> 'b Stack = 
        let
          fun pmapper [] = []
             | pmapper (x::xs) = 
                case function x of
                   SOME v => v::pmapper(xs)
                 | NONE => pmapper(xs)
        in
          pmapper
        end
    fun find  (function : 'a -> bool) : 'a Stack -> 'a option =
        let
            fun finder [] = NONE
            fun finder (x::xs) = 
                if function x then SOME x else finder(xs)
        in
            finder
        end
    fun filter (function : 'a -> bool) : 'a Stack -> 'a Stack = 
        let
            fun filterer [] = []
            fun filterer (x::xs) = 
                if function x then x :: filterer(xs)  else filterer(xs)
        in
            filterer
        end
    fun foldr  (function : 'a * 'b -> 'b) : 'b -> 'a Stack -> 'b = foldr function
    fun foldl  (function : 'a * 'b -> 'b) : 'b -> 'a Stack -> 'b = foldl function 
    fun exists  (function : 'a -> bool) : 'a Stack -> bool =  
        let
            fun finder [] = false
            fun finder (x::xs) = 
                if function x then true else finder(xs)
        in
            finder
        end
    fun all (function : 'a -> bool) : 'a Stack -> bool = 
        let
          fun aller [] = true
             | aller (x::xs) = (function  x) andalso (aller xs)
        in
          aller
        end
    fun list2stack (listinp : 'a list) : 'a Stack = listinp
    fun stack2list (stckinp : 'a Stack) : 'a list  = stckinp
    fun toString (function : 'a -> string) :'a Stack -> string = 
    let
      fun f [] = ""
        | f(hd::tl) = (function hd ) ^" "^ (f tl)
    in f end

end