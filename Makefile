win32:
	dcc32 -$M+ filesplit.dpr

win64:
	dcc64 -$M+ filesplit.dpr

osx:
	dccosx -$M+ filesplit.dpr

clean:
	del filesplit.exe
	del filesplit

test:
	dcc32 -$M+ filesplit_test.dpr
