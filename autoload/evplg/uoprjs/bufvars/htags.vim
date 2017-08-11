
" include/processing guard {{{
if ! evplg#uoprjs#pvt#module#ShouldSourceThisModule( 'autoload_evplg_uoprjs_bufvars_htags' )
	finish
endif
" }}}

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_pref' )
	let g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_pref = g:evplg#uoprjs#bufvars#common#evlib_buftagvar_key_pref . 'htags_'
endif

" provide a default for the variable checked for just below
" prev if ! exists( 'g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_tagsmap' )
" prev 	let g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_tagsmap = g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_pref . 'htags'
" prev endif
let g:evplg#uoprjs#bufvars#htags#tagsmap = {}
let g:evplg#uoprjs#bufvars#htags#tagsmap_chgcount = 0

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_ltags_chgcount' )
	let g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_ltags_chgcount = g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_pref . 'ltags_chgcount'
endif

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_tagsmap_chgcount' )
	let g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_tagsmap_chgcount = g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_pref . 'tagsmap_chgcount'
endif

" provide a default for the variable checked for just below
if ! exists( 'g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_htags_strset' )
	let g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_htags_strset = g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_pref . 'htags_strset'
endif

" ref: function evlib#buftagvar#SetTaggedVar( var_key, var_value )

" support functions {{{
function s:DebugMessage( msg )
	return evplg#uoprjs#pvt#debug#DebugMessage( a:msg )
endfunction
" }}}

function s:SetHTagsDeltaToLtagsChangeCount( delta_value )
	call evlib#buftagvar#SetTaggedVar(
				\		g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_ltags_chgcount,
				\		evplg#uoprjs#bufvars#ltags#GetChangeCount() + a:delta_value
				\	)
endfunction

function s:SetHTagsDeltaToTagsMappingChangeCount( delta_value )
	call evlib#buftagvar#SetTaggedVar(
				\		g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_tagsmap_chgcount,
				\		g:evplg#uoprjs#bufvars#htags#tagsmap_chgcount + a:delta_value
				\	)
endfunction

" prev: function s:MarkTagsMapCacheAsDirty()
" prev: 	" make sure that the initial value for the "snapshot" cached value will trigger cache regeneration.
" prev: 	return s:SetHTagsDeltaToLtagsChangeCount( -1 )
" prev: endfunction

function evplg#uoprjs#bufvars#htags#EnsureInit()
	if ! evlib#buftagvar#HasTaggedVar( g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_ltags_chgcount )
		" prev: call s:MarkTagsMapCacheAsDirty()
		call s:SetHTagsDeltaToLtagsChangeCount( -1 )
		call s:SetHTagsDeltaToTagsMappingChangeCount( -1 )
	endif
endfunction

function s:InitialiseBufferVars()
	call evplg#uoprjs#bufvars#htags#EnsureInit()
endfunction

function s:GetTagMappings()
	" prev: call s:InitialiseBufferVars()
	" prev: " get instance variable (reference)
	" prev: return evlib#buftagvar#GetTaggedVar( g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_tagsmap )
	return g:evplg#uoprjs#bufvars#htags#tagsmap
endfunction

function s:UpdateTagMappingsChangeCount()
	let g:evplg#uoprjs#bufvars#htags#tagsmap_chgcount += 1
endfunction

" for each key in a_tag_mapping, the internal "tag mapping" dictionaries will be modified with the values specified for each element, according to the optional operation flags.
function evplg#uoprjs#bufvars#htags#ModifyTagMappings( tag_mappings, ... )
	" get instance variable (reference)
	let l:tags_mapping_instance = s:GetTagMappings()
	let l:flags = ( ( a:0 > 0 ) ? a:1 : '' )
	" operations: [a]dd (default), [s]et (replace existing), [r]emove
	let l:flag_operation = evlib#strflags#GetFlagValues( l:flags, 'asr', '1t', 'a' )

	call s:UpdateTagMappingsChangeCount()
	" operate on it
	for l:items_now in items( a:tag_mappings )
		let l:item_key = l:items_now[ 0 ]
		" TODO: use evlib#stdtype#AsTopLevelList() instead
		let l:item_val = evplg#uoprjs#bufvars#common#GetArgAsList( l:items_now[ 1 ] )

		" optionally create an strset for this key
		if ( ! has_key( l:tags_mapping_instance, l:item_key ) )
			let l:tags_mapping_instance[ l:item_key ] = evlib#strset#Create()
		endif
		" operate on the existing strset instance from here
		let l:map_strflags_dst = l:tags_mapping_instance[ l:item_key ]
		" perform the required operation
		if l:flag_operation == 'a' || l:flag_operation == 's'
			if l:flag_operation == 's'
				call evlib#strset#Clear( l:map_strflags_dst )
			endif
			call evlib#strset#Add( l:map_strflags_dst, l:item_val )
		elseif l:flag_operation == 'r'
			throw 'FIXME: remove operation not implemented yet'
		else
			throw 'internal error: unrecognised operation flag: ' . l:flag_operation
		endif
		" no need to set the result back: we've changed the instance in-place.
	endfor
endfunction

function s:IsBufferHTagsCacheUpToDate()
	return
				\	(	evlib#buftagvar#GetTaggedVar(
				\				g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_ltags_chgcount
				\			)
				\		==
				\		evplg#uoprjs#bufvars#ltags#GetChangeCount()
				\	)
				\	&&
				\	(	evlib#buftagvar#GetTaggedVar(
				\				g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_tagsmap_chgcount
				\			)
				\		==
				\		g:evplg#uoprjs#bufvars#htags#tagsmap_chgcount
				\	)
endfunction

function evplg#uoprjs#bufvars#htags#GetTagsAsStrSet()
	call s:InitialiseBufferVars()
	" return cached instance, if possible
	if s:IsBufferHTagsCacheUpToDate()
		call s:DebugMessage( 'evplg#uoprjs#bufvars#htags#GetTagsAsStrSet(): returning from cache' )
		return evlib#strset#Copy(
					\		evlib#buftagvar#GetTaggedVar(
					\				g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_htags_strset
					\			)
					\	)
	endif

	" get instance variable (reference)
	let l:tags_mapping_instance = s:GetTagMappings()
	let l:tags_processed = evlib#strset#Create()
	let l:tags_result = evlib#strset#Create()
	let l:tags_toprocess = evlib#strset#AsList( evplg#uoprjs#bufvars#ltags#GetTagsAsStrSet() )

	while ( ! empty( l:tags_toprocess ) )
		" prev: call s:DebugMessage( 'l:tags_toprocess: ' . string(l:tags_toprocess) )
		" get first element, remove it from the list
		let l:tag_now = remove( l:tags_toprocess, 0 )
		" if the element has not been processed, process it now
		if ( ! evlib#strset#HasElement( l:tags_processed, l:tag_now ) )
			if has_key( l:tags_mapping_instance, l:tag_now )
				let l:tags_dest_now = l:tags_mapping_instance[ l:tag_now ]
				" add the expanded list to the result
				call evlib#strset#UnionUpdate( l:tags_result, l:tags_dest_now )
				" in order to get the expanded tags from each of these, we need to add this to the "to process" list
				let l:tags_toprocess += evlib#strset#AsList( l:tags_dest_now )
			endif
			" a "source" tag is also recorded in the result
			call evlib#strset#Add( l:tags_result, l:tag_now )
			" record this tag as having been processed
			call evlib#strset#Add( l:tags_processed, l:tag_now )
		endif
	endwhile

	" record this in the cache
	call evlib#buftagvar#SetTaggedVar(
				\		g:evplg#uoprjs#bufvars#htags#evlib_buftagvar_key_htags_strset,
				\		evlib#strset#Copy( l:tags_result )
				\	)
	" and update the cache metadata
	call s:SetHTagsDeltaToLtagsChangeCount( 0 )
	call s:SetHTagsDeltaToTagsMappingChangeCount( 0 )

	call s:DebugMessage( 'evplg#uoprjs#bufvars#htags#GetTagsAsStrSet(): returning calculated strset' )
	return l:tags_result
endfunction

" convenience function(s)
function evplg#uoprjs#bufvars#htags#HasTag( a_tag )
	" note: no need (called by invoked function): call s:InitialiseBufferVars()
	return evlib#strset#HasElement( evplg#uoprjs#bufvars#htags#GetTagsAsStrSet(), a:a_tag )
endfunction

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
