" FILENAME: indent-guide.vim
" AUTHOR: Zachary Krepelka
" DATE: Sunday, January 28th, 2024
" ORIGIN: https://github.com/zachary-krepelka/vim-indent-guide
" DESCRIPTION: An indentation guide for the Vim text editor
" UPDATED: Thursday, February 1st, 2024 at 9:09 PM

" Variables {{{1

if exists('g:loaded_indent_guide')

	finish

endif

let g:loaded_indent_guide = 1

let s:bars  = get(g:, 'indent_guide_bar_count',    10)
let s:quiet = get(g:, 'indent_guide_silence',       0)
let s:state = get(g:, 'indent_guide_startup_state', 0)

let &textwidth = s:bars * &tabstop

" Highlights {{{1

if !hlexists('LeadingTabs')

	highlight LeadingTabs NONE

endif

" Commands {{{1

command! -range=% -nargs=? Tabify  <line1>,<line2> call s:tabify(<f-args>)
command! -range=% -nargs=? Spacify <line1>,<line2> call s:spacify(<f-args>)

" Functions {{{1

function! s:is_active()

	return s:state

endfunction

function! s:toggle()

	let s:state = !s:state

	call s:{s:state ? 'draw' : 'clear'}IndentGuide()

	" See :help curly-braces-function-names

endfunction

function! s:guard()

	if !s:state
		return 1
	endif

	if &paste == 1

		echo 'Please turn off Vim''s paste setting to use this feature.'

		return 1

	endif

	return 0

endfunction

function! s:adjustBarSpread(flag)

	if s:guard()
		return
	endif

	let l:direction = a:flag ? 1 : -1

	let l:candidate = &tabstop + l:direction

	if l:candidate >= 1

		let &tabstop = l:candidate

		let &textwidth = &tabstop * s:bars

		call s:drawIndentGuide()

	endif

endfunction

function! s:adjustBarCount(flag)

	if s:guard()
		return
	endif

	let l:direction = a:flag ? 1 : -1

	let l:candidate = &textwidth + &tabstop  * l:direction

	if l:candidate >= &tabstop

		let &textwidth = l:candidate

		let s:bars += l:direction

		call s:drawIndentGuide()

	endif

endfunction

function! s:clearIndentGuide()

	match none
	set colorcolumn=

endfunction

function! s:drawIndentGuide()

	if s:guard()
		return
	endif

	match LeadingTabs /^\t\+/

	let &colorcolumn = join(range(&tabstop, &textwidth, &tabstop), ',')

	if exists('g:indent_guide_forced_color')

		" Specifically so that my plugin works with goyo.vim

		execute 'highlight ColorColumn ctermbg=' ..
		\
		\	g:indent_guide_forced_color

	endif

	if !s:quiet

		echo 'tw' &textwidth 'ts' &tabstop 'bars' s:bars

	endif

endfunction

function! s:tabify(num = &tabstop) range

	let l:save = &list

	set list

	execute
	\
	\	a:firstline .. ',' .. a:lastline ..
	\
	\	's/\(^\s*\)\@<=' .. repeat(' ', a:num) .. '/\t/ceg'

	if !l:save
		set nolist
	endif

endfunction

function! s:spacify(num = &tabstop) range

	let l:save = &list

	set list

	execute
	\
	\	a:firstline .. ',' .. a:lastline ..
	\
	\	's/\(^\s*\)\@<=\t/\=repeat(" ", a:num)/ceg'

	if !l:save
		set nolist
	endif

endfunction

" Mappings {{{1

nnoremap <expr> <unique> <silent> <Down>
\
\	<SID>is_active() ? <SID>adjustBarSpread(0) : '<Down>'
\
nnoremap <expr> <unique> <silent> <Up>
\
\	<SID>is_active() ? <SID>adjustBarSpread(1) : '<Up>'
\
nnoremap <expr> <unique> <silent> <Left>
\
\	<SID>is_active() ? <SID>adjustBarCount(0)  : '<Left>'
\
nnoremap <expr> <unique> <silent> <Right>
\
\	<SID>is_active() ? <SID>adjustBarCount(1)  : '<Right>'
\
nnoremap <silent> <Leader>i :call <SID>toggle()<CR>
