program filesplit;

{$APPTYPE CONSOLE}

uses
  Nullpobug.FileSplit.Main in '.\Nullpobug.FileSplit.Main.pas'
  , Nullpobug.FileSplit.SplitFile in '.\Nullpobug.FileSplit.SplitFile.pas'
  ;

var
  FS: TFileSplit;

begin
  FS := TFileSplit.Create;
  try
    FS.Main;
  finally
    FS.Free;
  end;
end.
