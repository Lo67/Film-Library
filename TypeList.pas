unit TypeList;

interface

uses
  SysUtils;

const
  FILE_NAME = 'Films';

type
  TName = string[30];
  TTitle = string[70];
  TDirector = record
    LastName : TName;
    Name : TName;
    MiddleName : TName;
  end;
  TTime = Integer;
 { TTime = record
    Minutes : Integer;
    Seconds : string[3];   //??
  end;}
  TGenre = (Adventure, GAction, Comedy, Detective, Drama, Thriller,
            Fantasy, Science_fiction, Horror, Historical, Mystery,
            Romance, Western, Animation, Musical, Satire, Social, Other);
  TCountry = string[30];
  TYear = 1..3000;
  TWords = string[20];
  TAwards = string[50];
  TBudget = TName;
  TBoxOffice = TName;
  TRating = 1..10;



  TItem = record
    Index : Integer;
    Title : TTitle;
    Director : TDirector;
    Genre : TGenre;
    Country : TCountry;
    Year : TYear;
    Duration : TTime;
    Words: TWords;
    Awards : TAwards;
    Budget : TBudget;
    BoxOffice : TBoxOffice;
    case Ready : Boolean of
      True : (Rating : TRating);
      False : ();
  end;

  PFilm = ^TFilm;
  TFilm = record
    Item : TItem;
    Next : PFilm;
  end;

  // |||||||||||||||
  // |||||||||||||||
  //TListFilm
  TFilmList = class
    Head : PFilm;
    Tail : PFilm;
    fICount : Integer;
    FileName : string;
    constructor Create(const aFileName : string);
    procedure AddFilm(const item: PFilm);
 //   destructor Kill;
  end;

  procedure CreateFilm(var List : TFilmList; const aItem : TItem);
  procedure SaveList(var List : TFilmList; const aFileName : string);

implementation

constructor TFilmList.Create(const aFileName: string);
var
  F: file of TFilm;   //PFilm?
  ItemTmp: PFilm;
begin
  FileName := aFileName;
  AssignFile(F, FileName);
  if not FileExists(Filename) then
    Rewrite(F)
  else
  begin
    Reset(F);
    while not EoF(F) do
    begin
      New(ItemTmp);
      Read(F, ItemTmp^);
      AddFilm(ItemTmp);
    end;
  end;
  CloseFile(F);
end;

procedure TFilmList.AddFilm(const Item: PFilm);     //appendItem
begin
  if Head = nil then
  begin
    Head:= Item;
    Tail := Item;
  end
  else
  begin
    Tail.Next := Item;
    Tail := Item;
    Tail.Next := nil;
  end;
  Inc(fICount);
end;

procedure CreateFilm(var List : TFilmList; const aItem : TItem );
var
  PFilmInfo : PFilm;
begin
  New(PFilmInfo);

  PFilmInfo^.Item := aItem;
  List.AddFilm(PFilmInfo);
end;

{destructor TFilmList.Kill;
begin
  Dispose(Head);
  end;}

procedure SaveList(var List : TFilmList; const aFileName : string);
var
  F: file of TFilm;
  CurrNode: PFilm;
begin
  AssignFile(F, aFileName);
  Rewrite(F);
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    Write(F,CurrNode^);
    CurrNode := CurrNode.Next;
  end;
  CloseFile(F);
end;

end.
