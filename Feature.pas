unit Feature;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls {System.Classes,}, TypeList,
  Vcl.Menus;

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
    function cmbbxGenreChange(Sender: TObject) : TGenre;
    function cmbbxRatingChange(Sender: TObject) : TRating;
    procedure chbxReadyClick(Sender: TObject);
    procedure edtYearKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
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

{ Определение жанра по значению из ComboBox }
function TfrmFeatures.cmbbxGenreChange(Sender: TObject) : TGenre;
begin
  case cmbbxGenre.ItemIndex of
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

{ Определение рейтинга по значению из ComboBox}
function TfrmFeatures.cmbbxRatingChange(Sender: TObject) : TRating;
begin
  case cmbbxRating.ItemIndex of
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


procedure TfrmFeatures.edtYearKeyPress(Sender: TObject; var Key: Char);
const
   Digits = ['0'..'9'];
begin
   if not (Key in Digits) then
      Key := #0;                         //Не работает BackSpace
end;

procedure TfrmFeatures.FormCreate(Sender: TObject);
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
end;

procedure TfrmFeatures.btnOKClick(Sender: TObject);
var
  Info: TItem;
  Index:Integer;
begin
  { Проверка првильности введенных полей }
  if (edtTitle.Text = '') or (edtDirectorLastName.Text = '') or
  (edtDirectorName.Text = '' ) or (cmbbxGenre.ItemIndex = -1) or
  (edtCountry.Text = '') or (edtYear.Text = '') or
  (edtDuration.Text = '') then
    MessageBox(Handle, PChar('Не все необходимые поля заполнены!'),PChar('ВНИМАНИЕ!'), MB_ICONWARNING+MB_OK)
  else
  begin
    with Info do
    begin
      if frmFeatures.Tag = 1 then
        Index := List.fICount + 1
      else
         Index := frmFilmBase.lvFilmTab.ItemIndex + 1;
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
      if  Info.Ready then
        Info.Rating :=  cmbbxRatingChange(cmbbxRating);
    end;
  end;

  if frmFeatures.Tag = 1 then
    CreateFilm(List,Info)
  else
  begin
    Index := frmFilmBase.lvFilmTab.ItemIndex;
    EditFilm(List,Info,Index);
  end;

  frmFilmBase.UpdateTab(List);
  SaveList(List,FILE_NAME);

  ClearFeaturesEdits;
  frmFeatures.Tag := 0;
  frmFeatures.Close;

end;

end.
