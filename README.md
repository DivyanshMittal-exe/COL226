# COL 226: Programming Languages

## Design and Implementation Decisions

## Running the code

To parse and create an AST file run 
``` 
    make
    parseFile "filename";
``` 

To evaluate the AST, we have a function for evaluate. To evaluate a file, we simply do 

```
    make 
    evaluate(parseFile "test");
```

## FunStack
The funstack is implemented as a type list. Various high order functions help implement the stack function




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

While no code has been copied from any source as such, to learn about ml-yacc and ml-lex, I followed 2 pdfs, and a lot of my design choices have been influenced by their examples. The 2 pdfs were [Pdf from profs Website](http://rogerprice.org/ug/ug.pdf) and [This pdf on ml-yacc](http://cs.wellesley.edu/~cs235/fall08/lectures/35_YACC_revised.pdf). For the glue code that is whileinterface.sml and for loading sml in ```load-while.sml``` I took how to write the syntax from the second pdf. Nothing was blindly copy pasted though. To convert my ebnf to railroad, I used this [website](https://matthijsgroen.github.io/ebnf2railroad/)