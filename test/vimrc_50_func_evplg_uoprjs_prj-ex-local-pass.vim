" test/vimrc_50_func_evplg_uoprjs_prj-ex-local-pass.vim
" tip: from vim, test it with:
" :wa | unlet! g:evlib_test_runutil_loaded | source ~/data/apps/vim/all/init.plugins/ev.vim.evlib/test/runutil.vim | EVTestRunFiles -p vim-7.0.0_normal_nox -p vim %

" boilerplate -- prolog {{{
if has('eval')
let g:evlib_test_common_main_source_file = expand( '<sfile>' )
" load 'common' vim code
let s:evlib_test_common_common_source_file = fnamemodify( g:evlib_test_common_main_source_file, ':p:h' ) . '/common.vim'
execute 'source ' . ( exists( '*fnameescape' ) ? fnameescape( s:evlib_test_common_common_source_file ) : s:evlib_test_common_common_source_file )
" }}}

let g:test_prj_pathname_01 = 'somepath_01'
let g:test_prj_prjid_01 = 'prjid_01'

call EVLibTest_Start( 'load library using "source {path}/evlib_loader.vim"' )
call EVLibTest_GroupSet_LoadLibrary_Method_Source()
call EVLibTest_GroupSet_TestLibrary()
call EVLibTest_Finalise()

call EVLibTest_Start( 'evplg#uoprjs#prj module' )
call EVLibTest_Do_Batch(
			\		[
			\			{ 'group': 'evplg#uoprjs#prj#*() (independent)' },
			\			[ 'evplg#uoprjs#prj#PathnameBelongsToProjectId(): simple', 'evplg#uoprjs#prj#PathnameBelongsToProjectId( g:test_prj_pathname_01, g:test_prj_prjid_01 )' ],
			\		]
			\	)
call EVLibTest_Finalise()

" boilerplate -- epilog {{{
finish
endif

echoerr 'test need the "eval" feature'
" }}}

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
