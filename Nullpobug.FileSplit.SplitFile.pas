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
  (* �t�@�C�������������s���N���X *)
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
(* �R�s�[��̃t�@�C�������擾���� *)
begin
  (* ���t�@�C���̖��O + .001 �`�� *)
  Result := FFileName + '.' + Format('%.3d', [FileNumber]);
end;

procedure TSplitFile.Execute;
(* �������������s *)
var
  FileNameTo: String;
  FileNumber: Integer;
  FileFrom, FileTo: TFileStream;
  Buffer: TMemoryStream;
  CopySize, ReadSize, WroteSize, CopiedSize, CopiedTotal: Int64;
begin
  WriteLn('Split size: ' + IntToStr(FSize));
  WriteLn('Target file: ' + FFileName);
  (* �R�s�[�p�̃o�b�t�@��p�� *)
  Buffer := TMemoryStream.Create;
  try
    Buffer.Size :=  FBufferSize;
    CopiedTotal := 0;
    FileNumber := 0;
    FileFrom := TFileStream.Create(FFileName, fmOpenRead);
    try
      (* �R�s�[���t�@�C���̃T�C�Y��0�Ȃ�I�� *)
      if FileFrom.Size = 0 then
        Exit;
      while True do
      begin
        (* �����t�@�C�����Ƃ̃R�s�[�ς݃T�C�Y�����Z�b�g *)
        CopiedSize := 0;
        (* �R�s�[��t�@�C�������擾 *)
        FileNameTo := GetFileNameTo(FileNumber);
        (* �R�s�[��t�@�C�����J�� *)
        FileTo := TFileStream.Create(FileNameTo, fmCreate);
        try
          while True do
          begin
            (* �R�s�[����T�C�Y������ *)
            CopySize := FSize - CopiedSize;
            (* �R�s�[����T�C�Y���傫���ꍇ�̓o�b�t�@�T�C�Y�̏�����g�� *)
            if CopySize > FBufferSize then
              CopySize := FBufferSize;
            (* �o�b�t�@�ɓǂݍ��� *)
            ReadSize := FileFrom.Read(Buffer.Memory^, CopySize);
            (* �R�s�[��֏������� *)
            WroteSize := FileTo.Write(Buffer.Memory^, ReadSize);
            (* �R�s�[�ς݃T�C�Y���X�V *)
            Inc(CopiedSize, WroteSize);
            Inc(CopiedTotal, WroteSize);
            (* �R�s�[���t�@�C�����Ō�܂œǂݍ��񂾏ꍇ�͏I�� *)
            if CopiedTotal = FileFrom.Size then
              Break;
            (* �����T�C�Y�܂ŃR�s�[�����ꍇ�͎��̃t�@�C���� *)
            if CopiedSize = FSize then
            begin
              Inc(FileNumber);
              Break;
            end;
          end;

          (* �R�s�[���t�@�C�����Ō�܂œǂݍ��񂾏ꍇ�͏I�� *)
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
