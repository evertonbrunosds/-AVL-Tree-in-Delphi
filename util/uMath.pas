unit uMath;

interface

type TMath = class (TObject)
  public function MaxInteger(const oneValue: integer; const twoValue: integer): integer;
  public function MinInteger(const oneValue: integer; const twoValue: integer): integer;
end;

implementation

{ TMath }

function TMath.MaxInteger(const oneValue, twoValue: integer): integer;
begin
if(oneValue > twoValue) then
  begin
    result:= oneValue;
  end else
  begin
    result:= twoValue;
  end;
end;

function TMath.MinInteger(const oneValue, twoValue: integer): integer;
begin
  if(oneValue < twoValue) then
  begin
    result:= oneValue;
  end else
  begin
    result:= twoValue;
  end;
end;

end.
