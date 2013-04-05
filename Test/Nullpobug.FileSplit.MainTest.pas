unit Nullpobug.FileSplit.MainTest;

interface

uses
  Nullpobug.UnitTest
  , Nullpobug.FileSplit.Main
  ;

type
  TFileSplitTest = class(TTestCase)
  private
    FFileSplit: TFileSplit;
  published
    procedure SetUp; override;
    procedure TearDown; override;
    procedure TestParseFileSize;
  end;

implementation

procedure TFileSplitTest.SetUp;
begin
  FFileSplit := TFileSplit.Create;
end;

procedure TFileSplitTest.TearDown;
begin
  FFileSplit.Free;
end;

procedure TFileSplitTest.TestParseFileSize;
begin
  AssertEquals(FFileSplit.ParseFileSize('1000'), 1000);
end;

initialization
  RegisterTest(TFileSplitTest);

end.
