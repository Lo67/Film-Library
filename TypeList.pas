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
  TGenre = (Adventure, GAction, Comedy, Detective, Drama, Thriller, Fantasy,
    Science_fiction, Horror, Historical, Mystery, Romance, Western, Animation,
    Musical, Satire, Social, Other);
  TCountry = string[30];
  TYear = Integer;
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

  TFilmList = class
    EntryPoint: PFilm;
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

{ Конструктор создания списка при запуске программы }
constructor TFilmList.Create;
begin
  New(EntryPoint);
  EntryPoint.Next := nil;
  Head := nil;
  Tail := nil;
  UploadFile(FILE_NAME);
end;

{ Деструктор. Разрушение списка при закрытии программы }
destructor TFilmList.Destroy;
begin
  while not IsEmpty() do
  begin
    DeleteFilm(1);
    RestoreIndexing()
  end;
  Dispose(EntryPoint);
end;

{ Проверка на существования элементов в списке }
function TFilmList.IsEmpty(): Boolean;
begin
  Result := EntryPoint.Next = nil;
end;

{ Загрузки фильмов из файла }
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

{ Сохранение фильмов в файл }
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

{ Создание нового фильма }
procedure TFilmList.CreateFilm(const aItem: TItem);
var
  PFilmInfo: PFilm;
begin
  New(PFilmInfo);
  PFilmInfo^.Item := aItem;
  AddFilm(PFilmInfo);
end;

{ Добавление нового фильма в таблицу }
procedure TFilmList.AddFilm(const Item: PFilm);
begin
  if EntryPoint.Next = nil then
  begin
    EntryPoint.Next := Item;
    Head := Item;
    Tail := Item;
    Item.Next := nil;
  end
  else
  begin
    Tail.Next := Item;
    Tail := Item;
    Tail.Next := nil;
  end;
  Inc(fICount);
end;

{ Редактирование фильма }
procedure TFilmList.EditFilm(const aItem: TItem; const aIndex: Integer);
var
  CurrNode: PFilm;
begin
  CurrNode := EntryPoint.Next;
  while CurrNode.Item.Index <> aIndex + 1 do
    CurrNode := CurrNode.Next;
  CurrNode^.Item := aItem;
  SaveList(FILE_NAME);
end;

{ Удаление фильма из списка }
procedure TFilmList.DeleteFilm(const FilmIndex: Integer);
var
  CurrNode, PrevNode: PFilm;
begin
  if not IsEmpty() then
  begin
    PrevNode := EntryPoint;
    while PrevNode.Next.Item.Index <> FilmIndex  do
      PrevNode := PrevNode.Next;
    CurrNode := PrevNode.Next;
    PrevNode.Next := CurrNode.Next;
    if CurrNode = Tail then
      Tail := PrevNode;
    Dispose(CurrNode);
  end;
end;

{ Получение элемента списка по индексу }
function TFilmList.GetFilmByIndex(const aIndex: Integer): PFilm;
var
  CurrNode: PFilm;
begin
  CurrNode := EntryPoint.Next;
  while CurrNode.Item.Index <> aIndex + 1 do
    CurrNode := CurrNode.Next;
  Result := CurrNode;
end;

{ Переиндексация фильмов }
procedure TFilmList.RestoreIndexing();
var
  i: Integer;
  CurrNode : PFilm;
begin
  i := 1;
  CurrNode := EntryPoint.Next;
  while CurrNode <> nil do
  begin
    CurrNode.Item.Index := i;
    Inc(i);
    CurrNode := CurrNode.Next;
  end;
  FICount := i - 1;
end;

end.
