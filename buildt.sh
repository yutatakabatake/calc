ocamllex lexer1.mll
ocamlyacc parser1.mly
ocamlc -c interp.ml
ocamlc -c parser1.mli
ocamlc -c lexer1.ml
ocamlc -c parser1.ml
ocamlc -c calct.ml
ocamlc -o calct interp.cmo lexer1.cmo parser1.cmo calct.cmo