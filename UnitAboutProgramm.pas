unit UnitAboutProgramm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmAboutProgramm = class(TForm)
    memAboutPr: TMemo;
    lblFilmBase: TLabel;
    lblAboutAuthor: TLabel;
    lblYear: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutProgramm: TfrmAboutProgramm;

implementation

{$R *.dfm}




end.
