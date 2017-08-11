" NOTE: g:evlib_test_runutil_testdir_evlib_rootdir is set by 'runutil.vim'
if ( !( exists( 'g:evlib_test_runutil_testdir_evlib_rootdir' ) && ( ! empty( g:evlib_test_runutil_testdir_evlib_rootdir ) ) ) )
	throw "[evtest] test not run through evlib's 'runutil.vim'"
endif
execute 'source ' . g:evlib_test_runutil_testdir_evlib_rootdir . '/common.vim'
