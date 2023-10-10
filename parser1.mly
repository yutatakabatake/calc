/* File parser1.mly */
%token<int> NUM
%token<string> ID
%token PLUS MINUS TIMES DIV ASSIGN PRINT LP RP SEMI EOL
%right SEMI
%left PLUS MINUS
%left TIMES DIV

%start prog
%type <Interp.stm> prog

%%

prog: s EOL  { $1 }
    ;

s   : s SEMI s      { Interp.Stmts ($1,$3) }
    | ID ASSIGN e   { Interp.Assign ($1,$3) }
    | PRINT LP e RP { Interp.Print ($3) }
    ;

e   : ID        { Interp.ID $1 }
    | NUM       { Interp.Num $1 }
    | LP e RP   { $2 }
    | e PLUS e  { Interp.Plus ($1,$3) }
    | e MINUS e { Interp.Minus ($1,$3) }
    | e TIMES e { Interp.Times ($1,$3) }
    | e DIV e   { Interp.Div ($1,$3) }
    ;