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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  FilmBase;

{$R *.dfm}

procedure TfrmMenu.btnAboutProgramClick(Sender: TObject);
begin
  frmAboutProgramm.ShowModal;
end;

procedure TfrmMenu.btnExitClick(Sender: TObject);
begin
  List.SaveList(FILE_NAME);
  frmMenu.Close;
  List.Destroy;
end;

procedure TfrmMenu.btnFilmBaseClick(Sender: TObject);
begin
  frmMenu.Hide;
  frmFilmBase.ShowModal;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  List.SaveList(FILE_NAME);
  List.Destroy;
end;

end.
