functor WhileLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : While_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct

open AST


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\032\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\055\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\057\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\061\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\069\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\071\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\073\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\075\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\077\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\079\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\081\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\083\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\085\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\087\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\018\000\089\000\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\001\000\029\000\002\000\028\000\003\000\027\000\004\000\026\000\
\\029\000\025\000\030\000\024\000\039\000\023\000\000\000\
\\001\000\002\000\115\000\009\000\115\000\010\000\115\000\011\000\115\000\
\\015\000\115\000\040\000\115\000\042\000\115\000\000\000\
\\001\000\002\000\116\000\008\000\008\000\009\000\116\000\010\000\116\000\
\\011\000\116\000\015\000\116\000\040\000\116\000\042\000\116\000\000\000\
\\001\000\002\000\117\000\008\000\117\000\009\000\117\000\010\000\117\000\
\\011\000\117\000\015\000\117\000\040\000\117\000\042\000\117\000\000\000\
\\001\000\002\000\004\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\013\000\124\000\014\000\124\000\015\000\013\000\017\000\124\000\
\\040\000\012\000\041\000\124\000\042\000\124\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\013\000\124\000\015\000\013\000\040\000\012\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\014\000\124\000\015\000\013\000\040\000\012\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\015\000\013\000\017\000\124\000\040\000\012\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\015\000\013\000\040\000\012\000\041\000\124\000\000\000\
\\001\000\002\000\017\000\009\000\016\000\010\000\015\000\011\000\014\000\
\\015\000\013\000\040\000\012\000\042\000\124\000\000\000\
\\001\000\002\000\019\000\000\000\
\\001\000\002\000\033\000\000\000\
\\001\000\005\000\064\000\006\000\063\000\000\000\
\\001\000\007\000\003\000\000\000\
\\001\000\012\000\132\000\016\000\132\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\132\000\
\\024\000\132\000\025\000\132\000\026\000\132\000\027\000\132\000\
\\028\000\132\000\031\000\132\000\036\000\132\000\037\000\132\000\
\\038\000\132\000\000\000\
\\001\000\012\000\133\000\016\000\133\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\133\000\
\\024\000\133\000\025\000\133\000\026\000\133\000\027\000\133\000\
\\028\000\133\000\031\000\133\000\036\000\133\000\037\000\133\000\
\\038\000\133\000\000\000\
\\001\000\012\000\134\000\016\000\134\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\134\000\
\\024\000\134\000\025\000\134\000\026\000\134\000\027\000\134\000\
\\028\000\134\000\031\000\134\000\036\000\134\000\037\000\134\000\
\\038\000\134\000\000\000\
\\001\000\012\000\135\000\016\000\135\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\135\000\
\\024\000\135\000\025\000\135\000\026\000\135\000\027\000\135\000\
\\028\000\135\000\031\000\135\000\036\000\135\000\037\000\135\000\
\\038\000\135\000\000\000\
\\001\000\012\000\136\000\016\000\136\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\136\000\
\\024\000\136\000\025\000\136\000\026\000\136\000\027\000\136\000\
\\028\000\136\000\031\000\136\000\036\000\136\000\037\000\136\000\
\\038\000\136\000\000\000\
\\001\000\012\000\137\000\016\000\137\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\137\000\
\\024\000\137\000\025\000\137\000\026\000\137\000\027\000\137\000\
\\028\000\137\000\031\000\137\000\036\000\137\000\037\000\137\000\
\\038\000\137\000\000\000\
\\001\000\012\000\138\000\016\000\138\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\046\000\
\\024\000\045\000\025\000\044\000\026\000\043\000\027\000\042\000\
\\028\000\041\000\031\000\138\000\036\000\138\000\037\000\138\000\
\\038\000\138\000\000\000\
\\001\000\012\000\139\000\016\000\139\000\018\000\051\000\019\000\050\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\046\000\
\\024\000\045\000\025\000\044\000\026\000\043\000\027\000\042\000\
\\028\000\041\000\031\000\139\000\036\000\139\000\037\000\040\000\
\\038\000\139\000\000\000\
\\001\000\012\000\140\000\016\000\140\000\018\000\140\000\019\000\140\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\140\000\
\\024\000\140\000\025\000\140\000\026\000\140\000\027\000\140\000\
\\028\000\140\000\031\000\140\000\036\000\140\000\037\000\140\000\
\\038\000\140\000\000\000\
\\001\000\012\000\141\000\016\000\141\000\018\000\141\000\019\000\141\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\141\000\
\\024\000\141\000\025\000\141\000\026\000\141\000\027\000\141\000\
\\028\000\141\000\031\000\141\000\036\000\141\000\037\000\141\000\
\\038\000\141\000\000\000\
\\001\000\012\000\142\000\016\000\142\000\018\000\142\000\019\000\142\000\
\\020\000\142\000\021\000\142\000\022\000\142\000\023\000\142\000\
\\024\000\142\000\025\000\142\000\026\000\142\000\027\000\142\000\
\\028\000\142\000\031\000\142\000\036\000\142\000\037\000\142\000\
\\038\000\142\000\000\000\
\\001\000\012\000\143\000\016\000\143\000\018\000\143\000\019\000\143\000\
\\020\000\143\000\021\000\143\000\022\000\143\000\023\000\143\000\
\\024\000\143\000\025\000\143\000\026\000\143\000\027\000\143\000\
\\028\000\143\000\031\000\143\000\036\000\143\000\037\000\143\000\
\\038\000\143\000\000\000\
\\001\000\012\000\144\000\016\000\144\000\018\000\144\000\019\000\144\000\
\\020\000\144\000\021\000\144\000\022\000\144\000\023\000\144\000\
\\024\000\144\000\025\000\144\000\026\000\144\000\027\000\144\000\
\\028\000\144\000\031\000\144\000\036\000\144\000\037\000\144\000\
\\038\000\144\000\000\000\
\\001\000\012\000\145\000\016\000\145\000\018\000\145\000\019\000\145\000\
\\020\000\145\000\021\000\145\000\022\000\145\000\023\000\145\000\
\\024\000\145\000\025\000\145\000\026\000\145\000\027\000\145\000\
\\028\000\145\000\031\000\145\000\036\000\145\000\037\000\145\000\
\\038\000\145\000\000\000\
\\001\000\012\000\146\000\016\000\146\000\018\000\146\000\019\000\146\000\
\\020\000\146\000\021\000\146\000\022\000\146\000\023\000\146\000\
\\024\000\146\000\025\000\146\000\026\000\146\000\027\000\146\000\
\\028\000\146\000\031\000\146\000\036\000\146\000\037\000\146\000\
\\038\000\146\000\000\000\
\\001\000\012\000\147\000\016\000\147\000\018\000\147\000\019\000\147\000\
\\020\000\147\000\021\000\147\000\022\000\147\000\023\000\147\000\
\\024\000\147\000\025\000\147\000\026\000\147\000\027\000\147\000\
\\028\000\147\000\031\000\147\000\036\000\147\000\037\000\147\000\
\\038\000\147\000\000\000\
\\001\000\012\000\148\000\016\000\148\000\018\000\148\000\019\000\148\000\
\\020\000\148\000\021\000\148\000\022\000\148\000\023\000\148\000\
\\024\000\148\000\025\000\148\000\026\000\148\000\027\000\148\000\
\\028\000\148\000\031\000\148\000\036\000\148\000\037\000\148\000\
\\038\000\148\000\000\000\
\\001\000\012\000\149\000\016\000\149\000\018\000\149\000\019\000\149\000\
\\020\000\149\000\021\000\149\000\022\000\149\000\023\000\149\000\
\\024\000\149\000\025\000\149\000\026\000\149\000\027\000\149\000\
\\028\000\149\000\031\000\149\000\036\000\149\000\037\000\149\000\
\\038\000\149\000\000\000\
\\001\000\012\000\150\000\016\000\150\000\018\000\150\000\019\000\150\000\
\\020\000\150\000\021\000\150\000\022\000\150\000\023\000\150\000\
\\024\000\150\000\025\000\150\000\026\000\150\000\027\000\150\000\
\\028\000\150\000\031\000\150\000\036\000\150\000\037\000\150\000\
\\038\000\150\000\000\000\
\\001\000\012\000\151\000\016\000\151\000\018\000\151\000\019\000\151\000\
\\020\000\151\000\021\000\151\000\022\000\151\000\023\000\151\000\
\\024\000\151\000\025\000\151\000\026\000\151\000\027\000\151\000\
\\028\000\151\000\031\000\151\000\036\000\151\000\037\000\151\000\
\\038\000\151\000\000\000\
\\001\000\012\000\152\000\016\000\152\000\018\000\152\000\019\000\152\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\152\000\
\\024\000\152\000\025\000\152\000\026\000\152\000\027\000\152\000\
\\028\000\152\000\031\000\152\000\036\000\152\000\037\000\152\000\
\\038\000\152\000\000\000\
\\001\000\012\000\153\000\016\000\153\000\018\000\153\000\019\000\153\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\153\000\
\\024\000\153\000\025\000\153\000\026\000\153\000\027\000\153\000\
\\028\000\153\000\031\000\153\000\036\000\153\000\037\000\153\000\
\\038\000\153\000\000\000\
\\001\000\012\000\154\000\016\000\154\000\018\000\154\000\019\000\154\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\154\000\
\\024\000\154\000\025\000\154\000\026\000\154\000\027\000\154\000\
\\028\000\154\000\031\000\154\000\036\000\154\000\037\000\154\000\
\\038\000\154\000\000\000\
\\001\000\012\000\155\000\016\000\155\000\018\000\155\000\019\000\155\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\155\000\
\\024\000\155\000\025\000\155\000\026\000\155\000\027\000\155\000\
\\028\000\155\000\031\000\155\000\036\000\155\000\037\000\155\000\
\\038\000\155\000\000\000\
\\001\000\012\000\156\000\016\000\156\000\018\000\156\000\019\000\156\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\156\000\
\\024\000\156\000\025\000\156\000\026\000\156\000\027\000\156\000\
\\028\000\156\000\031\000\156\000\036\000\156\000\037\000\156\000\
\\038\000\156\000\000\000\
\\001\000\012\000\157\000\016\000\157\000\018\000\157\000\019\000\157\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\157\000\
\\024\000\157\000\025\000\157\000\026\000\157\000\027\000\157\000\
\\028\000\157\000\031\000\157\000\036\000\157\000\037\000\157\000\
\\038\000\157\000\000\000\
\\001\000\012\000\158\000\016\000\158\000\018\000\158\000\019\000\158\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\158\000\
\\024\000\158\000\025\000\158\000\026\000\158\000\027\000\158\000\
\\028\000\158\000\031\000\158\000\036\000\158\000\037\000\158\000\
\\038\000\158\000\000\000\
\\001\000\012\000\159\000\016\000\159\000\018\000\159\000\019\000\159\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\159\000\
\\024\000\159\000\025\000\159\000\026\000\159\000\027\000\159\000\
\\028\000\159\000\031\000\159\000\036\000\159\000\037\000\159\000\
\\038\000\159\000\000\000\
\\001\000\012\000\160\000\016\000\160\000\018\000\160\000\019\000\160\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\160\000\
\\024\000\160\000\025\000\160\000\026\000\160\000\027\000\160\000\
\\028\000\160\000\031\000\160\000\036\000\160\000\037\000\160\000\
\\038\000\160\000\000\000\
\\001\000\012\000\161\000\016\000\161\000\018\000\161\000\019\000\161\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\161\000\
\\024\000\161\000\025\000\161\000\026\000\161\000\027\000\161\000\
\\028\000\161\000\031\000\161\000\036\000\161\000\037\000\161\000\
\\038\000\161\000\000\000\
\\001\000\012\000\162\000\016\000\162\000\018\000\162\000\019\000\162\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\162\000\
\\024\000\162\000\025\000\162\000\026\000\162\000\027\000\162\000\
\\028\000\162\000\031\000\162\000\036\000\162\000\037\000\162\000\
\\038\000\162\000\000\000\
\\001\000\012\000\163\000\016\000\163\000\018\000\163\000\019\000\163\000\
\\020\000\163\000\021\000\163\000\022\000\163\000\023\000\163\000\
\\024\000\163\000\025\000\163\000\026\000\163\000\027\000\163\000\
\\028\000\163\000\031\000\163\000\036\000\163\000\037\000\163\000\
\\038\000\163\000\000\000\
\\001\000\012\000\164\000\016\000\164\000\018\000\164\000\019\000\164\000\
\\020\000\049\000\021\000\048\000\022\000\047\000\023\000\164\000\
\\024\000\164\000\025\000\164\000\026\000\164\000\027\000\164\000\
\\028\000\164\000\031\000\164\000\036\000\164\000\037\000\164\000\
\\038\000\164\000\000\000\
\\001\000\012\000\058\000\018\000\051\000\019\000\050\000\020\000\049\000\
\\021\000\048\000\022\000\047\000\023\000\046\000\024\000\045\000\
\\025\000\044\000\026\000\043\000\027\000\042\000\028\000\041\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\013\000\122\000\014\000\122\000\017\000\122\000\041\000\122\000\
\\042\000\122\000\000\000\
\\001\000\013\000\123\000\014\000\123\000\017\000\123\000\041\000\123\000\
\\042\000\123\000\000\000\
\\001\000\013\000\110\000\000\000\
\\001\000\014\000\112\000\000\000\
\\001\000\016\000\052\000\018\000\051\000\019\000\050\000\020\000\049\000\
\\021\000\048\000\022\000\047\000\023\000\046\000\024\000\045\000\
\\025\000\044\000\026\000\043\000\027\000\042\000\028\000\041\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\017\000\108\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\031\000\091\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\031\000\109\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\036\000\125\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\036\000\127\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\036\000\130\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\018\000\051\000\019\000\050\000\020\000\049\000\021\000\048\000\
\\022\000\047\000\023\000\046\000\024\000\045\000\025\000\044\000\
\\026\000\043\000\027\000\042\000\028\000\041\000\036\000\131\000\
\\037\000\040\000\038\000\039\000\000\000\
\\001\000\032\000\034\000\000\000\
\\001\000\033\000\120\000\035\000\036\000\000\000\
\\001\000\033\000\121\000\000\000\
\\001\000\033\000\035\000\000\000\
\\001\000\034\000\005\000\000\000\
\\001\000\036\000\118\000\000\000\
\\001\000\036\000\119\000\000\000\
\\001\000\036\000\126\000\000\000\
\\001\000\036\000\128\000\000\000\
\\001\000\036\000\129\000\000\000\
\\001\000\036\000\020\000\000\000\
\\001\000\036\000\096\000\000\000\
\\001\000\041\000\038\000\000\000\
\\001\000\042\000\000\000\000\000\
\\001\000\042\000\114\000\000\000\
\"
val actionRowNumbers =
"\029\000\019\000\080\000\017\000\
\\017\000\025\000\026\000\016\000\
\\086\000\090\000\024\000\015\000\
\\015\000\000\000\027\000\076\000\
\\079\000\077\000\020\000\088\000\
\\068\000\015\000\001\000\002\000\
\\047\000\046\000\049\000\048\000\
\\063\000\073\000\015\000\083\000\
\\003\000\028\000\026\000\065\000\
\\064\000\015\000\015\000\004\000\
\\005\000\006\000\007\000\008\000\
\\009\000\010\000\011\000\012\000\
\\013\000\014\000\023\000\045\000\
\\070\000\015\000\044\000\015\000\
\\021\000\075\000\072\000\015\000\
\\087\000\081\000\082\000\078\000\
\\037\000\036\000\034\000\015\000\
\\031\000\015\000\033\000\015\000\
\\030\000\015\000\035\000\015\000\
\\032\000\015\000\042\000\015\000\
\\041\000\015\000\040\000\015\000\
\\039\000\015\000\038\000\015\000\
\\069\000\043\000\071\000\062\000\
\\066\000\074\000\018\000\054\000\
\\051\000\053\000\050\000\055\000\
\\052\000\060\000\059\000\058\000\
\\057\000\056\000\085\000\061\000\
\\022\000\067\000\084\000\089\000"
val gotoT =
"\
\\001\000\111\000\000\000\
\\000\000\
\\000\000\
\\002\000\005\000\003\000\004\000\000\000\
\\002\000\007\000\003\000\004\000\000\000\
\\004\000\009\000\005\000\008\000\000\000\
\\006\000\016\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\019\000\005\000\008\000\000\000\
\\008\000\020\000\000\000\
\\008\000\028\000\000\000\
\\008\000\029\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\035\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\008\000\051\000\000\000\
\\008\000\052\000\000\000\
\\008\000\054\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\057\000\000\000\
\\000\000\
\\008\000\058\000\000\000\
\\009\000\060\000\000\000\
\\006\000\063\000\000\000\
\\000\000\
\\000\000\
\\008\000\064\000\000\000\
\\008\000\065\000\000\000\
\\008\000\066\000\000\000\
\\008\000\068\000\000\000\
\\008\000\070\000\000\000\
\\008\000\072\000\000\000\
\\008\000\074\000\000\000\
\\008\000\076\000\000\000\
\\008\000\078\000\000\000\
\\008\000\080\000\000\000\
\\008\000\082\000\000\000\
\\008\000\084\000\000\000\
\\008\000\086\000\000\000\
\\004\000\088\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\008\000\090\000\000\000\
\\000\000\
\\008\000\091\000\000\000\
\\004\000\092\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\008\000\093\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\095\000\000\000\
\\000\000\
\\008\000\096\000\000\000\
\\000\000\
\\008\000\097\000\000\000\
\\000\000\
\\008\000\098\000\000\000\
\\000\000\
\\008\000\099\000\000\000\
\\000\000\
\\008\000\100\000\000\000\
\\000\000\
\\008\000\101\000\000\000\
\\000\000\
\\008\000\102\000\000\000\
\\000\000\
\\008\000\103\000\000\000\
\\000\000\
\\008\000\104\000\000\000\
\\000\000\
\\008\000\105\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\109\000\005\000\008\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 112
val numrules = 51
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | IDENTIFIER of unit ->  (string) | NUMBER of unit ->  (int)
 | Type of unit ->  (dtypes) | expression of unit ->  (Exp)
 | var of unit ->  (string) | varlist of unit ->  (string list)
 | command of unit ->  (CMD) | command_seq of unit ->  (CMD list)
 | decleration of unit ->  (DEC)
 | decleration_seq of unit ->  (DEC list) | srt of unit ->  (PROG)
end
type svalue = MlyValue.svalue
type result = PROG
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 41) => true | _ => false
val showTerminal =
fn (T 0) => "NUMBER"
  | (T 1) => "IDENTIFIER"
  | (T 2) => "BTRUE"
  | (T 3) => "BFALSE"
  | (T 4) => "INT"
  | (T 5) => "BOOL"
  | (T 6) => "PROGRAM"
  | (T 7) => "VAR"
  | (T 8) => "READ"
  | (T 9) => "WRITE"
  | (T 10) => "IF"
  | (T 11) => "THEN"
  | (T 12) => "ELSE"
  | (T 13) => "ENDIF"
  | (T 14) => "WHILE"
  | (T 15) => "DO"
  | (T 16) => "ENDWH"
  | (T 17) => "PLUS"
  | (T 18) => "MINUS"
  | (T 19) => "TIMES"
  | (T 20) => "DIV"
  | (T 21) => "MOD"
  | (T 22) => "EQ"
  | (T 23) => "NEQ"
  | (T 24) => "LT"
  | (T 25) => "GT"
  | (T 26) => "LEQ"
  | (T 27) => "GEQ"
  | (T 28) => "NEG"
  | (T 29) => "LPAREN"
  | (T 30) => "RPAREN"
  | (T 31) => "ASSN"
  | (T 32) => "COLON"
  | (T 33) => "SCOPE"
  | (T 34) => "COMMA"
  | (T 35) => "DELIM"
  | (T 36) => "AND"
  | (T 37) => "OR"
  | (T 38) => "NOT"
  | (T 39) => "LCURL"
  | (T 40) => "RCURL"
  | (T 41) => "EOF"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38) $$ (T 37) $$ (T 36) $$ (T 35)
 $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31) $$ (T 30) $$ (T 29) $$ (T 28)
 $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24) $$ (T 23) $$ (T 22) $$ (T 21)
 $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17) $$ (T 16) $$ (T 15) $$ (T 14)
 $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10) $$ (T 9) $$ (T 8) $$ (T 7)
 $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 3) $$ (T 2)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.command_seq command_seq1, _, 
command_seq1right)) :: ( _, ( MlyValue.decleration_seq 
decleration_seq1, _, _)) :: _ :: ( _, ( MlyValue.IDENTIFIER 
IDENTIFIER1, _, _)) :: ( _, ( _, PROGRAM1left, _)) :: rest671)) => let
 val  result = MlyValue.srt (fn _ => let val  (IDENTIFIER as 
IDENTIFIER1) = IDENTIFIER1 ()
 val  (decleration_seq as decleration_seq1) = decleration_seq1 ()
 val  (command_seq as command_seq1) = command_seq1 ()
 in ((PROG(IDENTIFIER,decleration_seq,command_seq)))
end)
 in ( LrTable.NT 0, ( result, PROGRAM1left, command_seq1right), 
rest671)
end
|  ( 1, ( ( _, ( MlyValue.decleration_seq decleration_seq1, _, 
decleration_seq1right)) :: ( _, ( MlyValue.decleration decleration1, 
decleration1left, _)) :: rest671)) => let val  result = 
MlyValue.decleration_seq (fn _ => let val  (decleration as 
decleration1) = decleration1 ()
 val  (decleration_seq as decleration_seq1) = decleration_seq1 ()
 in ((decleration::decleration_seq))
end)
 in ( LrTable.NT 1, ( result, decleration1left, decleration_seq1right)
, rest671)
end
|  ( 2, ( rest671)) => let val  result = MlyValue.decleration_seq (fn
 _ => ([]))
 in ( LrTable.NT 1, ( result, defaultPos, defaultPos), rest671)
end
|  ( 3, ( ( _, ( _, _, DELIM1right)) :: ( _, ( MlyValue.Type Type1, _,
 _)) :: _ :: ( _, ( MlyValue.varlist varlist1, _, _)) :: ( _, ( _, 
VAR1left, _)) :: rest671)) => let val  result = MlyValue.decleration
 (fn _ => let val  (varlist as varlist1) = varlist1 ()
 val  (Type as Type1) = Type1 ()
 in ((DEC(varlist,Type)))
end)
 in ( LrTable.NT 2, ( result, VAR1left, DELIM1right), rest671)
end
|  ( 4, ( ( _, ( _, BOOL1left, BOOL1right)) :: rest671)) => let val  
result = MlyValue.Type (fn _ => ((BOOL)))
 in ( LrTable.NT 8, ( result, BOOL1left, BOOL1right), rest671)
end
|  ( 5, ( ( _, ( _, INT1left, INT1right)) :: rest671)) => let val  
result = MlyValue.Type (fn _ => ((INT)))
 in ( LrTable.NT 8, ( result, INT1left, INT1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, 
IDENTIFIER1right)) :: rest671)) => let val  result = MlyValue.varlist
 (fn _ => let val  (IDENTIFIER as IDENTIFIER1) = IDENTIFIER1 ()
 in ([IDENTIFIER])
end)
 in ( LrTable.NT 5, ( result, IDENTIFIER1left, IDENTIFIER1right), 
rest671)
end
|  ( 7, ( ( _, ( MlyValue.varlist varlist1, _, varlist1right)) :: _ ::
 ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, _)) :: 
rest671)) => let val  result = MlyValue.varlist (fn _ => let val  (
IDENTIFIER as IDENTIFIER1) = IDENTIFIER1 ()
 val  (varlist as varlist1) = varlist1 ()
 in ((IDENTIFIER::varlist))
end)
 in ( LrTable.NT 5, ( result, IDENTIFIER1left, varlist1right), rest671
)
end
|  ( 8, ( ( _, ( _, _, RCURL1right)) :: ( _, ( MlyValue.command_seq 
command_seq1, _, _)) :: ( _, ( _, LCURL1left, _)) :: rest671)) => let
 val  result = MlyValue.command_seq (fn _ => let val  (command_seq as 
command_seq1) = command_seq1 ()
 in ((command_seq))
end)
 in ( LrTable.NT 3, ( result, LCURL1left, RCURL1right), rest671)
end
|  ( 9, ( ( _, ( MlyValue.command_seq command_seq1, _, 
command_seq1right)) :: _ :: ( _, ( MlyValue.command command1, 
command1left, _)) :: rest671)) => let val  result = 
MlyValue.command_seq (fn _ => let val  (command as command1) = 
command1 ()
 val  (command_seq as command_seq1) = command_seq1 ()
 in ((command::command_seq))
end)
 in ( LrTable.NT 3, ( result, command1left, command_seq1right), 
rest671)
end
|  ( 10, ( rest671)) => let val  result = MlyValue.command_seq (fn _
 => ([]))
 in ( LrTable.NT 3, ( result, defaultPos, defaultPos), rest671)
end
|  ( 11, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: _ :: ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, _)
) :: rest671)) => let val  result = MlyValue.command (fn _ => let val 
 (IDENTIFIER as IDENTIFIER1) = IDENTIFIER1 ()
 val  (expression as expression1) = expression1 ()
 in ((SET(IDENTIFIER,expression)))
end)
 in ( LrTable.NT 4, ( result, IDENTIFIER1left, expression1right), 
rest671)
end
|  ( 12, ( ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, _, IDENTIFIER1right
)) :: ( _, ( _, READ1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (IDENTIFIER as IDENTIFIER1) = 
IDENTIFIER1 ()
 in ((READ(IDENTIFIER)))
end)
 in ( LrTable.NT 4, ( result, READ1left, IDENTIFIER1right), rest671)

end
|  ( 13, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: ( _, ( _, WRITE1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((WRITE(expression)))
end)
 in ( LrTable.NT 4, ( result, WRITE1left, expression1right), rest671)

end
|  ( 14, ( ( _, ( _, _, ENDIF1right)) :: ( _, ( MlyValue.command_seq 
command_seq2, _, _)) :: _ :: ( _, ( MlyValue.command_seq command_seq1,
 _, _)) :: _ :: ( _, ( MlyValue.expression expression1, _, _)) :: ( _,
 ( _, IF1left, _)) :: rest671)) => let val  result = MlyValue.command
 (fn _ => let val  (expression as expression1) = expression1 ()
 val  command_seq1 = command_seq1 ()
 val  command_seq2 = command_seq2 ()
 in ((ITE(expression,command_seq1,command_seq2)))
end)
 in ( LrTable.NT 4, ( result, IF1left, ENDIF1right), rest671)
end
|  ( 15, ( ( _, ( _, _, ENDWH1right)) :: ( _, ( MlyValue.command_seq 
command_seq1, _, _)) :: _ :: ( _, ( MlyValue.expression expression1, _
, _)) :: ( _, ( _, WHILE1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (expression as expression1) = 
expression1 ()
 val  (command_seq as command_seq1) = command_seq1 ()
 in ((WH(expression,command_seq)))
end)
 in ( LrTable.NT 4, ( result, WHILE1left, ENDWH1right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: _ :: _ :: ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, 
IDENTIFIER1left, _)) :: rest671)) => let val  result = 
MlyValue.command (fn _ => let val  (IDENTIFIER as IDENTIFIER1) = 
IDENTIFIER1 ()
 val  (expression as expression1) = expression1 ()
 in ((SET(IDENTIFIER,expression)))
end)
 in ( LrTable.NT 4, ( result, IDENTIFIER1left, expression1right), 
rest671)
end
|  ( 17, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: _ :: ( _, ( _, WRITE1left, _)) :: rest671)) => let val  result =
 MlyValue.command (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((WRITE(expression)))
end)
 in ( LrTable.NT 4, ( result, WRITE1left, expression1right), rest671)

end
|  ( 18, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((LT(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 19, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((LEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 20, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((EQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 21, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((GT(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 22, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((GEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 23, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((NEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 24, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((AND(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 25, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((OR(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 26, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((PLUS(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 27, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((MINUS(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 28, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((TIMES(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 29, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((DIV(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 30, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: ( _, ( MlyValue.expression expression1, expression1left, _)
) :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((MOD(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 31, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.expression 
expression1, _, _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let
 val  result = MlyValue.expression (fn _ => let val  (expression as 
expression1) = expression1 ()
 in ((expression))
end)
 in ( LrTable.NT 7, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 32, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: ( _, ( _, NEG1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((NEG(expression)))
end)
 in ( LrTable.NT 7, ( result, NEG1left, expression1right), rest671)

end
|  ( 33, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: ( _, ( _, NOT1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((NOT(expression)))
end)
 in ( LrTable.NT 7, ( result, NOT1left, expression1right), rest671)

end
|  ( 34, ( ( _, ( _, BTRUE1left, BTRUE1right)) :: rest671)) => let
 val  result = MlyValue.expression (fn _ => ((BOOLEAN(true))))
 in ( LrTable.NT 7, ( result, BTRUE1left, BTRUE1right), rest671)
end
|  ( 35, ( ( _, ( _, BFALSE1left, BFALSE1right)) :: rest671)) => let
 val  result = MlyValue.expression (fn _ => ((BOOLEAN(false))))
 in ( LrTable.NT 7, ( result, BFALSE1left, BFALSE1right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.NUMBER NUMBER1, NUMBER1left, NUMBER1right))
 :: rest671)) => let val  result = MlyValue.expression (fn _ => let
 val  (NUMBER as NUMBER1) = NUMBER1 ()
 in ((NUM(NUMBER)))
end)
 in ( LrTable.NT 7, ( result, NUMBER1left, NUMBER1right), rest671)
end
|  ( 37, ( ( _, ( MlyValue.IDENTIFIER IDENTIFIER1, IDENTIFIER1left, 
IDENTIFIER1right)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (IDENTIFIER as IDENTIFIER1) = 
IDENTIFIER1 ()
 in ((VAR(IDENTIFIER)))
end)
 in ( LrTable.NT 7, ( result, IDENTIFIER1left, IDENTIFIER1right), 
rest671)
end
|  ( 38, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((LT(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 39, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((LEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 40, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((EQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 41, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((GT(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 42, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((GEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 43, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((NEQ(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 44, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((PLUS(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 45, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((MINUS(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 46, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((TIMES(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 47, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((DIV(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 48, ( ( _, ( MlyValue.expression expression2, _, expression2right
)) :: _ :: _ :: ( _, ( MlyValue.expression expression1, 
expression1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  expression1 = expression1 ()
 val  expression2 = expression2 ()
 in ((MOD(expression1,expression2)))
end)
 in ( LrTable.NT 7, ( result, expression1left, expression2right), 
rest671)
end
|  ( 49, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.expression 
expression1, _, _)) :: _ :: ( _, ( _, LPAREN1left, _)) :: rest671)) =>
 let val  result = MlyValue.expression (fn _ => let val  (expression
 as expression1) = expression1 ()
 in ((expression))
end)
 in ( LrTable.NT 7, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 50, ( ( _, ( MlyValue.expression expression1, _, expression1right
)) :: _ :: ( _, ( _, NEG1left, _)) :: rest671)) => let val  result = 
MlyValue.expression (fn _ => let val  (expression as expression1) = 
expression1 ()
 in ((NEG(expression)))
end)
 in ( LrTable.NT 7, ( result, NEG1left, expression1right), rest671)

end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.srt x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : While_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun NUMBER (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.NUMBER (fn () => i),p1,p2))
fun IDENTIFIER (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.IDENTIFIER (fn () => i),p1,p2))
fun BTRUE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun BFALSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun INT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun BOOL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun PROGRAM (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun READ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun WRITE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun ENDIF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun ENDWH (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun TIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun DIV (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun MOD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun NEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun LEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun GEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun NEG (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun COLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun SCOPE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun DELIM (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun NOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun LCURL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun RCURL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
end
end
