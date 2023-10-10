let _ = 
    try
        let lexbuf = Lexing.from_channel stdin in
            while true do
                let rlt = Parser1.prog Lexer1.token lexbuf in
                Interp.print_ast rlt;
                print_string "\n";
                ignore(
                Interp.interp rlt);
                flush stdout
            done
    with Lexer1.Eof -> exit 0