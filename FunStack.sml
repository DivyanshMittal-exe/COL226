signature STACK =
sig
    type 'a Stack
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
    
    fun nth (stck: 'a Stack, n: int) : 'a = List.nth (stck, n)

    fun drop (stck: 'a Stack, n: int) : 'a Stack = List.drop (stck,n)

    fun depth (stck: 'a Stack) : int = length stck

    fun app (function :'a -> unit):'a Stack -> unit = List.app function

    fun map (function :'a -> 'b): 'a Stack -> 'b Stack = List.map function
    fun mapPartial (function :'a -> 'b option): 'a Stack -> 'b Stack = List.mapPartial function
    fun find  (function : 'a -> bool) : 'a Stack -> 'a option =
        List.find function 
    fun filter (function : 'a -> bool) : 'a Stack -> 'a Stack = List.filter function
    fun foldr  (function : 'a * 'b -> 'b) : 'b -> 'a Stack -> 'b = foldr function
    fun foldl  (function : 'a * 'b -> 'b) : 'b -> 'a Stack -> 'b = foldl function 
    fun exists  (function : 'a -> bool) : 'a Stack -> bool =  List.exists function
    fun all (function : 'a -> bool) : 'a Stack -> bool = List.all function
    fun list2stack (listinp : 'a list) : 'a Stack = listinp
    fun stack2list (stckinp : 'a Stack) : 'a list  = stckinp
    fun toString (function : 'a -> string) :'a Stack -> string = 
    let
      fun f [] = "\n"
        | f(hd::tl) = (function hd ) ^" "^ (f tl)
    in f end


end