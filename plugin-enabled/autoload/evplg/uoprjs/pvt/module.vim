" evplg ([e]xtended [v]im [pl]u[g]in) - uoprjs ([u]n[o]bstrusive [pr]o[j]ect [s]upport)

" boiler plate -- prolog {{{

" "bare vi support" detection/forwarding
if has("eval")

" inclusion control {{{
if exists( 'g:evplg_uoprjs_autoload_evplg_uoprjs_pvt_module_loaded' ) || ( exists( 'g:evplg_uoprjs_disable' ) && g:evplg_uoprjs_disable != 0 )
	finish
endif
let g:evplg_uoprjs_autoload_evplg_uoprjs_pvt_module_loaded = 1
" }}}

" force "compatibility" mode {{{
if &cp | set nocp | endif
" set standard compatibility options ("Vim" standard)
let s:cpo_save=&cpo
set cpo&vim
" }}}

" }}} boiler plate -- prolog

" functionality {{{
function evplg#uoprjs#pvt#module#ShouldSourceThisModule( module_id, ... ) abort
	return evplg#common#module#ShouldSourceThisModule(
				\		'evplg_uoprjs_' . a:module_id,
				\		'evplg#uoprjs#pvt#init#CanSource_evplg_uoprjs_modules()',
				\		a:000
				\	)
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
echoerr "the script 'plugin-enabled/autoload/evplg/uoprjs/pvt/module.vim' needs support for the following: eval"

" }}} boiler plate -- epilog

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
