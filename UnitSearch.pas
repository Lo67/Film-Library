unit UnitSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FilmBase, TypeList;

type
  TfrmSearch = class(TForm)
    lblHint1: TLabel;
    cmbbxSearchCriteria: TComboBox;
    lblHint2: TLabel;
    edtSearch: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure cmbbxSearchCriteriaChange(Sender: TObject);
  private
    procedure SearchByTitle(var List : TFilmList; Str : string);
    procedure SearchByYear(var List : TFilmList; Str : string);
    procedure SearchByCountry(var List : TFilmList; Str : string);
    procedure SearchByDirector(var List : TFilmList; Str : string);
    procedure SearchByWords(var List : TFilmList; Str : string);
    procedure SearchByDureation(var List : TFilmList; Str : string);
    function CompareStirng(StrList, StrSearch : string) : Boolean;
  public
    { Public declarations }
  end;

var
  frmSearch: TfrmSearch;

implementation

{$R *.dfm}

procedure TfrmSearch.cmbbxSearchCriteriaChange(Sender: TObject);
begin
  case cmbbxSearchCriteria. of
    0: SearchByTitle(edtSearch.Text, List);
    1: SearchByYear(edtSearch.Text);
    2: SearchByCountry(edtSearch.Text);
    3: SearchByDirector(edtSearch.Text);
    4: SearchByWords(edtSearch.Text);
    5: SearchByDureation(edtSearch.Text);
  end;
end;

function TfrmSearch.CompareStirng(StrList, StrSearch : string) : Boolean;
var
  Len1, Len2: Integer;
begin

end;

procedure TfrmSearch.SearchByTitle(var List : TFilmList; Str : string);
var
  CurrNode : PFilm;
begin
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin


    CurrNode := CurrNode^.Next;
  end;
end;

procedure TfrmSearch.SearchByYear(var List : TFilmList; Str : string);
begin

end;

procedure TfrmSearch.SearchByCountry(var List : TFilmList; Str : string);
begin

end;

procedure TfrmSearch.SearchByDirector(var List : TFilmList; Str : string);
begin

end;

procedure TfrmSearch.SearchByWords(var List : TFilmList; Str : string);
begin

end;

procedure TfrmSearch.SearchByDureation(var List : TFilmList; Str : string);
begin

end;

end.
