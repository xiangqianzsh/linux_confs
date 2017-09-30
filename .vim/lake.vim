"
"  Vim syntax file for lake
"  Based on https://bitbucket.org/larsyencken/vim-lake-syntax.git
"  Language: lake
"  Latest Revision: 2017-05-15
"

if exists("b:current_syntax")
  finish
endif

syn include @Shell syntax/sh.vim
unlet b:current_syntax

syn include @Python syntax/python.vim
unlet b:current_syntax

syn include @Ruby syntax/ruby.vim
unlet b:current_syntax

syn include @Awk syntax/awk.vim
unlet b:current_syntax

syn include @R syntax/r.vim
let b:current_syntax = 'lake'

" Comments Tag Directives and Protocols
syn match lakeTag "@[a-zA-Z_][a-zA-Z0-9_]*" contained
syn match lakeDirective "^%[a-zA-Z_][a-zA-Z_]* "
syn match lakeComment "#.*$" contains=lakeTodo
syn keyword lakeTodo contained TODO NOTE FIXME XXX
syn keyword lakeProtocol contained shell python ruby awk R

" Variable definitions
syn match lakeSetVariable "^[a-zA-Z_][a-zA-Z0-9_]* *:\?= *" contains=lakeVariable nextgroup=lakeString
syn match lakeVariable "^[a-zA-Z_][a-zA-Z0-9_]*" contained
syn match lakeString /[^ ,@"'[\]]\+\|"[^"]*"\|'[^']*'/ contained contains=lakeVariableRef containedin=lakeSetValue nextgroup=lakeString
syn match lakeEscChar /\\\(x[0-9a-fA-F]\{1,2}\|u[0-9a-fA-F]\{1,4}\|.\)/ contained containedin=lakeString

" Method blocks
syn region lakeMethodBlock start="^[a-zA-Z_][a-zA-Z0-9_]*()" end="^$" contains=lakeMethodSignature
syn match lakeMethodSignature "^[a-zA-Z_][a-zA-Z0-9_]*" contained nextgroup=lakeMethodBraces
syn match lakeMethodBraces "()" contained nextgroup=lakeOptionListPy,lakeOptionListRb,lakeOptionListAwk,lakeOptionListR,lakeOptionListSh,lakeOptionList,lakeDefaultShBlock skipwhite skipnl

" Variable references in strings
syn region lakeVariableRef start='\$\[' end='\]' contained containedin=lakeString,lakeRbBlock,rubyString,lakePyBlock,pythonString,lakeAwkBlock,awkString,lakeRBlock,rString,lakeDefaultShBlock,lakeShBLock,shCmdParenRegion,shPattern,shDeref,shDerefSimple,shDoubleQuote,shExDoubleQuote,shSingleQuote,shExSingleQuote,shHereDoc,shHereString,shEcho contains=lakeVariableName
syn match lakeVariableName "[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=lakeVariableRef

" Rule blocks
syn region lakeBlock start="[^<#, ][^<#, ]*\(, [^<#, ][^<#, ]*\)* <-" end="^$" contains=lakeRule
syn match lakeRule "[^<#, ].* <-\( *[^[<# ][^<# ]*\)*" contains=lakeTargets nextgroup=lakeOptionListPy,lakeOptionListRb,lakeOptionListAwk,lakeOptionListR,lakeOptionListSh,lakeOptionList,lakeDefaultShBlock skipwhite skipnl
syn match lakeTargets "[^<#, ][^<#, ]*\(, [^<#, ][^<#, ]*\)*" contained nextgroup=lakeRuleIdentifier contains=lakeTag,lakeString,lakeSourceSep
syn match lakeSources "\( ,?[^<[#, ][^<#, ]*\)*" contained contains=lakeTag,lakeString,lakeSourceSep
syn match lakeRuleIdentifier " <-" contained nextgroup=lakeSources
syn match lakeTargetSep ", " contained containedin=lakeTargets
syn match lakeSourceSep ", " contained containedin=lakeSources
syn region lakeOptionList start=/\v \[/ matchgroup=Snip end="\]" contained contains=lakeOption nextgroup=lakeShBlock skipwhite skipnl
syn region lakeOptionListSh start=/\v \[(shell|.* shell)/ matchgroup=Snip end="\]" contained contains=lakeOption,lakeProtocol nextgroup=lakeShBlock skipwhite skipnl
syn region lakeOptionListPy start=/\v \[(python|.* python)/ matchgroup=Snip end="\]" contained contains=lakeOption,lakeProtocol nextgroup=lakePyBlock skipwhite skipnl
syn region lakeOptionListRb start=/\v \[(ruby|.* ruby)/ matchgroup=Snip end="\]" contained contains=lakeOption,lakeProtocol nextgroup=lakeRbBlock skipwhite skipnl
syn region lakeOptionListAwk start=/\v \[(awk|.* awk)/ matchgroup=Snip end="\]" contained contains=lakeOption,lakeProtocol nextgroup=lakeAwkBlock skipwhite skipnl
syn region lakeOptionListR start=/\v \[(R|.* R)/ matchgroup=Snip end="\]" contained contains=lakeOption,lakeProtocol nextgroup=lakeRBlock skipwhite skipnl
syn match lakeOption '[a-zA-Z_][a-zA-Z0-9_]*:\|[+-][a-zA-Z_][a-zA-Z0-9_]*' contained nextgroup=lakeString

hi link lakeComment Comment
hi link lakeTodo rubyConstant
hi link lakeProtocol PreProc
hi link lakeVariable shVariable
hi link lakeVariableName shDerefSimple
hi link lakeSetIdentifier Delimiter
hi link lakeRuleIdentifier Delimiter
hi link lakeTag rubyConstant
hi link lakeString String
hi link lakeEscChar shEscape
hi link VarBraces SpecialComment
hi link lakeTargetSep Delimiter
hi link lakeSourceSep Delimiter
hi link lakeDirective PreProc
hi link lakeOption Constant

" Embedded shell region in block
syn region lakeDefaultShBlock start='^\(#.*$\n\)*[ \t][ \t]*' end='^$' contained containedin=lakeBlock,lakeMethodBlock contains=@Shell
syn region lakeShBlock start=/^\(#.*$\n\)*[ \t]/ end='^$' contained contains=@Shell
syn region lakePyBlock start=/^\(#.*$\n\)*[ \t]/ end='^$' contained contains=@Python
syn region lakeRbBlock start=/^\(#.*$\n\)*[ \t]/ end='^$' contained contains=@Ruby
syn region lakeAwkBlock start=/^\(#.*$\n\)*[ \t]/ end='^$' contained contains=@Awk
syn region lakeRBlock start=/^\(#.*$\n\)*[ \t]/ end='^$' contained contains=@R

" Embedded shell regions in strings
syn region shellBrackets matchgroup=SnipBraces start='\$(' end=')' containedin=lakeString contains=@Shell

hi link Snip SpecialComment
hi link SnipBraces SpecialComment
hi link lakeVariableRef shDerefSimple
hi link lakeMethodSignature Function
hi link lakeMethodBraces SpecialComment

" Syncing
syn sync minlines=20 maxlines=200

