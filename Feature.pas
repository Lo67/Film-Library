unit Feature;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls {System.Classes,}, TypeList;

type
  TfrmFeatures = class(TForm)
    edtTitle: TEdit;
    edtDirectorLastName: TEdit;
    edtDirectorName: TEdit;
    edtDirectorMiddleName: TEdit;
    edtCountry: TEdit;
    edtDuration: TEdit;
    edtWords: TEdit;
    edtAwards: TEdit;
    edtBudget: TEdit;
    edtBoxOffice: TEdit;
    lblTitel: TLabel;
    lblDirectorLastName: TLabel;
    lblDirectorName: TLabel;
    lblDirectorMiddleName: TLabel;
    lblGenre: TLabel;
    lblCountry: TLabel;
    lblYear: TLabel;
    lblDuration: TLabel;
    lblWords: TLabel;
    lblAwards: TLabel;
    lblBudget: TLabel;
    lblBoxOffice: TLabel;
    lblReady: TLabel;
    lblRating: TLabel;
    lblDirector: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    cmbbxGenre: TComboBox;
    cmbbxRating: TComboBox;
    chbxReady: TCheckBox;
    edtYear: TEdit;
    procedure btnOKClick(Sender: TObject);
    function cmbbxGenreChange(Sender: TObject) : TGenre;
    function cmbbxRatingChange(Sender: TObject) : TRating;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    frmFeatures: TfrmFeatures;

implementation

uses
  FilmBase;

{$R *.dfm}

{ ќпределение жанра по значению из ComboBox }
function TfrmFeatures.cmbbxGenreChange(Sender: TObject) : TGenre;
var
  i : Integer;
begin
  i := cmbbxGenre.ItemIndex;
  case i of
    0: Result := Adventure;
    1: Result := GAction;
    2: Result := Comedy;
    3: Result := Detective;
    4: Result := Drama;
    5: Result := Thriller;
    6: Result := Fantasy ;
    7: Result :=Science_fiction;
    8: Result :=  Horror;
    9: Result := Historical;
    10: Result := Mystery;
    11: Result := Romance;
    12: Result := Western;
    13: Result := Animation;
    14: Result := Musical;
    15: Result := Satire;
    16: Result := Social;
    17: Result := Other;
  end;

end;

{ ќпределение рейтинга по значению из ComboBox}
function TfrmFeatures.cmbbxRatingChange(Sender: TObject) : TRating;
var
  i : Integer;
begin
  i := cmbbxRating.ItemIndex;
  case i of
    0: Result := 10;
    1: Result := 9;
    2: Result := 8;
    3: Result := 7;
    4: Result := 6;
    5: Result := 5;
    6: Result := 4;
    7: Result := 3;
    8: Result := 2;
    9: Result := 1;
  end;
end;

procedure TfrmFeatures.btnOKClick(Sender: TObject);
var
  Info: TItem;
begin
  with Info do
  begin
    Index := List.fICount + 1;
    Title := edtTitle.Text;
    Director.LastName := edtDirectorLastName.Text;
    Director.Name := edtDirectorName.Text;
    Director.MiddleName := edtDirectorMiddleName.Text;
    Genre := cmbbxGenreChange(cmbbxGenre);
    Country := edtCountry.Text;
    Year := StrToInt(edtYear.Text);
    Duration := StrToInt(edtDuration.Text);
    Words := edtWords.Text;
    Awards := edtAwards.Text;
    Budget := edtBudget.Text;
    BoxOffice := edtBoxOffice.Text;
    Ready := chbxReady.Checked;
    if not Info.Ready then
      cmbbxRating.Enabled                       // ќ—я 
    else
      Info.Rating :=  cmbbxRatingChange(cmbbxRating);
  end;

  CreateFilm(List,Info);
  frmFilmBase.UpdateTab(List);
  SaveList(List,FILE_NAME);

  frmFeatures.Close;
end;

end.
