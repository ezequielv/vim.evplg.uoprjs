finish " FIXME: remove this line once the code is usable

" include/processing guard {{{
if ! evplg#uoprjs#pvt#module#ShouldSourceThisModule( 'autoload_evplg_uoprjs_global_taggeddict' )
	finish
endif
" }}}

" force "compatibility" mode {{{
if &cp | set nocp | endif
" set standard compatibility options ("Vim" standard)
let s:cpo_save=&cpo
set cpo&vim
" }}}

if ( ! exists( 'g:evplg#uoprjs#global#taggeddict#main_dict' ) )
	let g:evplg#uoprjs#global#taggeddict#main_dict = {}
endif

" support functions {{{
function s:DebugMessage( msg )
	return evplg#uoprjs#pvt#debug#DebugMessage( a:msg )
endfunction
" }}}

function evplg#uoprjs#global#taggeddict#HasKey( main_key, elem_key )
	return has_key( g:evplg#uoprjs#global#taggeddict#main_dict, a:main_key )
				\	&& has_key( g:evplg#uoprjs#global#taggeddict#main_dict[ a:main_key ], a:elem_key )
endfunction

function evplg#uoprjs#global#taggeddict#SetValue( main_key, elem_key, elem_value )
	if ( ! has_key( g:evplg#uoprjs#global#taggeddict#main_dict, a:main_key ) )
		let g:evplg#uoprjs#global#taggeddict#main_dict[ a:main_key ] = {}
	endif
	let g:evplg#uoprjs#global#taggeddict#main_dict[ a:main_key ][ a:elem_key ] = a:elem_value
endfunction

function evplg#uoprjs#global#taggeddict#GetValue( main_key, elem_key, defvalue )
	" optimisation: yes, we're creating a dictionary maybe unnecessarily, but
	" we avoid more function calls this way.
	return get( get( g:evplg#uoprjs#global#taggeddict#main_dict, main_key, {} ), a:elem_key, a:defvalue )
endfunction

" restore old "compatibility" options {{{
let &cpo=s:cpo_save
unlet s:cpo_save
" }}}

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
