unit uNode;

interface

type TNode<E> = class (TObject)
  private key: integer;
  private balancing: integer;
  private element: E;
  private sonOnTheLeft: TNode<E>;
  private sonOnTheRight: TNode<E>;
  public constructor Create(key: integer; element: E);
  public procedure SetKey(key: integer);
  public procedure SetBalancing(balancing: integer);
  public procedure SetElement(element: E);
  public procedure SetSonOnTheLeft(sonOnTheLeft: TNode<E>);
  public procedure SetSonOnTheRight(sonOnTheRight: TNode<E>);
  public function GetKey(): integer;
  public function GetBalancing(): integer;
  public function GetElement(): E;
  public function GetSonOnTheLeft(): TNode<E>;
  public function GetSonOnTheRight(): TNode<E>;
  public function IsLeaf(): boolean;
  public function HasSonJustLeft(): boolean;
  public function HasSonJustRight(): boolean;
end;

implementation

{ TNode<E> }

constructor TNode<E>.Create(key: integer; element: E);
begin
  self.key:= key;
  self.balancing:= 0;
  self.element:= element;
  self.sonOnTheLeft:= nil;
  self.sonOnTheRight:= nil
end;

function TNode<E>.GetBalancing: integer;
begin
  result:= self.balancing;
end;

function TNode<E>.GetElement: E;
begin
  result:= self.element;
end;

function TNode<E>.GetKey: integer;
begin
  result:= self.key;
end;

function TNode<E>.GetSonOnTheLeft: TNode<E>;
begin
  result:= self.sonOnTheLeft;
end;

function TNode<E>.GetSonOnTheRight: TNode<E>;
begin
  result:= self.sonOnTheRight;
end;

function TNode<E>.HasSonJustLeft: boolean;
begin
  result:= (self.sonOnTheLeft <> nil) and (self.sonOnTheRight = nil);
end;

function TNode<E>.HasSonJustRight: boolean;
begin
  result:= (self.sonOnTheLeft = nil) and (self.sonOnTheRight <> nil);
end;

function TNode<E>.IsLeaf: boolean;
begin
  result:= (self.sonOnTheLeft = nil) and (self.sonOnTheRight = nil);
end;

procedure TNode<E>.SetBalancing(balancing: integer);
begin
  self.balancing:= balancing;
end;

procedure TNode<E>.SetElement(element: E);
begin
  self.element:= element;
end;

procedure TNode<E>.SetKey(key: integer);
begin
  self.key:= key;
end;

procedure TNode<E>.SetSonOnTheLeft(sonOnTheLeft: TNode<E>);
begin
  self.sonOnTheLeft:= sonOnTheLeft;
end;

procedure TNode<E>.SetSonOnTheRight(sonOnTheRight: TNode<E>);
begin
  self.sonOnTheRight:= sonOnTheRight;
end;

end.
