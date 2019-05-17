unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Buttons;

type
  TfrmMenu = class(TForm)
    btnFilmBase: TButton;
    btnAboutProgram: TButton;
    btnExit: TButton;
    procedure btnFilmBaseClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
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

procedure TfrmMenu.btnExitClick(Sender: TObject);
begin
  frmMenu.Close;
end;

procedure TfrmMenu.btnFilmBaseClick(Sender: TObject);
begin
{  frmFilmBase.Show;
  frmMenu.Visible := False; }
  frmMenu.Hide;
  frmFilmBase.ShowModal;
end;

end.
