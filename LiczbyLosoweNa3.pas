program LiczbyLosoweNa3;

procedure GenerujLiczby;
var
  i, liczba: Integer;
begin
  for i := 1 to 50 do
  begin
    liczba := Random(101); 
    WriteLn(liczba);
  end;
end;

begin
  Randomize; 
  GenerujLiczby; 
end.
