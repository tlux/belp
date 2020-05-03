Nonterminals expression element bool.

Terminals var and_op or_op not_op eq_op '(' ')' true false.

Rootsymbol expression.
Left 100 or_op.
Left 200 and_op.
Left 300 eq_op.
Nonassoc 400 not_op.

expression -> bool : '$1'.
expression -> element eq_op element : {binary_expr, extract('$2'), '$1', '$3'}.
expression -> var : extract('$1').
expression -> expression or_op expression  : {binary_expr, or_op, '$1', '$3'}.
expression -> expression and_op expression : {binary_expr, and_op, '$1', '$3'}.
expression -> not_op expression : {unary_expr, not_op, '$2'}.
expression -> '(' expression ')' : '$2'.

element -> var : extract('$1').
element -> bool : '$1'.

bool -> true : true.
bool -> false : false.

Erlang code.

extract({T,_,V}) -> {T, V}.
