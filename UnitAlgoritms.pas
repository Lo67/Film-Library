unit UnitAlgoritms;

interface

uses
  FilmBase, TypeList, SysUtils;

procedure SearchByTitle(Str : string);
procedure SearchByYear(Str : string);
procedure SearchByCountry(Str : string);
procedure SearchByDirector(Str : string);
procedure SearchByWords(Str : string);
procedure SearchByDuration(Str : string);

implementation

function CompareStirng(StrList, StrSearch : string) : Boolean;
var
  LenList, LenSearch: Integer;
  i : Integer;
begin
  Result := True;
  LenList := Length(StrList);
  LenSearch := Length(StrSearch);

  if LenSearch > LenList then
    Result := False
  else
    if Pos(StrSearch, StrList) = 0 then
      Result := False;
end;

function LowCase (Str : string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Str) do
    case Str[i] of
      'A'..'Z':
        Result := Result + Chr(Ord(Str[i]) + 32);
      'А'..'Я':
        Result := Result + Chr(Ord(Str[i]) + 32);
      else
        Result := Result + Str[i];
    end;
end;

{ Поиск по названию}
procedure SearchByTitle(Str : string);
var
  CurrNode : PFilm;
  isExist : Boolean;
begin
  isExist := False;
  frmFilmBase.lvFilmTab.Clear;
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    if CompareStirng(LowCase(CurrNode.Item.Title), LowCase(Str)) then
    begin
      isExist := True;
      frmFilmBase.DrawOneFilm(CurrNode);
    end;
    CurrNode := CurrNode^.Next;
  end;

  if not isExist then
  begin
    frmFilmBase.Mistake;
    frmFilmBase.UpdateTab(List);
  end;
end;

{ Поиск по году}
procedure SearchByYear(Str : string);
var
  CurrNode : PFilm;
  isExist : Boolean;
  StrList : string;
begin
  isExist := False;
  frmFilmBase.lvFilmTab.Clear;
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    StrList := IntToStr(CurrNode.Item.Year);
    if CompareStirng(StrList, Str) then
    begin
      isExist := True;
      frmFilmBase.DrawOneFilm(CurrNode);
    end;
    CurrNode := CurrNode^.Next;
  end;

  if not isExist then
  begin
    frmFilmBase.Mistake;
    frmFilmBase.UpdateTab(List);
  end;
end;

{ Поиск по стране}
procedure SearchByCountry(Str : string);
var
  CurrNode : PFilm;
  isExist : Boolean;
begin
  isExist := False;
  frmFilmBase.lvFilmTab.Clear;
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    if CompareStirng(LowCase(CurrNode.Item.Country), LowCase(Str)) then
    begin
      isExist := True;
      frmFilmBase.DrawOneFilm(CurrNode);
    end;
    CurrNode := CurrNode^.Next;
  end;

  if not isExist then
  begin
    frmFilmBase.Mistake;
    frmFilmBase.UpdateTab(List);
  end;
end;

{ Поиск по Режиссеру}
procedure SearchByDirector(Str : string);
var
  CurrNode : PFilm;
  isExist : Boolean;
  StrList : string;
begin
  isExist := False;
  frmFilmBase.lvFilmTab.Clear;
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    StrList := CurrNode.Item.Director.LastName +
               CurrNode.Item.Director.Name +
               CurrNode.Item.Director.MiddleName;
    if CompareStirng(LowCase(StrList), LowCase(Str)) then
    begin
      isExist := True;
      frmFilmBase.DrawOneFilm(CurrNode);
    end;
    CurrNode := CurrNode^.Next;
  end;

  if not isExist then
  begin
    frmFilmBase.Mistake;
    frmFilmBase.UpdateTab(List);
  end;
end;

{ Поиск по ключевым словам}
procedure SearchByWords(Str : string);
var
  CurrNode : PFilm;
  isExist : Boolean;
begin
  isExist := False;
  frmFilmBase.lvFilmTab.Clear;
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    if CompareStirng(LowCase(CurrNode.Item.Words), LowCase(Str)) then
    begin
      isExist := True;
      frmFilmBase.DrawOneFilm(CurrNode);
    end;
    CurrNode := CurrNode^.Next;
  end;

  if not isExist then
  begin
    frmFilmBase.Mistake;
    frmFilmBase.UpdateTab(List);
  end;
end;

{ Поиск по длительности}
procedure SearchByDuration(Str : string);
var
  CurrNode : PFilm;
  isExist : Boolean;
begin
  isExist := False;
  frmFilmBase.lvFilmTab.Clear;
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    if CompareStirng(IntToStr(CurrNode.Item.Duration), Str) then
    begin
      isExist := True;
      frmFilmBase.DrawOneFilm(CurrNode);
    end;
    CurrNode := CurrNode^.Next;
  end;

  if not isExist then
  begin
    frmFilmBase.Mistake;
    frmFilmBase.UpdateTab(List);
  end;
end;

end.
