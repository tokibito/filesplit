unit Nullpobug.FileSplit.SplitFile;

interface

uses
  System.SysUtils
  ;

type
  TSplitFile = class
  (* �t�@�C�������������s���N���X *)
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
(* �������������s *)
begin
  WriteLn('Split size: ' + IntToStr(FSize));
  WriteLn('Target file: ' + FFileName);
  // TODO: �t�@�C���𕪊�����
end;

end.
