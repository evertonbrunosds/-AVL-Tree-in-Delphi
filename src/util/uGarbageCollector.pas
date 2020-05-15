unit uGarbageCollector;

interface

uses Winapi.Windows;

type TGarbageCollector = class (TObject)
  public procedure GarbageCollector();
end;

implementation

{ TGarbageCollector }

procedure TGarbageCollector.GarbageCollector();
var MainHandle: THandle;
begin
  MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
  SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
  CloseHandle(MainHandle);
end;

end.
