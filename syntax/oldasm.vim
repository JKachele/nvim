" Vim syntax file
" Language:		GNU Assembler
" Maintainer:		Doug Kearns dougkearns@gmail.com
" Previous Maintainers: Erik Wognsen <erik.wognsen@gmail.com>
"			Kevin Dahlhausen <kdahlhaus@yahoo.com>
" Contributors:		Ori Avtalion, Lakshay Garg
" Last Change:		2020 Oct 31

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif



syn match asmType "\.long"
syn match asmType "\.ascii"
syn match asmType "\.asciiz"
syn match asmType "\.byte"
syn match asmType "\.double"
syn match asmType "\.float"
syn match asmType "\.hword"
syn match asmType "\.int"
syn match asmType "\.octa"
syn match asmType "\.quad"
syn match asmType "\.short"
syn match asmType "\.single"
syn match asmType "\.space"
syn match asmType "\.string"
syn match asmType "\.word"

syn match asmIdentifier	  "[a-z_][a-z0-9_]* ="he=e-2 nextgroup=asmAddress skipwhite
syn match asmIdentifier	  "[a-z_][a-z0-9_]{3,}"
syn match asmIdentifier	  "%[A-Za-z0-9]*"
syn match label		  "[a-z_][a-z0-9_]*:"
syn match asmConstant	  "[A-Z][a-z0-9_]*"

syn match asmImmediate	  "#\d+"	    " display
syn match asmImmediate	  "#%[01]+"	    " display
syn match asmImmediate	  "#\$[0-9A-Fa-f]+" " display
syn match asmAddress	  "\d+"		    " display
syn match asmAddress	  "%[01]+"	    " display
syn match asmAddress	  "\$[0-9A-Fa-f]+"  " display

syn keyword asmTodo contained TODO FIXME XXX NOTE

syn region comment start=";" end="$" contains=asmTodo
syn region string start="\"" end="\""

syn match instructions "adc|and|asl"
syn match instructions "bbr|bbs|bcc|bcs|beq|bit|bmi|bne|bpl|bra|brk|bvc|bvs"
syn match instructions "clc|cld|cli|clv|cmp|cpx|cpy"
syn match instructions "dec|dex|dey"
syn match instructions "eor"
syn match instructions "inc|inx|iny"
syn match instructions "jmp|jsr"
syn match instructions "lda|ldx|ldy|lsr"
syn match instructions "nop"
syn match instructions "ora"
syn match instructions "pha|php|phx|phy|pla|plp|plx|ply"
syn match instructions "rmb|rol|ror|rti|rts"
syn match instructions "sbc|sec|sed|sei|smb|sta|stx|sty|stz"
syn match instructions "tax|tay|trb|tsb|tsx|txa|txs|tya"
syn match instructions "wai"


syn keyword instructions nextgroup=asmIdentifier skipwhite

hi def link label	    Label
hi def link asmType	    Type
hi def link asmIdentifier   Identifier
hi def link asmConstant	    Constant
hi def link asmImmediate    Number
hi def link asmAddress	    Number
hi def link asmTodo	    Todo
hi def link comment	    Comment
hi def link string	    String
hi def link instructions    Type

let b:current_syntax = "oldasm"
