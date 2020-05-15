unit uContainer;

interface

type TContainer<E> = class (TObject)
  private element: E;
  public constructor Create();
  public procedure SetElement(element: E);
  public function GetElement(): E;
end;

implementation

{ TContainer<E> }

constructor TContainer<E>.Create;
begin
  self.element:= E(nil);
end;

function TContainer<E>.GetElement: E;
begin
  result:= self.element;
end;

procedure TContainer<E>.SetElement(element: E);
begin
  self.element:= element;
end;

end.
