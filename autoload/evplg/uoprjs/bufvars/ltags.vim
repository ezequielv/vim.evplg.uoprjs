
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

function evplg#uoprjs#bufvars#ltags#EnsureInit( ... )
	let l:var_key = g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount
	if !( ( a:0 == 0 ) ? evlib#buftagvar#HasTaggedVar( l:var_key ) : evlib#buftagvar#HasTaggedVar( l:var_key, a:1 ) )
		let l:var_value = 0
		" NOTE: almost duplicated code (differs only in passing 'a:1' when needed)
		if ( a:0 == 0 )
			call evlib#buftagvar#SetTaggedVar( l:var_key, l:var_value )
		else
			call evlib#buftagvar#SetTaggedVar( l:var_key, l:var_value, a:1 )
		endif
	endif
endfunction

function s:InitialiseBufferVars( ... )
	let l:var_key = g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags
	if !( ( a:0 == 0 ) ? evlib#buftagvar#HasTaggedVar( l:var_key ) : evlib#buftagvar#HasTaggedVar( l:var_key, a:1 ) )
		let l:var_value = evlib#strset#Create()
		" NOTE: almost duplicated code (differs only in passing 'a:1' when needed)
		if ( a:0 == 0 )
			call evplg#uoprjs#bufvars#ltags#EnsureInit()
			call evlib#buftagvar#SetTaggedVar( l:var_key, l:var_value )
		else
			call evplg#uoprjs#bufvars#ltags#EnsureInit( a:1 )
			call evlib#buftagvar#SetTaggedVar( l:var_key, l:var_value, a:1 )
		endif
	endif
endfunction

function s:IncrementChangeCount( ... )
	let l:var_key = g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount
	let l:var_delta = 1
	" NOTE: almost duplicated code (differs only in passing 'a:1' when needed)
	if ( a:0 == 0 )
		call evlib#buftagvar#SetTaggedVar(
					\		l:var_key,
					\		evplg#uoprjs#bufvars#ltags#GetChangeCount() + l:var_delta
					\	)
	else
		call evlib#buftagvar#SetTaggedVar(
					\		l:var_key,
					\		evplg#uoprjs#bufvars#ltags#GetChangeCount( a:1 ) + l:var_delta,
					\		a:1
					\	)
	endif
endfunction

function s:GetTagsInstance( ... )
	let l:var_key = g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_ltags
	" NOTE: almost duplicated code (differs only in passing 'a:1' when needed)
	if ( a:0 == 0 )
		call s:InitialiseBufferVars()
		" get instance variable (reference)
		return evlib#buftagvar#GetTaggedVar( l:var_key )
	else
		call s:InitialiseBufferVars( a:1 )
		" get instance variable (reference)
		return evlib#buftagvar#GetTaggedVar( l:var_key, a:1 )
	endif
endfunction

function evplg#uoprjs#bufvars#ltags#GetChangeCount( ... )
	let l:var_key = g:evplg#uoprjs#bufvars#ltags#evlib_buftagvar_key_chgcount
	" NOTE: almost duplicated code (differs only in passing 'a:1' when needed)
	if ( a:0 == 0 )
		call evplg#uoprjs#bufvars#ltags#EnsureInit()
		return evlib#buftagvar#GetTaggedVar( l:var_key )
	else
		call evplg#uoprjs#bufvars#ltags#EnsureInit( a:1 )
		return evlib#buftagvar#GetTaggedVar( l:var_key, a:1 )
	endif
endfunction

" FIXME: add support for the 'a:1' for the bufnr() ('...') to every appopriate function

function evplg#uoprjs#bufvars#ltags#AddTags( a_tag_or_tags, ... )
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
