unit Nullpobug.FileSplit.SplitFileTest;

interface

uses
  Nullpobug.UnitTest
  , Nullpobug.FileSplit.SplitFile
  ;

type
  TSplitFileTest = class(TTestCase)
  private
    FSplitFile: TSplitFile;
  published
    procedure SetUp; override;
    procedure TearDown; override;
    procedure TestGetFileNameTo;
  end;

implementation

procedure TSplitFileTest.SetUp;
begin
  FSplitFile := TSplitFile.Create('dummy', 100);
end;

procedure TSplitFileTest.TearDown;
begin
  FSplitFile.Free;
end;

procedure TSplitFileTest.TestGetFileNameTo;
begin
  AssertEquals(FSplitFile.GetFileNameTo(0), 'dummy.000');
end;

initialization
  RegisterTest(TSplitFileTest);

end.
