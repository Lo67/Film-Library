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

  private
    { Private declarations }
  public
     //FilmList : TFilmList;
  procedure UpdateTab(List : TFilmList);
  end;

  //KAJSLGKJALDKFJADKLF

var
  frmFilmBase: TfrmFilmBase;
  List : TFilmList;

implementation

{$R *.dfm}
uses
  Menu;
procedure TfrmFilmBase.btnAddClick(Sender: TObject);
begin
  frmFeatures.ShowModal;
end;

procedure TfrmFilmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   frmMenu.Show;
end;

procedure TfrmFilmBase.FormCreate(Sender: TObject);
begin
  List := TFilmList.Create('Films');
end;

procedure TfrmFilmBase.UpdateTab(List: TFilmList);
var
  CurrNode: PFilm;
begin
  CurrNode := List.Head;
  while CurrNode{.Next} <> nil do
  begin

    with lvFilmTab.Items.Add do
    begin
      Caption := IntToStr(CurrNode^.Item.Index);
      SubItems.Add(CurrNode^.Item.Title);
      SubItems.Add(IntToStr(CurrNode^.Item.Year));
      SubItems.Add(CurrNode^.Item.Country);
      SubItems.Add(CurrNode^.Item.Director.LastName);
      SubItems.Add(''{CurrNode^.Item.Genre});
      SubItems.Add(IntToStr(CurrNode^.Item.Duration));;
      if CurrNode^.Item.Ready then
        SubItems.Add('+')
      else
        SubItems.Add('');
      SubItems.Add(IntToStr(CurrNode^.Item.Rating));
    end;
      CurrNode := CurrNode^.Next;
  end;
end;

end.
