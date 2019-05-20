unit FilmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, TypeList, Feature;

type
  TfrmFilmBase = class(TForm)
    lvFilmTab: TListView;
    btnSelect: TButton;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnReport: TButton;
    btnSearch: TButton;
    btnMenu: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);

  private
    { Private declarations }
  public
     //FilmList : TFilmList;
    procedure UpdateTab(List : TFilmList);
    function GetSelectIndex(): Integer;
  end;

var
  frmFilmBase: TfrmFilmBase;
  List : TFilmList;

implementation

{$R *.dfm}
uses
  Menu;
procedure TfrmFilmBase.btnAddClick(Sender: TObject);
begin
  frmFeatures.Tag := 1;
  frmFeatures.ShowModal;
end;

procedure TfrmFilmBase.btnEditClick(Sender: TObject);
var
  Index: Integer;
  CurrNode: PFilm;
begin
  frmFeatures.Tag := 2;
  Index := frmFilmBase.lvFilmTab.ItemIndex;
  CurrNode := GetFilmByIndex(List,Index);

  frmFeatures.edtTitle.Text := CurrNode.Item.Title;
  frmFeatures.edtDirectorLastName.Text := CurrNode.Item.Director.LastName;
  frmFeatures.edtDirectorName.Text := CurrNode.Item.Director.Name;
  frmFeatures.edtDirectorMiddleName.Text := CurrNode.Item.Director.MiddleName;
  frmFeatures.cmbbxGenre.ItemIndex := GetGenre(CurrNode.Item);
  frmFeatures.edtCountry.Text := CurrNode.Item.Country;
  frmFeatures.edtYear.Text := IntToStr(CurrNode.Item.Year);
  frmFeatures.edtDuration.Text := IntToStr(CurrNode.Item.Duration);
  frmFeatures.edtWords.Text := CurrNode.Item.Words;
  frmFeatures.edtAwards.Text := CurrNode.Item.Awards;
  frmFeatures.edtBudget.Text := CurrNode.Item.Budget;
  frmFeatures.edtBoxOffice.Text := CurrNode.Item.BoxOffice;
  frmFeatures.chbxReady.Checked := CurrNode.Item.Ready;
  if CurrNode.Item.Ready then
    frmFeatures.cmbbxRating.ItemIndex := GetRating(CurrNode.Item)
  else
    frmFeatures.cmbbxRating.ItemIndex := -1;

  frmFeatures.ShowModal;
end;

function TfrmFilmBase.GetSelectIndex(): Integer;
begin
  Result := lvFilmTab.ItemIndex;
end;

procedure TfrmFilmBase.btnSelectClick(Sender: TObject);
begin
 if lvFilmTab.Checkboxes = False then
  lvFilmTab.Checkboxes := True
 else
  lvFilmTab.Checkboxes := False;
end;

procedure TfrmFilmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   frmMenu.Show;
end;

procedure TfrmFilmBase.FormCreate(Sender: TObject);
begin
  List := TFilmList.Create;                  //
  UpdateTab(List);                                      //
end;

procedure TfrmFilmBase.UpdateTab(List: TFilmList);
var
  CurrNode: PFilm;
begin
  lvFilmTab.Clear;
  CurrNode := List.Head;
  while CurrNode <> nil do
  begin
    with lvFilmTab.Items.Add do
    begin
      Caption := IntToStr(CurrNode^.Item.Index);
      SubItems.Add(CurrNode^.Item.Title);
      SubItems.Add(IntToStr(CurrNode^.Item.Year));
      SubItems.Add(CurrNode^.Item.Country);
      SubItems.Add(CurrNode^.Item.Director.LastName);
      SubItems.Add(TabGenre(CurrNode^.Item.Genre));
      SubItems.Add(IntToStr(CurrNode^.Item.Duration));;
      if CurrNode^.Item.Ready then
      begin
        SubItems.Add('+');
        SubItems.Add(IntToStr(CurrNode^.Item.Rating));
      end
      else
      begin
        SubItems.Add('-');
        SubItems.Add('-')
      end;

    end;
      CurrNode := CurrNode^.Next;
  end;
end;



end.
