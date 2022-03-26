# COL 226: Programming Languages

## Design and Implementation Decisions
The VMC machine is basically 2 command stack and one memory array. The lookup table from ASS. 3 has been modified to map variables to there locations.variable
- For the read command, you will be prompted by the text `Input :`. If the read is for a bool variable, enter tt or ff. For an int, enter an int.
- Redefination of variables is allowed. If a variable of the same type is declared multiple times, the evaluator will only keep one instance of it. If it is declared as multiple types multiple times, only the last declrn will be considered.
- type 'a Stack = 'a list but no high order function of list was used to directly implement the stack functions 

## Running the code

To parse and create an AST file run 
``` 
    make
    parseFile "filename";
``` 

To evaluate the AST, we have a function for evaluate. To evaluate a file, we simply do 
```
    make 
    evaluate (parseFile "test");
```

## FunStack
The funstack is implemented as a type list. Higer order functions of lists are **not** used help implement the stack function. The signature and various functions of stack is
```
signature STACK =
sig
    type 'a Stack
    exception EmptyStack
    exception InvalidAccess
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
```

## VMC machine 
The VMC machine has 2 command stacks for V and C, and a memory array. The hashtable for lookup was made for the type checking part in assignment 3 is reused with some modification to make map variables to memory locations.
The signature for VMC is
```
signature VMC =
sig
    type V
    type M
    type C
    exception Error of string
    val postfix: CMD list ->  C
    val rules:  V*M*C -> V*M*C
    val evaluate: C  -> unit
    val toString :  V*M*C -> string
end
```


## Test Code

### While code
```
    program chad :: 

    var a,b,c : int ;var d,e,f : bool;
    {   
        b := 0;
        while  b <> 5 do { write b; b := b + 1;} endwh;
    }
```
### AST OutpuT
```
val it =
 PROG
    ("chad",[DEC (["a","b","c"],INT),DEC (["d","e","f"],BOOL)],
     [SET ("b",NUM 0),
      WH
        (NEQ (VAR "b",NUM 5),[WRITE (VAR "b"),SET ("b",PLUS (VAR "b",NUM 1))])])
  : WhileParser.result
```

### Evaluation output
```
- evaluate (parseFile "test");
Input: 
10
0
1
2
3
4

#0 :a => 10; #1 :b => 5; #4 :e => 0; #5 :f => 0; #3 :d => 0; #2 :c => 0;

val it = () : unit
-
```
Since in the end both value stack and command stack are empty, we get an empty line.



## Acknowledgements
While no code has been copied from any source as such, to understand how List functions work I looked at there internal implementation. Apart from this all code and ideas are my original.