unit Nullpobug.FileSplit.Main;

interface

uses
  System.SysUtils
  , System.Generics.Collections
  , Nullpobug.FileSplit.SplitFile
  , Nullpobug.ArgumentParser
  ;

type
  TFileSplit = class
  (* アプリケーションのメインクラス *)
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
(* アプリケーションはここから開始 *)
var
  SplitSize: Int64;
  SplitFile: TSplitFile;
  FileName: String;
  ArgumentParser: TArgumentParser;
  ParseResult: IParseResult;
begin
  ArgumentParser := TArgumentParser.Create;
  try
    ArgumentParser.AddArgument('-s', saStore);
    try
      ParseResult := ArgumentParser.ParseArgs;
    finally
      ArgumentParser.Free;
    end;
  except
    on EParseError do
      begin
        DisplayUsage;
        Exit;
      end;
  end;
  if not ParseResult.HasArgument('s') then
  begin
    DisplayUsage;
    Exit;
  end;
  (* 分割サイズを取得 *)
  SplitSize := ParseFileSize(ParseResult.GetValue('s'));
  if SplitSize = 0 then
  begin
    DisplayUsage;
    Exit;
  end;
  (* 分割対象のファイル名を取得 *)
  CollectFileNames;
  if FFileNames.Count = 0 then
  begin
    DisplayUsage;
    Exit;
  end;
  (* 指定サイズにファイルを分割 *)
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
(* ファイルサイズの文字列をパースする *)
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
(* 使い方を表示 *)
begin
  Writeln('Usage:');
  Writeln('  ' + ExtractFileName(ParamStr(0)) + ' -s Size File');
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
