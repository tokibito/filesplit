program filesplit_test;

{$APPTYPE CONSOLE}

uses
  Nullpobug.UnitTest in '.\Nullpobug.UnitTest.pas'
  , Nullpobug.FileSplit.SplitFile in '.\Nullpobug.FileSplit.SplitFile.pas'
  , Nullpobug.FileSplit.SplitFileTest in '.\Nullpobug.FileSplit.SplitFileTest.pas'
  , Nullpobug.FileSplit.Main in '.\Nullpobug.FileSplit.Main.pas'
  , Nullpobug.FileSplit.MainTest in '.\Nullpobug.FileSplit.MainTest.pas'
  ;

begin
  Nullpobug.UnitTest.RunTest('filesplit_test.xml');
end.
