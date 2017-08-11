
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
function evplg#uoprjs#prj#PathnameBelongsToProjectId( pathname, prjid, ... )
	" ref: evlib#strflags#GetFlagValues( input, allowed, ... )
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

" note: there may not be a real need for this function, as the "project
" detection" might be the only thing that we might need at this level for now.
"
"  option #1: other modules/user code can then iterate through the results of
"   evplg#uoprjs#prj#GetPathnameProjectInfo() and act accordingly (in a
"   "manual" way).
"
"  option #2: *this* function gets used to access other dictionary members
"   that will be associated to the a:prjid, so other modules can use
"   evplg#uoprjs#prj#RegisterProjectIdDefinition() with the 'a' or 'r' flags
"   to add their own stuff, possibly even encouraging the users to call that
"   other module's "register project id" function instead of
"   evplg#uoprjs#prj#RegisterProjectIdDefinition() (which would then be
"   described as the "low-level" implementation).
"
" args:
"  prjid;
"
"  flags (string, optional): one-character flag identifiers:
"   validation policy (only one of these can be specified):
"    'r': [r]equire a:prjid to have been registered;
"    'o': treat a:prjid as [o]ptional;
"    default value: 'r'
"
" return value:
"  dictionary (could be empty, if the a:prjid has not been registered, and the
"  'o' flag has been specified).
function evplg#uoprjs#prj#GetProjectDictionary( prjid, ... )
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
