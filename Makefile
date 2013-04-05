win32:
	mkdir Build
	cd Source
	dcc32 -$M+ -E..\Build filesplit.dpr

win64:
	mkdir Build
	cd Source
	dcc64 -$M+ -E..\Build filesplit.dpr

osx:
	mkdir Build
	cd Source
	dccosx -$M+ -E..\Build filesplit.dpr

clean:
	if exist Build\filesplit.exe del Build\filesplit.exe
	if exist Build\filesplit del Build\filesplit
	del Test\filesplit_test.exe
	del Test\filesplit_test.xml

test: clean
	cd Test
	dcc32 -$M+ filesplit_test.dpr
	filesplit_test.exe
