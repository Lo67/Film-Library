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
    LastName: TName;
    Name: TName;
    MiddleName: TName;
  end;

  TTime = Integer;
  { TTime = record
    Minutes : Integer;
    Seconds : string[3];   //??
    end; }
  TGenre = (Adventure, GAction, Comedy, Detective, Drama, Thriller, Fantasy,
    Science_fiction, Horror, Historical, Mystery, Romance, Western, Animation,
    Musical, Satire, Social, Other);
  TCountry = string[30];
  TYear = Integer;//1..3000;
  TWords = string[20];
  TAwards = string[50];
  TBudget = TName;
  TBoxOffice = TName;
  TRating = 1 .. 10;

  TItem = record
    Index: Integer;
    Title: TTitle;
    Director: TDirector;
    Genre: TGenre;
    Country: TCountry;
    Year: TYear;
    Duration: TTime;
    Words: TWords;
    Awards: TAwards;
    Budget: TBudget;
    BoxOffice: TBoxOffice;
    case Ready: Boolean of
      True:
        (Rating: TRating);
      False:
        ();
  end;

  PFilm = ^TFilm;

  TFilm = record
    Item: TItem;
    Next: PFilm;
  end;

  // |||||||||||||||
  // |||||||||||||||
  // TListFilm
  TFilmList = class
    Head: PFilm;
    Tail: PFilm;
    fICount: Integer;
    FileName: string;
  public
    constructor Create;
    destructor Destroy;
    procedure DeleteFilm(const FilmIndex: Integer);
    procedure CreateFilm(const aItem: TItem);
    procedure SaveList(const aFileName: string);
    procedure EditFilm(const aItem: TItem; const aIndex: Integer);
    function GetFilmByIndex(const aIndex: Integer): PFilm;
    procedure RestoreIndexing();
  private
    procedure UploadFile(const aFileName: string);
    procedure AddFilm(const Item: PFilm);
    function IsEmpty(): Boolean;
  end;

implementation

constructor TFilmList.Create;
begin
  Head := nil;
  Tail := nil;
  UploadFile(FILE_NAME);
end;

{destructor TFilmList.Destroy;
var
   Temp: PFilm;
begin
  while Head.Next <> nil do
  begin
     Temp := Head.Next;
     Head.Next := Temp.Next;
     Dispose(Temp);
  end;
  Temp := Head;
  Dispose(Head);
//  Dispose(Tail); // ≈сли будет invalid pointer operation убрать эту строку
end;}

destructor TFilmList.Destroy;
begin
  while not IsEmpty() do
  begin
    DeleteFilm(1);
    RestoreIndexing()
  end;
  Dispose(Head);
  Dispose(Tail);
end;

function TFilmList.IsEmpty(): Boolean;
begin
  Result := Head = nil;
end;

procedure TFilmList.UploadFile(const aFileName: string);
var
  F: file of TFilm;
  ItemTmp: PFilm;
begin
  FileName := aFileName;
  AssignFile(F, FileName);
  if not FileExists(FileName) then
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

procedure TFilmList.SaveList(const aFileName: string);
var
  F: file of TFilm;
  CurrNode: PFilm;
begin
  AssignFile(F, aFileName);
  Rewrite(F);
  CurrNode := Head;
  while CurrNode <> nil do
  begin
    Write(F, CurrNode^);
    CurrNode := CurrNode.Next;
  end;
  CloseFile(F);
end;

procedure TFilmList.CreateFilm(const aItem: TItem);
var
  PFilmInfo: PFilm;
begin
  New(PFilmInfo);

  PFilmInfo^.Item := aItem;
  AddFilm(PFilmInfo);
end;

procedure TFilmList.AddFilm(const Item: PFilm); // appendItem
begin
  if Head = nil then
  begin
    Head := Item;
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

procedure TFilmList.EditFilm(const aItem: TItem; const aIndex: Integer);
var
  CurrNode: PFilm;
begin
  CurrNode := Head;
  while CurrNode.Item.Index <> aIndex + 1 do
    CurrNode := CurrNode.Next;
  CurrNode^.Item := aItem;
end;

procedure TFilmList.DeleteFilm(const FilmIndex: Integer);
var
  CurrNode, PrevNode: PFilm;
  i: Integer;
begin
  if not IsEmpty() then
  begin
    if fICount > 1 then
    begin
      if FilmIndex > 1 then
      begin
        PrevNode := Head;
        while PrevNode.Item.Index <> FilmIndex - 1 do    ////////////////////!!!!!!!!!!
          PrevNode := PrevNode.Next;
        CurrNode := PrevNode.Next;
        PrevNode.Next := CurrNode.Next;
        if CurrNode = Tail then
          Tail := PrevNode;
        Dispose(CurrNode);
      end
      else
      begin
        CurrNode := Head;
        Head := Head.Next;
        Dispose(CurrNode);
      end;
    end
    else
    begin
      CurrNode := Head;
      Head := nil;
      Tail := nil;
      Dispose(CurrNode);
    end;
  end;

  { по факту
    Temp := Head;
    Head:=nil;
    Tail := nil;
    Dispose (Temp)
  }
end;

function TFilmList.GetFilmByIndex(const aIndex: Integer): PFilm;
var
  CurrNode: PFilm;
begin
  CurrNode := Head;
  while CurrNode.Item.Index <> aIndex + 1 do
    CurrNode := CurrNode.Next;
  Result := CurrNode;
end;

procedure TFilmList.RestoreIndexing();
var
  i: Integer;
  CurrNode : PFilm;
begin
  i := 1;
  CurrNode := Head;
  while CurrNode <> nil do
  begin
    CurrNode.Item.Index := i;
    Inc(i);
    CurrNode := CurrNode.Next;
  end;
  fICount := i - 1;
end;
end.
