au BufNewFile,BufRead *.lake,Lakefile call SetLakeOptions()
if !exists("*SetLakeOptions")
    function SetLakeOptions()
        set autoindent
        set filetype=lake syntax=lake
        setlocal shiftwidth=4 softtabstop=4
        setlocal indentkeys=!^F,o,O
    endfunction
endif
