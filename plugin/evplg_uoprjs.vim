" evplg ([e]xtended [v]im [pl]u[g]in) - uoprjs ([u]n[o]bstrusive [pr]o[j]ect [s]upport)
" main plugin script

" boiler plate -- prolog {{{

" "bare vi support" detection/forwarding
if has("eval")

" inclusion control {{{
if exists( 'g:evplg_uoprjs_loaded' ) || ( exists( 'g:evplg_uoprjs_disable' ) && g:evplg_uoprjs_disable != 0 )
	finish
endif
let g:evplg_uoprjs_loaded = 1
" }}}

" top-level sanity checking {{{
if !( v:version >= 700 )
	" tried to load with an unsupported version of vim
	finish
endif
" }}}
" check for requirements/dependencies {{{
try
	if !( evlib#SupportsAPIVersion( 0, 1, 0 ) )
		" does not have the right evlib version installed
		" TODO: report this as warning/error
		finish
	endif
	if !( evlib#Init() )
		" failed to initialise evlib
		finish
	endif
catch
	" does not have evlib installed, or initialising/using the library has
	"  failed
	" TODO: report this as warning/error
	finish
endtry
" }}}

" force "compatibility" mode {{{
if &cp | set nocp | endif
" set standard compatibility options ("Vim" standard)
let s:cpo_save=&cpo
set cpo&vim
" }}}

" }}} boiler plate -- prolog

" support functions {{{
function s:DebugMessage( msg )
	return evlib#debug#DebugMessage( a:msg )
endfunction
" }}}

" internal setup {{{
function s:EVPlg_uoprjs_LocalSetup( srcfile ) abort
	let l:success = !0 " true
	" MAYBE: add support for a "disabled this plugin" boolean value (note: but
	"  see how this file has support for 'g:evplg_uoprjs_disable' in the
	"  inclusion guard)
	let l:success = l:success && filereadable( a:srcfile )
	if l:success
		let l:plugin_enabled_dir = fnamemodify( a:srcfile, ':p:h:h' ) . '/plugin-enabled'
		call evlib#rtpath#ExtendRuntimePath( l:plugin_enabled_dir, 'l' ) " returns 'void'
	endif
	return l:success
endfunction
" note: this variable is used by our module inclusion detection function
let g:evplg_uoprjs_globalsetup_succeeded = s:EVPlg_uoprjs_LocalSetup( expand( '<sfile>' ) )
" the function above needs to be called only once -> delete it
delfunction s:EVPlg_uoprjs_LocalSetup
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
echoerr "the script 'plugin/evplg_uoprjs.vim' needs support for the following: eval"

" }}} boiler plate -- epilog

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
