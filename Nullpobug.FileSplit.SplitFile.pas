unit Nullpobug.FileSplit.SplitFile;

interface

uses
  System.SysUtils
  , System.Classes
  ;

const
  DEFAULT_BUFFER_SIZE = 1048576;

type
  TSplitFile = class
  (* ファイル分割処理を行うクラス *)
  private
    FFileName: String;
    FSize: Int64;
    FBufferSize: Cardinal;
  public
    constructor Create(FileName: String; Size: Int64;
        const BufferSize: Cardinal = DEFAULT_BUFFER_SIZE);
    function GetFileNameTo(FileNumber: Integer): String;
    procedure Execute;
  end;

implementation

constructor TSplitFile.Create(FileName: String; Size: Int64;
    const BufferSize: Cardinal = DEFAULT_BUFFER_SIZE);
begin
  FFileName := FileName;
  FSize := Size;
  FBufferSize := BufferSize;
end;

function TSplitFile.GetFileNameTo(FileNumber: Integer): String;
(* コピー先のファイル名を取得する *)
begin
  (* 元ファイルの名前 + .001 形式 *)
  Result := FFileName + '.' + Format('%.3d', [FileNumber]);
end;

procedure TSplitFile.Execute;
(* 分割処理を実行 *)
var
  FileNameTo: String;
  FileNumber: Integer;
  FileFrom, FileTo: TFileStream;
  Buffer: TMemoryStream;
  CopySize, ReadSize, WroteSize, CopiedSize, CopiedTotal: Int64;
begin
  WriteLn('Split size: ' + IntToStr(FSize));
  WriteLn('Target file: ' + FFileName);
  (* コピー用のバッファを用意 *)
  Buffer := TMemoryStream.Create;
  try
    Buffer.Size :=  FBufferSize;
    CopiedTotal := 0;
    FileNumber := 0;
    FileFrom := TFileStream.Create(FFileName, fmOpenRead);
    try
      (* コピー元ファイルのサイズが0なら終了 *)
      if FileFrom.Size = 0 then
        Exit;
      while True do
      begin
        (* 分割ファイルごとのコピー済みサイズをリセット *)
        CopiedSize := 0;
        (* コピー先ファイル名を取得 *)
        FileNameTo := GetFileNameTo(FileNumber);
        (* コピー先ファイルを開く *)
        FileTo := TFileStream.Create(FileNameTo, fmCreate);
        try
          while True do
          begin
            (* コピーするサイズを決定 *)
            CopySize := FSize - CopiedSize;
            (* コピーするサイズが大きい場合はバッファサイズの上限を使う *)
            if CopySize > FBufferSize then
              CopySize := FBufferSize;
            (* バッファに読み込み *)
            ReadSize := FileFrom.Read(Buffer.Memory^, CopySize);
            (* コピー先へ書き込み *)
            WroteSize := FileTo.Write(Buffer.Memory^, ReadSize);
            (* コピー済みサイズを更新 *)
            Inc(CopiedSize, WroteSize);
            Inc(CopiedTotal, WroteSize);
            (* コピー元ファイルを最後まで読み込んだ場合は終了 *)
            if CopiedTotal = FileFrom.Size then
              Break;
            (* 分割サイズまでコピーした場合は次のファイルへ *)
            if CopiedSize = FSize then
            begin
              Inc(FileNumber);
              Break;
            end;
          end;

          (* コピー元ファイルを最後まで読み込んだ場合は終了 *)
          if CopiedTotal = FileFrom.Size then
            Break;

        finally
          FreeAndNil(FileTo);
        end;
      end;
    finally
      FreeAndNil(FileFrom);
    end;
  finally
    FreeAndNil(Buffer);
  end;
end;

end.
