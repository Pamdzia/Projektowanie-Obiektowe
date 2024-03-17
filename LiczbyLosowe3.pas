program LiczbyLosowe3;

type
  tablica = array[1..50] of Integer; 

var
  liczby: tablica; 
  i, ileLiczb, zakresOd, zakresDo: Integer;


procedure GenerujLiczby(var arr: tablica; zakresOd, zakresDo, ile: Integer);
var
  i: Integer;
begin
  for i := 1 to ile do 
  begin
    arr[i] := Random(zakresDo - zakresOd + 1) + zakresOd; 
  end;
end;

procedure Sortowanie(var arr: tablica; ile: Integer);
var 
  i, j, tmp: Integer;
begin
  for i := 1 to ile - 1 do
    for j := 1 to ile - i do
      if arr[j] > arr[j+1] then
      begin
        tmp := arr[j];
        arr[j] := arr[j+1];
        arr[j+1] := tmp;
      end;
end;


begin
  ileLiczb := 50;
  zakresOd := 1;
  zakresDo := 100;

  Randomize; 
  GenerujLiczby(liczby, zakresOd, zakresDo, ileLiczb); 
  Sortowanie(liczby, ileLiczb);

  for i:=1 to ileLiczb do 
  begin
    WriteLn(liczby[i]);
  end;
end.
