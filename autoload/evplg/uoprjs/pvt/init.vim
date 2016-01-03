" evplg ([e]xtended [v]im [pl]u[g]in) - uoprjs ([u]n[o]bstrusive [pr]o[j]ect [s]upport)

" boiler plate -- prolog {{{

" "bare vi support" detection/forwarding
if has("eval")

" top-level sanity checking {{{
if !( v:version >= 700 )
	" tried to load with an unsupported version of vim
	finish
endif
" }}}

" inclusion control {{{
" prev: if exists( 'g:evplg_uoprjs_autoload_evplg_uoprjs_pvt_init_loaded' ) || ( exists( 'g:evplg_uoprjs_disable' ) && g:evplg_uoprjs_disable != 0 )
if exists( 'g:evplg_uoprjs_autoload_evplg_uoprjs_pvt_init_loaded' )
	finish
endif
let g:evplg_uoprjs_autoload_evplg_uoprjs_pvt_init_loaded = 1
" }}}

" force "compatibility" mode {{{
if &cp | set nocp | endif
" set standard compatibility options ("Vim" standard)
let s:cpo_save=&cpo
set cpo&vim
" }}}

" }}} boiler plate -- prolog

" functionality {{{

" internal setup {{{
let s:evplg_uoprjs_autoload_evplg_uoprjs_pvt_init_sfile = expand( '<sfile>' )

" support functions {{{
function s:DebugMessage_local( msg )
	" idea: echomsg '[DEBUG] evplg: ' . a:msg
	try
		return evlib#debug#DebugMessage( a:msg )
	catch " catch all
		" for now, no fallback if the function is not available
		" note: 'evlib#debug#DebugMessage()' does not currently specify a return value
		return 0
	endtry
endfunction
" }}}

function s:EVPlg_uoprjs_LocalSetup( srcfile ) abort
	let l:debug_message_prefix = 's:EVPlg_uoprjs_LocalSetup(): '
	" idea: let l:debug_message_warning_disable_library_suffix = ' -- vim.evplg.uoprjs library disabled'
	
	let l:success = !0 " true

	let l:success = l:success && ( !( exists( 'g:evplg_uoprjs_disable' ) && g:evplg_uoprjs_disable != 0 ) )
	" ref: let l:success = l:success && filereadable( a:srcfile )

	if l:success
		" check for requirements/dependencies {{{
		try
			if l:success && !( evlib#SupportsAPIVersion( 0, 1, 1 ) )
				call s:DebugMessage_local( l:debug_message_prefix . 'warning: evlib library does not suppor the requested API version' )
				let l:success = 0 " false
			endif
			if l:success && !( evlib#Init() )
				call s:DebugMessage_local( l:debug_message_prefix . 'warning: evlib library initialisation failed' )
				let l:success = 0 " false
			endif
			" TODO: add check for evplg.common ('evplg#common#...')
			" TODO: add evplg.common 'init library' function invocation
		catch " catch all
			call s:DebugMessage_local( l:debug_message_prefix . 'warning: an exception has been thrown when checking for external dependencies' )
			let l:success = 0 " false
		endtry
		" }}}
	endif

	if ! l:success
		call s:DebugMessage_local( l:debug_message_prefix . 'note: disabling vim.evplg.uoprjs library' )
	endif
	return l:success
endfunction
" }}}

function evplg#uoprjs#pvt#init#CanSource_evplg_uoprjs_modules()
	if ( ! exists( 'g:evplg_uoprjs_globalsetup_succeeded' ) )
		" note: this variable is used by our module inclusion detection function
		let g:evplg_uoprjs_globalsetup_succeeded = s:EVPlg_uoprjs_LocalSetup( s:evplg_uoprjs_autoload_evplg_uoprjs_pvt_init_sfile )
		" the function above needs to be called only once -> delete it
		delfunction s:EVPlg_uoprjs_LocalSetup
	endif
	return g:evplg_uoprjs_globalsetup_succeeded
endfunction
" }}}

" boiler plate -- epilog {{{

" restore old "compatibility" options {{{
let &cpo=s:cpo_save
unlet s:cpo_save
" }}}

" non-eval versions would skip over the "endif"
finish
endif " "eval"
" compatible mode
echoerr "the script 'autoload/evplg/uoprjs/pvt/init.vim' needs support for the following: eval"

" }}} boiler plate -- epilog

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
