program TestProject;

{$APPTYPE CONSOLE}

uses
  Nullpobug.UnitTest in '.\Nullpobug.UnitTest.pas'
  , Nullpobug.FileSplit.SplitFile in '.\Nullpobug.FileSplit.SplitFile.pas'
  , Nullpobug.FileSplit.SplitFileTest in '.\Nullpobug.FileSplit.SplitFileTest.pas'
  ;

begin
  Nullpobug.UnitTest.RunTest('filesplit_test.xml');
end.
