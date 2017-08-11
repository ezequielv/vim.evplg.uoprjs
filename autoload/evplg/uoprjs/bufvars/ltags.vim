
" include/processing guard {{{
if ! evplg#uoprjs#pvt#module#ShouldSourceThisModule( 'autoload_evplg_uoprjs_bufvars_ltags' )
	finish
endif
" }}}

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_pref' )
	let g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_pref = g:evplg#uoprjs#bufvars#common#evlib_buftagvar_key_pref . 'ltags_'
endif

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags' )
	" prev: let g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags = 'evplg_uoprjs_bufvars_ltags_projects'
	let g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags = g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_pref . 'ltags'
endif

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount' )
	let g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount = g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_pref . 'chgcount'
endif

" support functions {{{
function s:DebugMessage( msg )
	return evplg#uoprjs#pvt#debug#DebugMessage( a:msg )
endfunction
" }}}

" ref: function evlib#buftagvar#SetTaggedVar( var_key, var_value )

function evplg#uoprjs#bufvars#ltags#EnsureInit()
	if ! evlib#buftagvar#HasTaggedVar( g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount )
		call evlib#buftagvar#SetTaggedVar( g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount, 0 )
	endif
endfunction

function s:InitialiseBufferVars()
	if ! evlib#buftagvar#HasTaggedVar( g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags )
		call evplg#uoprjs#bufvars#ltags#EnsureInit()
		call evlib#buftagvar#SetTaggedVar( g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags, evlib#strset#Create() )
	endif
endfunction

function s:IncrementChangeCount()
	call evlib#buftagvar#SetTaggedVar(
				\		g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount,
				\		evplg#uoprjs#bufvars#ltags#GetChangeCount() + 1
				\	)
endfunction

function s:GetTagsInstance()
	call s:InitialiseBufferVars()
	" get instance variable (reference)
	return evlib#buftagvar#GetTaggedVar( g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags )
endfunction

function evplg#uoprjs#bufvars#ltags#GetChangeCount()
	call evplg#uoprjs#bufvars#ltags#EnsureInit()
	return evlib#buftagvar#GetTaggedVar(
				\		g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount
				\	)
endfunction

function evplg#uoprjs#bufvars#ltags#AddTags( a_tag_or_tags )
	" get instance variable (reference)
	let l:tags_instance = s:GetTagsInstance()
	call s:IncrementChangeCount()
	" operate on it
	call evlib#strset#UnionUpdate( l:tags_instance, evplg#uoprjs#bufvars#common#GetArgAsList( a:a_tag_or_tags ) )
	return l:tags_instance
endfunction

" TODO: implement flags to either copy it or return the original object
function evplg#uoprjs#bufvars#ltags#GetTagsAsStrSet( ... )
	" get instance variable (reference)
	let l:tags_instance = s:GetTagsInstance()
	return l:tags_instance
endfunction

" convenience function(s)
function evplg#uoprjs#bufvars#ltags#HasTag( a_tag )
	return evlib#strset#HasElement( s:GetTagsInstance(), a:a_tag )
endfunction

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
