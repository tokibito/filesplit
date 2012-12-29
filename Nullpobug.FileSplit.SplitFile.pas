unit Nullpobug.FileSplit.SplitFile;

interface

uses
  System.SysUtils
  ;

type
  TSplitFile = class
  (* ファイル分割処理を行うクラス *)
  private
    FFileName: String;
    FSize: Int64;
  public
    constructor Create(FileName: String; Size: Int64);
    procedure Execute;
  end;

implementation

constructor TSplitFile.Create(FileName: String; Size: Int64);
begin
  FFileName := FileName;
  FSize := Size;
end;

procedure TSplitFile.Execute;
(* 分割処理を実行 *)
begin
  WriteLn('Split size: ' + IntToStr(FSize));
  WriteLn('Target file: ' + FFileName);
  // TODO: ファイルを分割する
end;

end.
