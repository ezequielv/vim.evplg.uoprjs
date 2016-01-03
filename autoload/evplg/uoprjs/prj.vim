
" include/processing guard {{{
if ! evplg#uoprjs#pvt#module#ShouldSourceThisModule( 'autoload_evplg_uoprjs_prj' )
	finish
endif
" }}}

" note: this function could trigger the project detection for a:prjid, and for
"  all the parent(s) that project has got in its "project definitions".
"
" args:
"  pathname (string): path to the file or directory that this query is
"   directed to;
"	note: directories should end with '/', and filenames end with everything
"		else -- this function does not perform file system access (but it may
"		process the pathname to make it a workable value);
"	(note: when querying about a file, a query on the directory is performed
"		automatically (instead));
"
"  flags (string, optional): one-character flag identifiers:
"   lookup policy (only one of these can be specified):
"    'd': only look at the most direct project id;
"    'a': look at all project ids (including those of parent directories);
"    'p': look only in the parent project(s) (if any);
"    default value: 'd'
"
" TODO: create function in evlib to get a "flag" value from a set of mutually
"  exclusive sets. example:
"  evlib#strflags#GetSetSpecifiedValue( flagsstring, flagsdef_list, (optional) default_value_and_error_value (defaults to an empty string) ) -> string
"   our call: evlib#strflags#GetSetSpecifiedValue( a:flags, [ 'd', 'a', 'p' ], 'd', '0' )
"   or: evlib#strflags#GetSetSpecifiedValue( a:flags, 'dap', 'd0' )
"   note: the function returns the 'error' value ('0' in the example above) if
"    more than one value in the set was specified;
"   if more than one value has been specified, and no 'error' value was
"    specified, then the default value is returned instead (this could be the
"    empty string if no 'default' value had been specified);
function evplg#uoprjs#prj#PathnameBelongsToProjectId( pathname, prjid, ... )
	throw 'FIXME: implement: ' . expand( '<sfile>' )
endfunction

" args: pathname, flags
"  note: flags: same as in evplg#uoprjs#prj#PathnameBelongsToProjectId()
" return value:
"  list (could be empty), in "closer to a:pathname first" order, of dictionaries:
"   each dictionary has the following entries:
"    'pathname' (non-empty string): directory at which the project id has been recognised;
"    'prjids' (list of non-empty strings): project ids (no specified order for now);
"    (more entries could be present in later versions, too)
function evplg#uoprjs#prj#GetPathnameProjectInfo( pathname, ... )
	throw 'FIXME: implement: ' . expand( '<sfile>' )
endfunction

" args:
"
"  prjdefinition (dictionary): a dictionary which has the following entries
"		(note: missing entries will be assumed to have the specified default
"		value for that key)
"		TODO: document the entries in this dictionary, along with the default
"		 values for each dictionary key
"
"  flags (string, optional): one-character flag identifiers:
"   definition policy (only one of these can be specified):
"    's': safely set this project definition (fail if there is one for this
"		project id)
"    'a': add entries not previously defined for this project id
"		(note: entries that were previously defined for this project id for
"		the same keys as those present in a:prjdefinition are left alone --
"		only those entries in a:prjdefinition that were not previously defined
"		for a:prjid are added to the project definition records);
"    'r': replace entries that were previously defined for this project id
"		(note: entries which were defined previously but that are not present
"		in a:prjdefinition are left alone)
"    'S': re[S]et/replace the project definition for a:prjid with the values
"		from a:prjdefinition (that is, remove the previous definition for
"		a:prjid before setting the values in a:prjdefinition)
"    default value: 's'
"
" TODO: find/create function to get a default dictionary key value (I think I
"  had one in evlib or one of my plugins/scripts)
function evplg#uoprjs#prj#RegisterProjectIdDefinition( prjid, prjdefinition, ... )
	throw 'FIXME: implement: ' . expand( '<sfile>' )
endfunction

" vim600: set filetype=vim fileformat=unix:
" vim: set noexpandtab:
" vi: set autoindent tabstop=4 shiftwidth=4:
