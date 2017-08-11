" include/processing guard {{{
if ! evplg#uoprjs#pvt#module#ShouldSourceThisModule( 'autoload_evplg_uoprjs_bufvars_common' )
	finish
endif
" }}}

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#common#evlib_buftagvar_key_pref' )
	let g:evplg#uoprjs#bufvars#common#evlib_buftagvar_key_pref = 'evplg_uoprjs_bufvars_'
endif

" TODO: remove this function: use evlib#stdtype#AsTopLevelList() instead
function evplg#uoprjs#bufvars#common#GetArgAsList( a_value )
	return evlib#stdtype#AsTopLevelList( a:a_value )
endfunction

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
