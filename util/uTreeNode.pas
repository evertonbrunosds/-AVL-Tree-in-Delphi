unit uTreeNode;

interface

uses uNode, uContainer, uMath, System.Generics.Defaults, SysUtils;

type TTree<E> = class (TObject)
  private root: TNode<E>;
  public constructor Create();
  public function IsEmpty(): boolean;
  public procedure Clear();
  private procedure AuxClear(currentNode: TNode<E>);
  public procedure Insert(key: integer; element: E);
  private function AuxInsert(key: integer; element: E; currentNode: TNode<E>): TNode<E>;
  public function Search(key: integer): E;
  private function AuxSearch(key: integer; currentNode: TNode<E>): E;
  public function IsContains(key: integer): boolean;
  private function AuxRemove(key: integer; container: TContainer<E>; currentNode: TNode<E>): TNode<E>;
  public function Remove(key: integer): E;
  private function GetHeight(currentNode: TNode<E>): integer;
  private procedure UpdateBalancing(currentNode: TNode<E>);
  private function AdjustHeigth(currentNode: TNode<E>): TNode<E>;
  private function SimpleRotationLeft(newRoot, oldRoot: TNode<E>): TNode<E>;
  private function SimpleRotationRight(newRoot, oldRoot: TNode<E>): TNode<E>;
  private function DoubleRotationLeft(sonOnTheLeft, oldRoot: TNode<E>): TNode<E>;
  private function DoubleRotationRight(sonOnTheRight, oldRoot: TNode<E>): TNode<E>;
  
end;

implementation

{ TTree<E> }

function TTree<E>.AdjustHeigth(currentNode: TNode<E>): TNode<E>;
begin
  if(currentNode <> nil) then
  begin
    self.UpdateBalancing(currentNode);
    if(currentNode.GetBalancing() <= -2) then
    begin
      if((currentNode.GetBalancing() * currentNode.GetSonOnTheLeft().GetBalancing()) > 0) then
      begin
        result:= self.simpleRotationLeft(currentNode.getSonOnTheLeft(), currentNode);
      end
      else
      begin
        result:= self.doubleRotationLeft(currentNode.getSonOnTheLeft(), currentNode);
      end;
    end
    else if(currentNode.GetBalancing() >= 2) then
    begin
      if((currentNode.GetBalancing() * currentNode.GetSonOnTheRight().GetBalancing()) > 0) then
      begin
        result:= self.simpleRotationRight(currentNode.getSonOnTheRight(), currentNode);
      end
      else
      begin
        result:= self.doubleRotationRight(currentNode.getSonOnTheRight(), currentNode);
      end;
    end
    else
    begin
      result:= currentNode;
    end;
  end else
  begin
    result:= nil;
  end;
end;

procedure TTree<E>.AuxClear(currentNode: TNode<E>);
begin
  if(currentNode <> nil) then
  begin
    self.AuxClear(currentNode.GetSonOnTheLeft);
    self.AuxClear(currentNode.GetSonOnTheRight);
    FreeAndNil(currentNode);
  end;
end;

function TTree<E>.AuxInsert(key: integer; element: E; currentNode: TNode<E>): TNode<E>;
begin
  if(currentNode = nil) then
  begin
    result:= TNode<E>.Create(key,element);
  end else
  begin
    if(currentNode.GetKey() > key) then
    begin
      currentNode.SetSonOnTheLeft(self.AuxInsert(key, element, currentNode.GetSonOnTheLeft()));
    end
    else
    begin
      currentNode.SetSonOnTheRight(self.AuxInsert(key, element, currentNode.GetSonOnTheRight()));
    end;
    result:= self.AdjustHeigth(currentNode);
  end;
end;

function TTree<E>.AuxRemove(key: integer; container: TContainer<E>; currentNode: TNode<E>): TNode<E>;
var auxNode: TNode<E>;
    tmpKey: integer;
    tmpElement: E;
begin
  if(currentNode = nil) then
  begin
    result:= nil;
  end
  else
  begin
    if(currentNode.GetKey() = key) then
    begin
      if(currentNode.IsLeaf()) then
      begin
        container.SetElement(currentNode.GetElement());
        FreeAndNil(currentNode);
      end
      else if(currentNode.HasSonJustLeft()) then
      begin
        container.SetElement(currentNode.GetElement());
        auxNode:= currentNode.GetSonOnTheLeft();
        FreeAndNil(currentNode);
      end
      else if(currentNode.HasSonJustRight()) then
      begin
        container.SetElement(currentNode.GetElement());
        auxNode:= currentNode.GetSonOnTheRight();
        FreeAndNil(currentNode);
      end
      else
      begin
        auxNode:= currentNode.GetSonOnTheLeft();
        while(auxNode.GetSonOnTheRight() <> nil) do
        begin
          auxNode:= auxNode.GetSonOnTheRight();
        end;
        tmpKey:= auxNode.GetKey();
        tmpElement:= auxNode.GetElement();
        auxNode.SetKey(currentNode.GetKey());
        auxNode.SetElement(currentNode.GetElement());
        currentNode.SetKey(tmpKey);
        currentNode.SetElement(tmpElement);
        currentNode.SetSonOnTheLeft(self.AuxRemove(key, container, currentNode.GetSonOnTheLeft()));
      end;
    end
    else if(currentNode.GetKey() > key) then
    begin
      currentNode.SetSonOnTheLeft(self.AuxRemove(key, container, currentNode.GetSonOnTheLeft()));
    end
    else
    begin
      currentNode.SetSonOnTheRight(self.AuxRemove(key, container, currentNode.GetSonOnTheRight()));
    end;
    result:= self.AdjustHeigth(currentNode);
  end;
end;

function TTree<E>.Search(key: integer): E;
begin
  result:= self.AuxSearch(key, self.root);
end;

function TTree<E>.AuxSearch(key: integer; currentNode: TNode<E>): E;
begin
  if(currentNode = nil) then
  begin
    result:= E(nil);
  end
  else if(currentNode.GetKey() = key) then
  begin
    result:= currentNode.GetElement();
  end
  else if(currentNode.GetKey() > key) then
  begin
    result:= self.AuxSearch(key, currentNode.GetSonOnTheLeft());
  end
  else
  begin
    result:= self.AuxSearch(key, currentNode.GetSonOnTheRight());
  end;
end;

procedure TTree<E>.Clear;
begin
  self.AuxClear(self.root);
end;

constructor TTree<E>.Create;
begin
  self.root:= nil;
end;

function TTree<E>.DoubleRotationLeft(sonOnTheLeft, oldRoot: TNode<E>): TNode<E>;
begin
  oldRoot.setSonOnTheLeft(sonOnTheLeft.getSonOnTheRight());
  sonOnTheLeft.setSonOnTheRight(oldRoot.getSonOnTheLeft().getSonOnTheLeft());
  oldRoot.getSonOnTheLeft().setSonOnTheLeft(sonOnTheLeft);
  result:= simpleRotationLeft(oldRoot.getSonOnTheLeft(), oldRoot);
end;

function TTree<E>.DoubleRotationRight(sonOnTheRight, oldRoot: TNode<E>): TNode<E>;
begin
  oldRoot.setSonOnTheRight(sonOnTheRight.getSonOnTheLeft());
  sonOnTheRight.setSonOnTheLeft(oldRoot.getSonOnTheRight().getSonOnTheRight());
  oldRoot.getSonOnTheRight().setSonOnTheRight(sonOnTheRight);
  result:= simpleRotationRight(oldRoot.getSonOnTheRight(), oldRoot);
end;

function TTree<E>.GetHeight(currentNode: TNode<E>): integer;
var math: TMath;
begin
  if(currentNode = nil) then
  begin
    result:= 0;
  end
  else
  begin
    result:= math.MaxInteger(1 + self.getHeight(currentNode.GetSonOnTheLeft()), 1 + self.getHeight(currentNode.GetSonOnTheRight()));
  end;
end;

procedure TTree<E>.Insert(key: integer; element: E);
begin
  if(not self.IsContains(key)) then
  begin
    self.root:= self.AuxInsert(key,element,self.root);
  end;
end;

function TTree<E>.IsContains(key: integer): boolean;
var comparer : IComparer<E>;
begin
  comparer:= TComparer<E>.Default;
  result:= comparer.Compare(self.Search(key), E(nil)) <> 0;
end;

function TTree<E>.IsEmpty: boolean;
begin
  result:= self.root = nil;
end;

function TTree<E>.Remove(key: integer): E;
var container: TContainer<E>;
begin
  container:= TContainer<E>.Create();
  self.root:= self.AuxRemove(key, container, self.root);
  result:= container.GetElement();
end;

function TTree<E>.SimpleRotationLeft(newRoot, oldRoot: TNode<E>): TNode<E>;
begin
  oldRoot.setSonOnTheLeft(newRoot.getSonOnTheRight());
  newRoot.setSonOnTheRight(oldRoot);
  result:= newRoot;
end;

function TTree<E>.SimpleRotationRight(newRoot, oldRoot: TNode<E>): TNode<E>;
begin
  oldRoot.setSonOnTheRight(newRoot.getSonOnTheLeft());
  newRoot.setSonOnTheLeft(oldRoot);
  result:= newRoot;
end;

procedure TTree<E>.UpdateBalancing(currentNode: TNode<E>);
begin
  currentNode.SetBalancing(-self.getHeight(currentNode.GetSonOnTheLeft()) +self.getHeight(currentNode.GetSonOnTheRight()));
end;

end.
