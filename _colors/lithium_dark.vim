" lithium_dark color scheme
set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "lithium_dark"


"hi Example         ctermfg=NONE        ctermbg=NONE        cterm=NONE

" General colors
hi Normal           ctermfg=255        ctermbg=NONE        cterm=NONE
hi NonText          ctermfg=235       ctermbg=NONE        cterm=NONE

hi Cursor           ctermfg=black       ctermbg=red         cterm=NONE
hi LineNr           ctermfg=235       ctermbg=233        cterm=NONE

hi VertSplit        ctermfg=233       ctermbg=233        cterm=NONE
hi StatusLine       ctermfg=235       ctermbg=233         cterm=NONE
hi StatusLineNC     ctermfg=27        ctermbg=233        cterm=BOLD

hi Folded           ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi Title            ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi Visual           ctermfg=NONE       ctermbg=237       cterm=NONE

hi SpecialKey       ctermfg=235        ctermbg=NONE        cterm=NONE

hi WildMenu         ctermfg=black       ctermbg=yellow      cterm=NONE
hi PmenuSbar        ctermfg=black       ctermbg=white       cterm=NONE
hi Ignore           ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi Error            ctermfg=white       ctermbg=red         cterm=NONE
hi ErrorMsg         ctermfg=white       ctermbg=red         cterm=NONE
hi WarningMsg       ctermfg=white       ctermbg=red         cterm=NONE

" Message displayed in lower left, such as --INSERT--
hi ModeMsg          ctermfg=162     ctermbg=NONE        cterm=BOLD

if version >= 700 " Vim 7.x specific colors
  hi CursorLine     ctermfg=NONE        ctermbg=234        cterm=NONE
  hi CursorColumn   ctermfg=NONE        ctermbg=NONE        cterm=NONE
  hi MatchParen     ctermfg=NONE        ctermbg=red         cterm=NONE
  hi Pmenu          ctermfg=NONE        ctermbg=16        cterm=NONE
  hi PmenuSel       ctermfg=NONE        ctermbg=NONE        cterm=NONE
  hi Search         ctermfg=white       ctermbg=black       cterm=underline
endif

hi DiffAdd          cterm=bold          ctermbg=darkgreen   ctermfg=black
hi DiffChange       cterm=bold          ctermbg=gray        ctermfg=black
hi DiffText         cterm=bold          ctermbg=blue        ctermfg=black
hi DiffDelete       cterm=bold          ctermbg=darkred     ctermfg=black


" Syntax highlightin
hi Comment          ctermfg=236           ctermbg=NONE        cterm=NONE
hi String           ctermfg=82       ctermbg=NONE        cterm=NONE
hi Number           ctermfg=199     ctermbg=NONE        cterm=NONE

hi Keyword          ctermfg=199     ctermbg=NONE        cterm=NONE
hi PreProc          ctermfg=14        ctermbg=NONE        cterm=NONE
hi Conditional      ctermfg=199     ctermbg=NONE        cterm=NONE

hi Todo             ctermfg=196         ctermbg=NONE        cterm=NONE
hi Constant         ctermfg=51        ctermbg=NONE        cterm=NONE

hi Identifier       ctermfg=199     ctermbg=NONE        cterm=NONE
hi Function         ctermfg=236       ctermbg=NONE        cterm=NONE
hi Type             ctermfg=51        ctermbg=NONE        cterm=NONE
hi Statement        ctermfg=25        ctermbg=NONE        cterm=NONE

hi Special          ctermfg=15       ctermbg=NONE        cterm=NONE
hi Delimiter        ctermfg=28       ctermbg=NONE        cterm=NONE
hi Operator         ctermfg=15       ctermbg=NONE        cterm=NONE

hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special

" Special for Ruby
hi rubyClass            	ctermfg=199		cterm=NONE
hi rubyMethodBlock      	ctermfg=white		cterm=NONE
hi rubyOperator         	ctermfg=white
hi rubyDefine           	ctermfg=199		cterm=NONE
hi rubyControl			ctermfg=199		cterm=NONE
hi rubyBlockParameter		ctermfg=25		cterm=NONE
hi rubyFunction			ctermfg=white
hi rubyInstanceVariable 	ctermfg=25		cterm=NONE
hi rubyRailsUserClass 		ctermfg=98
hi rubyClassDeclaration		ctermfg=15
hi rubyBlock			ctermfg=white
hi rubyLocalVariableOrMethod	ctermfg=white
hi rubyConditional    		ctermfg=199		cterm=NONE
hi rubyInterpolation		ctermfg=28		cterm=NONE
hi rubyInterpolationDelimiter	ctermfg=118		cterm=NONE
hi rubyConstant			ctermfg=99		cterm=NONE
hi rubyRailsMethod              ctermfg=247
hi rubySymbol                   ctermfg=91
hi rubyBoolean			ctermfg=128
hi rubyRegexpParens		ctermfg=199
hi rubyRegexp      		ctermfg=199
hi rubyRegexpDelimiter          ctermfg=199
hi rubyRegexpBrackets           ctermfg=199
hi rubyRegexpEscape             ctermfg=25
hi rubyPseudoVariable           ctermfg=25
hi rubyPseudoOperator           ctermfg=199
hi rubyModule                   ctermfg=199
hi rubyAccess			ctermfg=250

" Special for SCSS
hi sassClass                    ctermfg=237
hi cssBoxProp                   ctermfg=237
hi cssRenderProp                ctermfg=237
hi cssUIAttr                    ctermfg=237
hi cssColorProp			ctermfg=244
hi cssColor			ctermfg=98

" Special for XML
hi link xmlTag          Keyword
hi link xmlTagName      Conditional
hi link xmlEndTag       Identifier

" Special for HTML
hi link htmlTag         Keyword
hi link htmlTagName     Conditional
hi link htmlEndTag      Identifier

" Special for Javascript
hi link javaScriptNumber      Number

" Special for PHP
hi phpVarSelector    ctermfg=blue
hi phpIdentifier     ctermfg=blue
hi phpMemberSelector ctermfg=magenta
hi phpStatement      ctermfg=magenta
hi phpFunctions      ctermfg=black
hi phpType           ctermfg=magenta
