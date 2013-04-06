win32: mk_build_dir
	cd Source
	dcc32 -$M+ -E..\Build filesplit.dpr

win64: mk_build_dir
	cd Source
	dcc64 -$M+ -E..\Build filesplit.dpr

osx: mk_build_dir
	cd Source
	dccosx -$M+ -E..\Build filesplit.dpr

mk_build_dir:
	if not exist Build mkdir Build

clean:
	if exist Build\filesplit.exe del Build\filesplit.exe
	if exist Build\filesplit del Build\filesplit
	if exist Test\filesplit_test.exe del Test\filesplit_test.exe
	if exist Test\filesplit_test.xml del Test\filesplit_test.xml

test: clean
	cd Test
	dcc32 -$M+ filesplit_test.dpr
	filesplit_test.exe
