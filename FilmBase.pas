unit FilmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, TypeList,
  Vcl.ExtDlgs,  Vcl.ExtCtrls;

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
    cmbbxSearchCriteria: TComboBox;
    edtSearch: TEdit;
    lblHint1: TLabel;
    lblHint2: TLabel;
    pnlSearch: TPanel;
    btnSearchFilm: TButton;
    btnBack: TButton;
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
    procedure btnSearchClick(Sender: TObject);
    function cmbbxSearchCriteriaChange(Sender: TObject) : Integer;
    procedure btnSearchFilmClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure lvFilmTabItemChecked(Sender: TObject; Item: TListItem);
  public
    procedure UpdateTab(List: TFilmList);
    procedure DrawOneFilm(CurrNode : PFilm);
    function GetSelectIndex: Integer;
    procedure Mistake;
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
  Menu, UnitAlgoritms, FilmInfo, Feature;

{ Создание формы }
procedure TfrmFilmBase.FormCreate(Sender: TObject);
begin
  List := TFilmList.Create;
  UpdateTab(List);
  frmFilmBase.btnEdit.Enabled := False;
  frmFilmBase.btnDelete.Enabled := False;
  frmFilmBase.btnReport.Enabled := False;
end;

{ Закрытие формы }
procedure TfrmFilmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMenu.Show;
end;

{ Перерисовка таблицы }
procedure TfrmFilmBase.UpdateTab(List: TFilmList);
var
  CurrNode: PFilm;
begin
  List.RestoreIndexing();
  lvFilmTab.Clear;
  CurrNode := List.EntryPoint.Next;
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

{ Изменение критерия поиска }
function TfrmFilmBase.cmbbxSearchCriteriaChange(Sender: TObject) : Integer;
begin
  case cmbbxSearchCriteria.ItemIndex of
    0: Result := 0;
    1: Result := 1;
    2: Result := 2;
    3: Result := 3;
    4: Result := 4;
    5: Result := 5;
  end;
end;

{ Нажатие на поиск }
procedure TfrmFilmBase.btnSearchClick(Sender: TObject);
begin
  pnlSearch.Visible := True;
end;

{ Непосредственно поиск }
procedure TfrmFilmBase.btnSearchFilmClick(Sender: TObject);
begin
    if (cmbbxSearchCriteria.ItemIndex= -1) or (edtSearch.Text = '') then
      MessageBox(Handle, PChar('Не все необходимые поля заполнены!'),
        PChar('ВНИМАНИЕ!'), MB_ICONWARNING + MB_OK)
    else
    case cmbbxSearchCriteria.ItemIndex of
      0: SearchByTitle(edtSearch.Text);
      1: SearchByYear(edtSearch.Text);
      2: SearchByCountry(edtSearch.Text);
      3: SearchByDirector(edtSearch.Text);
      4: SearchByWords(edtSearch.Text);
      5: SearchByDuration(edtSearch.Text);
    end;
end;

{ Кнопка выбрать фильм }
procedure TfrmFilmBase.btnSelectClick(Sender: TObject);
begin

  if lvFilmTab.Checkboxes = False then
  begin
    lvFilmTab.Checkboxes := True;
    lvFilmTab.RowSelect := False;
    btnEdit.Enabled := False;
    frmFeatures.Tag := 3;
  end
  else
  begin
    lvFilmTab.Checkboxes := False;
    lvFilmTab.RowSelect := True;
    frmFeatures.Tag := 0;
  end;
end;

{ Кнопка добавить }
procedure TfrmFilmBase.btnAddClick(Sender: TObject);
begin
  frmFeatures.Tag := 1;
  ClearFeaturesEdits;
  frmFeatures.edtBudget.Text := ' млн. $';
  frmFeatures.edtBoxOffice.Text := ' $';
  frmFeatures.ShowModal;
end;

{ Кнопка назад }
procedure TfrmFilmBase.btnBackClick(Sender: TObject);
begin
  UpdateTab(List);
  pnlSearch.Visible := False;
end;

{  Удаления }
procedure TfrmFilmBase.btnDeleteClick(Sender: TObject);
var
  Index: Integer;
  i : Integer;
  Answer : Word;
begin
  Answer := MessageBox(Handle, PChar('Вы действительно хотите удалить фильмы? Отменить данное действие будет НЕВОЗМОЖНО!'),
    PChar('ВНИМАНИЕ!'), MB_OKCANCEL);
  if Answer = 1 then
  begin
    if frmFeatures.Tag = 3 then
    begin
      i := 0;
      while i < List.fICount do
      begin
        if lvFilmTab.Items[i].Checked then
        begin
          Index := StrToInt(lvFilmTab.Items[i].Caption);
          List.DeleteFilm(Index);
        end;
        Inc(i);
      end;
    end
    else
    begin
      Index := GetSelectIndex + 1;
      List.DeleteFilm(Index);
    end;
    List.SaveList(FILE_NAME);
    UpdateTab(List);
  end;

  frmFilmBase.btnEdit.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnDelete.Enabled := lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnReport.Enabled := lvFilmTab.ItemIndex <> -1;
end;

{ Кнопка редактирования }
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

{ Кнопка меню }
procedure TfrmFilmBase.btnMenuClick(Sender: TObject);
begin
  frmFilmBase.Close;
  frmMenu.Show;
end;

{ Кнопка отчет  }     //A1
procedure TfrmFilmBase.btnReportClick(Sender: TObject);
var
  CurrNode: PFilm;
  Index, i: Integer;
  F: TextFile;
  temp: Word;
begin
  if frmFeatures.Tag = 3 then
  begin
    if SaveReport.Execute then
    begin
      AssignFile(F, SaveReport.FileName+'.txt');
      Rewrite(F);
      for i := 0 to List.fICount-1 do
        if lvFilmTab.Items[i].Checked then
        begin
          Index := StrToInt(lvFilmTab.Items[i].Caption)-1;
          CurrNode := List.GetFilmByIndex(Index);
          Write(F, CurrNode.Item.Index, '. ',CurrNode.Item.Title, ', ', CurrNode.Item.Year, ', ',
                CurrNode.Item.Country, ', ', frmFeatures.TabGenre(CurrNode.Item.Genre),
                '. Режиссер: ', CurrNode.Item.Director.Name, ' ',
                 CurrNode.Item.Director.LastName,'.',#13#10);
        end;
      CloseFile(F);
      MessageBox(Handle, PChar('Отчёт успешно создан!'),
        PChar('Внимание!'), MB_OK);
    end;
  end
  else
  begin
    Index := GetSelectIndex;
    CurrNode := List.GetFilmByIndex(Index);
    if SaveReport.Execute then
    begin
      AssignFile(F, SaveReport.FileName+'.txt');
      Rewrite(F);
      Write(F, CurrNode.Item.Title, ', ', CurrNode.Item.Year, ', ',
        CurrNode.Item.Country, ', ', frmFeatures.TabGenre(CurrNode.Item.Genre),
        '. Режиссер: ', CurrNode.Item.Director.Name, ' ', CurrNode.Item.Director.LastName,'.');
      CloseFile(F);
      MessageBox(Handle, PChar('Отчёт успешно создан!'),
        PChar('Внимание!'), MB_OK);
    end;
  end;
end;


{ Получение индекса выделенного фильма }
function TfrmFilmBase.GetSelectIndex(): Integer;
var
  Index : Integer;
begin
  Index := lvFilmTab.ItemIndex;
  Result := StrToInt(lvFilmTab.Items[Index].Caption) - 1;
end;

{ Нажатие на таблицу  }
procedure TfrmFilmBase.lvFilmTabOnClick(Sender: TObject);
begin
  if frmFeatures.Tag = 3 then
  begin
    frmFilmBase.btnEdit.Enabled := True;
    frmFilmBase.btnDelete.Enabled := True;
    frmFilmBase.btnReport.Enabled := True;
  end
  else
  begin
    frmFilmBase.btnEdit.Enabled := lvFilmTab.ItemIndex <> -1;
    frmFilmBase.btnDelete.Enabled := lvFilmTab.ItemIndex <> -1;
    frmFilmBase.btnReport.Enabled := lvFilmTab.ItemIndex <> -1;
  end;
end;


{ подготовка к показу информации о фильме  }
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
    if CurrNode.Item.Ready then
      lblRealReady.Caption := 'Да'
    else
      lblRealReady.Caption := 'Нет';
    if CurrNode.Item.Ready then
      lblRealRating.Caption := IntToStr(CurrNode.Item.Rating)
    else
      lblRealRating.Caption := '';
  end;
  frmFilmInfo.ShowModal;
end;

{ Нажатие не колонку }
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


{ Сравнение }
procedure TfrmFilmBase.lvFilmTabCompare(Sender: TObject;Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
function CompareTextAsInteger(const S1,S2: string):Integer;
begin
   if (StrToInt(S1) < StrToInt(S2)) and not Descending then
      CompareTextAsInteger := 1
   else
      CompareTextAsInteger := -1;
end;
begin
  if SortedColumn = 0 then
  begin
    Compare := CompareTextAsInteger(Item1.Caption, Item2.Caption);
  end
  else
    Compare := CompareText(Item1.SubItems[SortedColumn - 1],
      Item2.SubItems[SortedColumn - 1]);
  if not Descending then
    Compare := -Compare;
end;


{Выделение галочкой }
procedure TfrmFilmBase.lvFilmTabItemChecked(Sender: TObject; Item: TListItem);
begin
  frmFilmBase.btnEdit.Enabled := True;
  frmFilmBase.btnDelete.Enabled := True;
  frmFilmBase.btnReport.Enabled := True;

  frmFeatures.Tag := 3;
end;

{ Прорисовка одного фильма для поиска }
procedure TfrmFilmBase.DrawOneFilm(CurrNode : PFilm);
begin
  lvFilmTab.Items.BeginUpdate;
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
  lvFilmTab.Items.EndUpdate;
end;

{ Сообщение об ошибке }
procedure TfrmFilmBase.Mistake;
begin
  MessageBox(Handle, PChar('Ни одного фильма не найдено'),
      PChar(':('), MB_OK);
end;

end.
