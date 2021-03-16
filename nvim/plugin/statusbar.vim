"
" kiedtl's vim status bar, for the most part
" stolen from NerdyPepper and addy-fe :^)
"
" https://github.com/kiedtl/dotfiles
"

scriptencoding utf-8

let g:curmode={
	\ 'n'  : 'NORMAL',
	\ 'no' : 'N·OPERATOR PENDING',
	\ 'v'  : 'VISUAL',
	\ 'V'  : 'V·LINE',
	\ '^V' : 'V·BLOCK',
	\ 's'  : 'SELECTION',
	\ 'S'  : 'S·LINE',
	\ '^S' : 'S·BLOCK',
	\ 'i'  : 'INSERT',
	\ 'R'  : 'REPLACE',
	\ 'Rv' : 'V·REPLACE',
	\ 'c'  : 'COMMAND',
	\ 'cv' : 'VIM EX',
	\ 'ce' : 'EX',
	\ 'r'  : 'PROMPT',
	\ 'rm' : 'MOAR',
	\ 'r?' : 'CONFIRM',
	\ '!'  : 'SHELL',
	\ 't'  : 'TERMINAL'}

function! StatusLine() abort
	let l:line=''

	" u/Nerdypepper's theme
	let l:line.='%8*%1*%{g:curmode[mode()]}% %9* %2*'
	let l:line.=GitBranch()
	let l:line.='%{ReadOnly()}% %{Modified()}% %7*%4* '
	let l:line.=' %= %2*'
	let l:line.='%7*%2*Ln %l Col %v '
	let l:line.='%9*%1*%{FileType()}% %8*'

	" Emacs-esque theme (I guess? I cannot remember the
	" last time I was forced to use that monstrosity)
	"if &filetype ==# 'help' || &filetype ==# 'man'
	"	" help or man pages
	"	let l:line.='%1* %l%2*:%v'
	"	let l:line.='%1* %t'
	"	let l:line.='%='
	"	let l:line.='%3*%P '
	"	let l:line.='%1*<%{g:curmode[mode()]}% >  '
	"	let l:line.='%1*(%{FileType()}% )'
	"else
	"	let l:line.='%1* %l%2*:%v '
	"	let l:line.='%2*%{FileEncoding()}% %{LineEndings()}% '
	"	let l:line.='%3*%{EmacsModRO()}% %1* %t '
	"	let l:line.='%='
	"	let l:line.='%3*%P '
	"	let l:line.='%1*<%{g:curmode[mode()]}% >  '
	"	let l:line.='%3*:%{GitBranch()}%  '
	"	let l:line.='%1*(%{FileType()}% )'
	"endif
	"let l:line.='                   '

	return l:line
endfunction

function! LinePercentageBar()
	let l:percentage=line('.') * 100 / line('$')

	let l:percentline=''
	let l:percentline.=l:percentage
	let l:percentline.='%% '

	for i in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
		if (l:percentage/10) > i
			let l:percentline.='%2*|'
		else
			let l:percentline.='%2*|'
		endif
	endfor

	let l:percentline.=' '
	return l:percentline
endfunction

function! GitBranch() abort
	let l:command=''
	let l:command.="sh -c 'cd "
	let l:command.=SessionDir()
	let l:command.=" && branch -n'"
	return system(l:command)
endfunction

function! FileType() abort
	if len(&filetype) == 0
		return 'text'
	endif

	return tolower(&filetype)
endfunction

function! SessionDir() abort
	if len(argv()) > 0
		return fnamemodify(argv()[0], ':p:h')
	endif

	return getcwd()
endfunction

function! ReadOnly() abort
	if !&modifiable && &readonly
		return '[RO] '
	elseif &modifiable && &readonly
		return '[MRO] '
	elseif !&modifiable && !&readonly
		return ''
	else
		return ''
	endif
endfunction

function! Modified() abort
	if &modified
		return '[+] '
	else
		return ''
	endif
endfunction

function! EmacsModRO() abort
	if &readonly
		if &modified
			return '%*'
		else
			return '%%'
		endif
	else
		if &modified
			return '**'
		else
			return '--'
		endif
	endif
endfunction

function! LineEndings() abort
	if &fileformat ==# 'unix'
		return ':'
	elseif &fileformat ==# 'dos'
		return '(DOS)'
	elseif &fileformat ==# 'mac'
		return '(MAC)'
	else
		return '(???)'
	endif
endfunction

function! FileEncoding() abort
	if &fileencoding ==# 'ucs-bom'
		return 'U'
	elseif &fileencoding ==# 'utf-8' || &fileencoding ==# ''
		return 'u'
	elseif &fileencoding ==# 'default'
		return 'd'
	elseif &fileencoding ==# 'latin1'
		return '1'
	else
		return '?'
	endif
endfunction

highlight user1  ctermbg=3    ctermfg=0    cterm=NONE
highlight user2  ctermbg=8    ctermfg=15   cterm=NONE
highlight user3  ctermbg=8    ctermfg=7    cterm=bold
highlight user4  ctermbg=NONE ctermfg=NONE cterm=NONE
highlight user7  ctermbg=NONE ctermfg=8    cterm=NONE
highlight user8  ctermbg=NONE ctermfg=3    cterm=NONE
highlight user9  ctermbg=8    ctermfg=3    cterm=NONE

set statusline=%!StatusLine()
