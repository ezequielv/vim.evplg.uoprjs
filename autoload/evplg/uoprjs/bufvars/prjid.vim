
" include/processing guard {{{
if ! evplg#uoprjs#pvt#module#ShouldSourceThisModule( 'autoload_evplg_uoprjs_bufvars_prjid' )
	finish
endif
" }}}

" to aid in "autoload" module detection
let g:evplg#uoprjs#bufvars#prjid#module_loaded = !0

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_pref' )
	let g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_pref = g:evplg#uoprjs#bufvars#common#evlib_buftagvar_key_pref . 'prjid_'
endif

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_prjidmain' )
	let g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_prjidmain = g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_pref . 'main'
endif

"? " support functions {{{
"? function s:DebugMessage( msg )
"? 	return evplg#uoprjs#pvt#debug#DebugMessage( a:msg )
"? endfunction
"? " }}}

function evplg#uoprjs#bufvars#prjid#GetMainProjectId( ... )
	return (
				\		evlib#buftagvar#HasTaggedVar( g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_prjidmain )
				\		?	evlib#buftagvar#GetTaggedVar( g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_prjidmain )
				\		:	( ( a:0 > 0 ) ? a:1 : '' )
				\	)
endfunction

function evplg#uoprjs#bufvars#prjid#SetMainProjectId( prjid )
	call evlib#buftagvar#SetTaggedVar( g:evplg#uoprjs#bufvars#prjid#evlib_buftagvar_key_prjidmain, a:prjid )
endfunction

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
