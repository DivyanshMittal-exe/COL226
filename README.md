# COL 226: Programming Languages

## Design and Implementation Decisions
The VMC machine is basically 2 command stack and one memory array. The lookup table from ASS. 3 has been modified to map variables to there locations.variable
- For the read command, you will be prompted by the text `Input :`. If the read is for a bool variable, enter tt or ff. For an int, enter an int.
- Redefination of variables is allowed. If a variable of the same type is declared multiple times, the evaluator will only keep one instance of it. If it is declared as multiple types multiple times, only the last declrn will be considered.
- type 'a Stack = 'a list but no high order function of list was used to directly implement the stack functions 
- For while and ite **NO** compount datatype is used, as using that defeats the purpose of a stack 


## How does the code work

Basically before we start evaluating or executing, we need to be sure if we have to do them or not. Eg a case like b.c.WH, here b is a bool exp, so has a lots of terms and we need to lookahead and find if its a normal bool exp or not. As if this b evaluates to 1, we need to make c.b.c.WH and thus need this b. So essentially how we go about finding what a command is, we need to count the commands that come and number of operations they want. The function `getCommand` does this. Eg (b).(c).(d).ITE , we will keep the operator and operand track for (b),(c),(d). Say they are l,m,n. So we get l+m+n - 3 + 1 as count of the expn. As ITE brings together 3 operations and makes them to 1. Something like "value(1) value(2) PLUS" becomes +1 +1 (+2-1) as value(x) adds 1 operation, and PLUS brings together two and makes it to one. We keep doing this till we reduce to 1 and the last token is a command type (ie SET,SEQ,READ,WRITE,ITE,WH). 

Once we have this command, and its type, dealing with cases like READ,WRITE,SET. For ITE,WH,SEQ, we need to do the above process again with some changes(liek applcn in reverse). This is easy as while travesral we will be popping from command stack and use the calue stack to flip it. While travesrsing again, we can easily get the depth of the various sub commands. Eg b.c.d.ITE , we need to split between b,c and d. That is why we need a seq datatype. This code is `splitCommand`.
 
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
    type 'a Stack = 'a list
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
program rev :: 
var n,rem,rev : int;
{   
    read n;
    rev := 0;
    while n <> 0 do 
    {
        rem := n % 10;
        rev := rev * 10 + rem;
        n := n/10;
    }
    endwh;
    write rev;
}

```
### AST OutpuT
```
val it =
  PROG
    ("rev",[DEC (["n","rem","rev"],INT)],
     [READ "n",SET ("rev",NUM 0),
      WH
        (NEQ (VAR "n",NUM 0),
         [SET ("rem",MOD (VAR "n",NUM 10)),
          SET ("rev",PLUS (TIMES (VAR "rev",NUM 10),VAR "rem")),
          SET ("n",DIV (VAR "n",NUM 10))]),WRITE (VAR "rev")]) :
  WhileParser.result
```

### Evaluation output
```
- evaluate (parseFile "test");
Input: 
1234
4321
val it = (-,-,-) : V * M * C
-
```



## Acknowledgements
While no code has been copied from any source as such, to understand how List functions work I looked at there internal implementation. Apart from this all code and ideas are my original.