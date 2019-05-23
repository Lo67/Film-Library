unit Feature;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls {System.Classes,} ,
  TypeList, Vcl.Menus, FilmBase;

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
    PopupMenu1: TPopupMenu;
    procedure btnOKClick(Sender: TObject);
    function cmbbxGenreChange(Sender: TObject): TGenre;
    function cmbbxRatingChange(Sender: TObject): TRating;
    procedure chbxReadyClick(Sender: TObject);
    procedure edtYearKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    function GetGenre(const aItem: TItem): Integer;
    function TabGenre(Genre: TGenre): string;
    function GetRating(const aItem: TItem): Integer;
  end;

var
  frmFeatures: TfrmFeatures;

implementation

{$R *.dfm}

procedure TfrmFeatures.FormCreate(Sender: TObject);
begin
  if chbxReady.Checked = True then
    cmbbxRating.Enabled := True
  else
    cmbbxRating.Enabled := False;
end;

procedure ClearFeaturesEdits;
begin
  with frmFeatures do
  begin
    edtTitle.Text := '';
    edtDirectorLastName.Text := '';
    edtDirectorName.Text := '';
    edtDirectorMiddleName.Text := '';
    cmbbxGenre.ItemIndex := -1;
    edtCountry.Text := '';
    edtYear.Text := '';
    edtDuration.Text := '';
    edtWords.Text := '';
    edtAwards.Text := '';
    edtBudget.Text := '';
    edtBoxOffice.Text := '';
    chbxReady.Checked := False;
    cmbbxRating.ItemIndex := -1;
  end;
end;

procedure TfrmFeatures.chbxReadyClick(Sender: TObject);
begin
  if chbxReady.Checked = True then
    cmbbxRating.Enabled := True
  else
    cmbbxRating.Enabled := False;
end;

procedure TfrmFeatures.btnCancelClick(Sender: TObject);
begin
  ClearFeaturesEdits;
  frmFeatures.Close;
  frmFilmBase.btnEdit.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnDelete.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnReport.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
end;

procedure TfrmFeatures.btnOKClick(Sender: TObject);
var
  Info: TItem;
  Index: Integer;
begin
    if (edtTitle.Text = '') or (edtDirectorLastName.Text = '') or
      (edtDirectorName.Text = '') or (cmbbxGenre.ItemIndex = -1) or
      (edtCountry.Text = '') or (edtYear.Text = '') or (edtDuration.Text = '')
    then
      MessageBox(Handle, PChar('Не все необходимые поля заполнены!'),
        PChar('ВНИМАНИЕ!'), MB_ICONWARNING + MB_OK)
    else
    begin
      with Info do
      begin
        if frmFeatures.Tag = 1 then
          Index := List.fICount + 1
        else
          Index := frmFilmBase.GetSelectIndex + 1;
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
        if edtBudget.Text = ' млн. $' then
          Budget := ''
        else
          Budget := edtBudget.Text;
        if edtBoxOffice.Text = ' $' then
          BoxOffice := ''
        else
          BoxOffice := edtBoxOffice.Text;
        Ready := chbxReady.Checked;
        if Info.Ready then
          Info.Rating := cmbbxRatingChange(cmbbxRating);
      end;


      if frmFeatures.Tag = 1 then
        List.CreateFilm(Info)
      else
      begin
        Index := frmFilmBase.GetSelectIndex;
        List.EditFilm(Info, Index);
      end;

      frmFilmBase.UpdateTab(List);
      List.SaveList(FILE_NAME);

      ClearFeaturesEdits;
      frmFeatures.Tag := 0;
      frmFeatures.Close;
    end;

  frmFilmBase.btnEdit.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnDelete.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnReport.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
end;

{ Определение жанра по значению из ComboBox }
function TfrmFeatures.cmbbxGenreChange(Sender: TObject): TGenre;
begin
  case cmbbxGenre.ItemIndex of
    0:
      Result := Adventure;
    1:
      Result := GAction;
    2:
      Result := Comedy;
    3:
      Result := Detective;
    4:
      Result := Drama;
    5:
      Result := Thriller;
    6:
      Result := Fantasy;
    7:
      Result := Science_fiction;
    8:
      Result := Horror;
    9:
      Result := Historical;
    10:
      Result := Mystery;
    11:
      Result := Romance;
    12:
      Result := Western;
    13:
      Result := Animation;
    14:
      Result := Musical;
    15:
      Result := Satire;
    16:
      Result := Social;
    17:
      Result := Other;
  end;
end;

{ Определение рейтинга по значению из ComboBox }
function TfrmFeatures.cmbbxRatingChange(Sender: TObject): TRating;
begin
  case cmbbxRating.ItemIndex of
    0:
      Result := 10;
    1:
      Result := 9;
    2:
      Result := 8;
    3:
      Result := 7;
    4:
      Result := 6;
    5:
      Result := 5;
    6:
      Result := 4;
    7:
      Result := 3;
    8:
      Result := 2;
    9:
      Result := 1;
  end;
end;

procedure TfrmFeatures.edtYearKeyPress(Sender: TObject; var Key: Char);
const
  Digits = ['0' .. '9', #8];
begin
  if not(Key in Digits) then
    Key := #0;
end;

{ Определение значения ComboBox по рейтингу из списка }
function TfrmFeatures.GetGenre(const aItem: TItem): Integer;
begin
  case aItem.Genre of
    Adventure:
      Result := 0;
    GAction:
      Result := 1;
    Comedy:
      Result := 2;
    Detective:
      Result := 3;
    Drama:
      Result := 4;
    Thriller:
      Result := 5;
    Fantasy:
      Result := 6;
    Science_fiction:
      Result := 7;
    Horror:
      Result := 8;
    Historical:
      Result := 9;
    Mystery:
      Result := 10;
    Romance:
      Result := 11;
    Western:
      Result := 12;
    Animation:
      Result := 13;
    Musical:
      Result := 14;
    Satire:
      Result := 15;
    Social:
      Result := 16;
    Other:
      Result := 17;
  end;
end;

function TfrmFeatures.TabGenre(Genre: TGenre): string;
begin
  case Genre of
    Adventure:
      Result := 'Приключения';
    GAction:
      Result := 'Экшн';
    Comedy:
      Result := 'Комедия';
    Detective:
      Result := 'Детектив';
    Drama:
      Result := 'Драма';
    Thriller:
      Result := 'Триллер';
    Fantasy:
      Result := 'Фантастика';
    Science_fiction:
      Result := 'Научная фантастика';
    Horror:
      Result := 'Ужастик';
    Historical:
      Result := 'Исторический';
    Mystery:
      Result := 'Мистика';
    Romance:
      Result := 'Мелодрама';
    Western:
      Result := 'Вестерн';
    Animation:
      Result := 'Мультфильм';
    Musical:
      Result := 'Мьюзикл';
    Satire:
      Result := 'Сатира';
    Social:
      Result := 'Социальный';
    Other:
      Result := 'Другое';
  end;
end;

{ Определение значения ComboBox по рейтингу из списка }
function TfrmFeatures.GetRating(const aItem: TItem): Integer;
var
  i: Integer;
begin
  case aItem.Rating of
    10:
      Result := 0;
    9:
      Result := 1;
    8:
      Result := 2;
    7:
      Result := 3;
    6:
      Result := 4;
    5:
      Result := 5;
    4:
      Result := 6;
    3:
      Result := 7;
    2:
      Result := 8;
    1:
      Result := 9;
  end;
end;

end.
