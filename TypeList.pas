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
    fICount : Integer ;
    FileName : string;
    constructor Create;
    procedure UploadFile (const aFileName: string);
    destructor Destroy;
    procedure AddFilm(const Item: PFilm);
    procedure DeleteFilm(FilmIndex: Integer);
    function IsEmpty():Boolean;
  end;

  procedure CreateFilm(var List : TFilmList; const aItem : TItem);
  procedure SaveList(var List : TFilmList; const aFileName : string);
  procedure EditFilm(var List : TFilmList; const aItem : TItem; const aIndex : Integer);
  function GetFilmByIndex(var List : TFilmList; const aIndex : Integer) : PFilm;
  function GetRating(const aItem : TItem) : Integer;
  function GetGenre(const aItem : TItem) : Integer;
  function TabGenre(Genre : TGenre): string;

implementation

constructor TFilmList.Create;

begin
  Head := nil;
  Tail := nil;
  UploadFile (FILE_NAME);
end;

procedure TFilmList.UploadFile (const aFileName: string);
var
  F: file of TFilm;
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

destructor TFilmList.Destroy;
begin
   while not IsEmpty() do
   begin
     DeleteFilm(1);
   end;
   Dispose(Head);
   Dispose(Tail);//���� ����� invalid pointer operation ������ ��� ������}
end;

function TFilmList.IsEmpty():Boolean;
begin
  IsEmpty := Head = nil;
end;

procedure TFilmList.AddFilm(const Item: PFilm);     //appendItem
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

procedure TFilmList.DeleteFilm(FilmIndex: Integer);
var
   CurrTempFilm,PrevTempFilm: PFilm;
   i: Integer;
begin
  if not IsEmpty() then
  begin
    if fICount > 1  then
    begin
      if FilmIndex > 1 then
      begin
        PrevTempFilm := Head;
        while PrevTempFilm.Item.Index <> FilmIndex - 1 do
           PrevTempFilm := PrevTempFilm.Next;
        CurrTempFilm := PrevTempFilm.Next;
        PrevTempFilm.Next := CurrTempFilm.Next;
        if CurrTempFilm = Tail then
           Tail := PrevTempFilm;
        Dispose(CurrTempFilm);
      end
      else
      begin
        CurrTempFilm := Head;
        Head := Head.Next;
        Dispose(CurrTempFilm);
      end;
    end
    else
    begin
      CurrTempFilm := Head;
      Head := nil;
      Tail := nil;
      Dispose(CurrTempFilm);
    end;
    i := 1;
    CurrTempFilm := Head;
    while CurrTempFilm <> nil do
    begin
       CurrTempFilm.Item.Index := i;
       Inc(i);
       CurrTempFilm := CurrTempFilm.Next;
    end;
    fIcount := i - 1;
  end;


{  �� �����
  Temp := Head;
  Head:=nil;
  Tail := nil;
  Dispose (Temp)
     }
end;

procedure CreateFilm(var List : TFilmList; const aItem : TItem );
var
  PFilmInfo : PFilm;
begin
  New(PFilmInfo);

  PFilmInfo^.Item := aItem;
  List.AddFilm(PFilmInfo);
end;

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

function GetFilmByIndex(var List : TFilmList; const aIndex : Integer) : PFilm;
var
  CurrNode : PFilm;
begin
  CurrNode := List.Head;
  while CurrNode.Item.Index <> aIndex + 1 do
    CurrNode := CurrNode.Next;
  Result := CurrNode;
end;

procedure EditFilm(var List : TFilmList; const aItem : TItem; const aIndex : Integer);
var
  CurrNode: PFilm;
begin
  CurrNode := List.Head;
  while CurrNode.Item.Index <> aIndex + 1 do
    CurrNode := CurrNode.Next;
  CurrNode^.Item := aItem;
end;

{ ����������� �������� ComboBox �� �������� �� ������ }
function GetGenre(const aItem : TItem) : Integer;
begin
  case aItem.Genre of
    Adventure: Result := 0;
    GAction: Result := 1;
    Comedy: Result := 2;
    Detective: Result := 3;
    Drama: Result := 4;
    Thriller: Result := 5;
    Fantasy: Result :=  6;
    Science_fiction: Result := 7;
    Horror: Result := 8;
    Historical: Result := 9;
    Mystery: Result := 10;
    Romance: Result := 11;
    Western: Result := 12;
    Animation: Result := 13;
    Musical: Result := 14;
    Satire: Result := 15;
    Social: Result := 16;
    Other: Result := 17;
  end;
end;

{����������� �������� ComboBox �� �������� �� ������ }
function GetRating(const aItem : TItem) : Integer;
var
  i: Integer;
begin
  case aItem.Rating of
    10: Result := 0;
    9: Result := 1;
    8: Result := 2;
    7: Result := 3;
    6: Result := 4;
    5: Result := 5;
    4: Result := 6;
    3: Result := 7;
    2: Result := 8;
    1: Result := 9;
  end;
end;

function TabGenre(Genre : TGenre): string;
begin
  case Genre of
    Adventure: Result := '�����������';      //� ���������
    GAction: Result := '����';
    Comedy: Result := '�������';
    Detective: Result := '��������';
    Drama: Result := '�����';
    Thriller: Result := '�������';
    Fantasy: Result := '����������';
    Science_fiction: Result := '������� ����������';
    Horror: Result :=  '�������';
    Historical: Result := '������������';
    Mystery: Result := '�������';
    Romance: Result := '���������';
    Western: Result := '�������';
    Animation: Result := '����������';
    Musical: Result := '�������';
    Satire: Result := '������';
    Social: Result := '����������';
    Other: Result := '������';
  end;
end;

end.
