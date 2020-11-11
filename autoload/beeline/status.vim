" vim: sw=8 ts=8 noet :

" utility funcs {{{
function! s:ffenc()
	if strpart(&fenc, 0, 4) == 'utf-'
		let ffenc = 'u' . strpart(&fenc, 4)
	else
		let ffenc = &fenc
	endif

	if strlen(&ff) > 0 && &ff != 'unix'
		let ffenc .= '[' . &ff . ']'
	endif

	return ffenc
endfunction

function! s:basename(input)
	let l:parts = split(a:input, '/')
	return l:parts[-1]
endfunction

function! s:get_mode()
	return get(s:modes, mode(), mode())
endfunction

" modes list adapted from vim-airline
" MIT License. Copyright (c) 2013-2020 Bailey Ling et al.
let s:modes = {
	\ 'n':  'NORMAL',
	\ 'i':  'INSERT',
	\ 'R':  'REPLACE',
	\ 'v':  'VISUAL',
	\ 'V':  'V-LINE',
	\ '': 'V-BLOCK',
	\ 's':  'SELECT',
	\ 'S':  'S-LINE',
	\ '': 'S-BLOCK',
	\ 't':  'TERM',
	\ 'c':  'COMMAND',
	\ }
" }}}

function! beeline#status#statusline()
	let left = []
	call add(left, s:get_mode())
	call add(left, s:basename(getcwd()))
	call add(left, '%<' . pathshorten('%f') . '%m')

	let right = []
	call add(right, &ft)
	call add(right, s:ffenc())
	call add(right, &sw . '/' . &ts . '/' . &et)
	call add(right, '%03l:%02v')

	return join(left) . '%= ' . join(right)
endfunction
