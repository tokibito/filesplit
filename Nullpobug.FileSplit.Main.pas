unit Nullpobug.FileSplit.Main;

interface

uses
  System.SysUtils
  , System.Generics.Collections
  , Nullpobug.FileSplit.SplitFile
  ;

type
  TFileSplit = class
  (* �A�v���P�[�V�����̃��C���N���X *)
  private
    FFileNames: TList<String>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Main;
    function ParseFileSize(SplitSizeStr: String): Int64;
    procedure DisplayUsage;
    procedure CollectFileNames;
  end;

implementation

constructor TFileSplit.Create;
begin
  FFileNames := TList<String>.Create;
end;

destructor TFileSplit.Destroy;
begin
  FreeAndNil(FFileNames);
  inherited Destroy;
end;

procedure TFileSplit.Main;
(* �A�v���P�[�V�����͂�������J�n *)
var
  SplitSizeStr: String;
  SplitSize: Int64;
  SplitFile: TSplitFile;
  FileName: String;
begin
  if not FindCmdLineSwitch('s', SplitSizeStr, False) then
  begin
    DisplayUsage;
    Exit;
  end;
  (* �����T�C�Y���擾 *)
  SplitSize := ParseFileSize(SplitSizeStr);
  if SplitSize = 0 then
  begin
    DisplayUsage;
    Exit;
  end;
  (* �����Ώۂ̃t�@�C�������擾 *)
  CollectFileNames;
  if FFileNames.Count = 0 then
  begin
    DisplayUsage;
    Exit;
  end;
  (* �w��T�C�Y�Ƀt�@�C���𕪊� *)
  for FileName in FFileNames do
  begin
    SplitFile := TSplitFile.Create(FileName, SplitSize);
    try
      SplitFile.Execute;
    finally
      SplitFile.Free;
    end;
  end;
end;

function TFileSplit.ParseFileSize(SplitSizeStr: String): Int64;
(* �t�@�C���T�C�Y�̕�������p�[�X���� *)
begin
  if SplitSizeStr = '' then
  begin
    Result := 0;
    Exit;
  end;
  try
    Result := StrToInt64(SplitSizeStr);
  except
    on EConvertError do
      Result := 0;
  end;
end;

procedure TFileSplit.DisplayUsage;
(* �g������\�� *)
begin
  WriteLn('Usage:');
  WriteLn('  ' + ExtractFileName(ParamStr(0)) + ' -s Size File');
end;

procedure TFileSplit.CollectFileNames;
var
  FileCount: Integer;
  I: Integer;
begin
  FFileNames.Clear;
  FileCount := ParamCount - 2;
  if FileCount = 0 then
    Exit;
  for I := 0 to FileCount - 1 do
    FFileNames.Add(ParamStr(I + 3));
end;

end.
