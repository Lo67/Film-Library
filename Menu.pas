unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Buttons, UnitAboutProgramm, TypeList;

type
  TfrmMenu = class(TForm)
    btnFilmBase: TButton;
    btnAboutProgram: TButton;
    btnExit: TButton;
    procedure btnFilmBaseClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAboutProgramClick(Sender: TObject);
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  FilmBase;

{$R *.dfm}
{ Нажатие на кнопку "О программе" }
procedure TfrmMenu.btnAboutProgramClick(Sender: TObject);
begin
  frmAboutProgramm.ShowModal;
end;

{ Выход из программы }
procedure TfrmMenu.btnExitClick(Sender: TObject);
begin
  List.SaveList(FILE_NAME);
  frmMenu.Close;
  List.Destroy;
end;

{ Открытие фильмотеки }
procedure TfrmMenu.btnFilmBaseClick(Sender: TObject);
begin
  frmMenu.Hide;
  frmFilmBase.ShowModal;
end;

{ Закрытие форму через стандартные кнопки }
procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  List.SaveList(FILE_NAME);
  List.Destroy;
end;

end.
