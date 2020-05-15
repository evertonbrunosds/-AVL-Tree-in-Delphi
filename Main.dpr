program Main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uTreeNode in 'util\uTreeNode.pas',
  uNode in 'util\uNode.pas',
  uContainer in 'util\uContainer.pas',
  uMath in 'util\uMath.pas',
  uGarbageCollector in 'util\uGarbageCollector.pas',
  Winapi.Windows;

type TMain = class (TGarbageCollector)
  private procedure Pause();
end;

{ TMain }

var appMain: TMain;
    i: integer;
    tree: TTree<String>;
    Inicio: Cardinal;
    Tempo: Extended;

procedure TMain.Pause();
var a: String;
begin
  read(a);
end;

begin
  appMain:= TMain.Create();
  //appMain.GarbageCollector();
  tree:= TTree<String>.Create();
  Inicio := GetTickCount;
  for i := 0 to 50000 do
  begin
    tree.Insert(i,'');
  end;
  Tempo := (GetTickCount - Inicio) / 1000;
  write(Format('Tempo em segundos: %f', [Tempo]));
  appMain.Pause();
end.
