program LiczbyLosowe;

type
  tablica = array[1..50] of Integer; 

var
  liczby: tablica; 
  i: Integer;

procedure GenerujLiczby(var arr: tablica);
var
  i: Integer;
begin
  for i := 1 to 50 do
  begin
    arr[i] := Random(101); 
  end;
end;

procedure Sortowanie(var arr: tablica);
var 
  i, j, tmp: Integer;
begin
  for i := 1 to 49 do 
    for j := 1 to 50 - i do 
      if arr[j] > arr[j+1] then
      begin
        tmp := arr[j];
        arr[j] := arr[j+1];
        arr[j+1] := tmp;
      end;
end;

begin
  Randomize; 
  GenerujLiczby(liczby); 
  Sortowanie(liczby);

  for i:=1 to 50 do
  begin
    WriteLn(liczby[i]);
  end;
end.
