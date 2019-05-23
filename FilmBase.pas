unit FilmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, TypeList,
  Feature, FilmInfo, Vcl.ExtDlgs;

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
    SaveReport: TSaveTextFileDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvFilmTabOnClick(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure ShowFilmInfo(Sender: TObject);
    procedure lvFilmTabColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvFilmTabCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  public
    procedure UpdateTab(List: TFilmList);
    function GetSelectIndex: Integer;
  private
    Descending: Boolean;
    SortedColumn: Integer;
  end;

var
  frmFilmBase: TfrmFilmBase;
  List: TFilmList;

implementation

{$R *.dfm}

uses
  Menu;

procedure TfrmFilmBase.FormCreate(Sender: TObject);
begin
  List := TFilmList.Create;
  UpdateTab(List);
  frmFilmBase.btnEdit.Enabled := False;
  frmFilmBase.btnDelete.Enabled := False;
  frmFilmBase.btnReport.Enabled := False;
end;

procedure TfrmFilmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMenu.Show;
end;

procedure TfrmFilmBase.UpdateTab(List: TFilmList);
var
  CurrNode: PFilm;
begin
  lvFilmTab.Clear;
  CurrNode := List.Head;
  lvFilmTab.Items.BeginUpdate;
  while CurrNode <> nil do
  begin
    with lvFilmTab.Items.Add do
    begin
      Caption := IntToStr(CurrNode^.Item.Index);
      SubItems.Add(CurrNode^.Item.Title);
      SubItems.Add(IntToStr(CurrNode^.Item.Year));
      SubItems.Add(CurrNode^.Item.Country);
      SubItems.Add(CurrNode^.Item.Director.LastName);
      SubItems.Add(frmFeatures.TabGenre(CurrNode^.Item.Genre));
      SubItems.Add(IntToStr(CurrNode^.Item.Duration));;
      if CurrNode^.Item.Ready then
      begin
        SubItems.Add(' +');
        SubItems.Add(IntToStr(CurrNode^.Item.Rating));
      end
      else
      begin
        SubItems.Add('  -');
        SubItems.Add(' -')
      end;
    end;
    CurrNode := CurrNode^.Next;
  end;
  lvFilmTab.Items.EndUpdate;
end;

procedure TfrmFilmBase.btnSelectClick(Sender: TObject);
begin

  if lvFilmTab.Checkboxes = False then
  begin
    lvFilmTab.Checkboxes := True;

  end
  else
  begin
    lvFilmTab.Checkboxes := False;
  end;
end;

procedure TfrmFilmBase.btnAddClick(Sender: TObject);
begin
  frmFeatures.Tag := 1;
  frmFeatures.edtBudget.Text := ' млн. $';
  frmFeatures.edtBoxOffice.Text := ' $';
  frmFeatures.ShowModal;
end;

procedure TfrmFilmBase.btnDeleteClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetSelectIndex + 1;
  List.DeleteFilm(Index);
  List.SaveList(FILE_NAME);
  UpdateTab(List);
  frmFilmBase.btnEdit.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnDelete.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnReport.Enabled := lvFilmTab.ItemIndex <> -1;
end;

procedure TfrmFilmBase.btnEditClick(Sender: TObject);
var
  Index: Integer;
  CurrNode: PFilm;
begin
  frmFeatures.Tag := 2;
  Index := GetSelectIndex;
  CurrNode := List.GetFilmByIndex(Index);

  with frmFeatures do
  begin
    edtTitle.Text := CurrNode.Item.Title;
    edtDirectorLastName.Text := CurrNode.Item.Director.LastName;
    edtDirectorName.Text := CurrNode.Item.Director.Name;
    edtDirectorMiddleName.Text := CurrNode.Item.Director.MiddleName;
    cmbbxGenre.ItemIndex := frmFeatures.GetGenre(CurrNode.Item);
    edtCountry.Text := CurrNode.Item.Country;
    edtYear.Text := IntToStr(CurrNode.Item.Year);
    edtDuration.Text := IntToStr(CurrNode.Item.Duration);
    edtWords.Text := CurrNode.Item.Words;
    edtAwards.Text := CurrNode.Item.Awards;
    edtBudget.Text := CurrNode.Item.Budget;
    edtBoxOffice.Text := CurrNode.Item.BoxOffice;
    chbxReady.Checked := CurrNode.Item.Ready;
    if CurrNode.Item.Ready then
      cmbbxRating.ItemIndex := frmFeatures.GetRating(CurrNode.Item)
    else
      cmbbxRating.ItemIndex := -1;
  end;

  frmFilmBase.btnEdit.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnDelete.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnReport.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFeatures.ShowModal;
end;

procedure TfrmFilmBase.btnMenuClick(Sender: TObject);
begin
  frmFilmBase.Close;
  frmMenu.Show;
end;

procedure TfrmFilmBase.btnReportClick(Sender: TObject);
var
  CurrNode: PFilm;
  Index: Integer;
  F: TextFile;
  temp: Word;
begin
  Index := GetSelectIndex;
  CurrNode := List.GetFilmByIndex(Index);

  if SaveReport.Execute then
  begin
    AssignFile(F, SaveReport.FileName { + '.txt' } );
    Rewrite(F);
    Write(F, CurrNode.Item.Title, ', ', CurrNode.Item.Year, ', ',
      CurrNode.Item.Country, ', ', frmFeatures.TabGenre(CurrNode.Item.Genre),
      ', ', CurrNode.Item.Director.Name, ' ', CurrNode.Item.Director.LastName);
    CloseFile(F);
    MessageBox(Handle, PChar('Отчёт успешно создан!'),
      PChar('Внимание!'), MB_OK);
  end;
end;

function TfrmFilmBase.GetSelectIndex(): Integer;
var
  Index : Integer;
begin
  Index := lvFilmTab.ItemIndex;
  Result := StrToInt(lvFilmTab.Items[Index].Caption) - 1;
end;

procedure TfrmFilmBase.lvFilmTabOnClick(Sender: TObject);
begin
  frmFilmBase.btnEdit.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnDelete.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnReport.Enabled := lvFilmTab.ItemIndex <> -1;
end;

procedure TfrmFilmBase.ShowFilmInfo(Sender: TObject);
var
  Index: Integer;
  CurrNode: PFilm;
begin
  Index := GetSelectIndex;
  CurrNode := List.GetFilmByIndex(Index);
  with frmFilmInfo do
  begin
    lblRealTitel.Caption := CurrNode.Item.Title;
    lblRealDirectorLastName.Caption := CurrNode.Item.Director.LastName;
    lblRealDirectorName.Caption := CurrNode.Item.Director.Name;
    lblRealDirectorMiddleName.Caption := CurrNode.Item.Director.MiddleName;
    lblRealGenre.Caption := frmFeatures.TabGenre(CurrNode.Item.Genre);
    lblRealCountry.Caption := CurrNode.Item.Country;
    lblRealYear.Caption := IntToStr(CurrNode.Item.Year);
    lblRealDuration.Caption := IntToStr(CurrNode.Item.Duration);
    lblRealWords.Caption := CurrNode.Item.Words;
    lblRealAwards.Caption := CurrNode.Item.Awards;
    lblRealBudget.Caption := CurrNode.Item.Budget;
    lblRealBoxOffice.Caption := CurrNode.Item.BoxOffice;
    chbxReady.Checked := CurrNode.Item.Ready;
    chbxReady.Enabled := False;
    if CurrNode.Item.Ready then
      lblRealRating.Caption := IntToStr(CurrNode.Item.Rating)
    else
      lblRealRating.Caption := '';
  end;
  frmFilmInfo.ShowModal;
end;

procedure TfrmFilmBase.lvFilmTabColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end
  else
    Descending := not Descending;
  TListView(Sender).SortType := stText;
end;

procedure TfrmFilmBase.lvFilmTabCompare(Sender: TObject;Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
function CompareTextAsInteger(const S1,S2: string):Integer;
begin
   if (StrToInt(S1) < StrToInt(S2)) and not Descending then
      CompareTextAsInteger := -1
   else
      CompareTextAsInteger := 1;
end;
begin
  if SortedColumn = 0 then
  begin
    Compare := CompareText(Item1.Caption, Item2.Caption);
    Compare := CompareTextAsInteger(Item1.Caption, Item2.Caption);
  end
  else
    Compare := CompareText(Item1.SubItems[SortedColumn - 1],
      Item2.SubItems[SortedColumn - 1]);
  if Descending then
    Compare := -Compare;
end;

end.
