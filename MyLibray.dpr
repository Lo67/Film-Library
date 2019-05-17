program MyLibray;

uses
  Vcl.Forms,
  Menu in 'Menu.pas' {frmMenu},
  FilmBase in 'FilmBase.pas' {frmFilmBase},
  OperationList in 'OperationList.pas',
  TypeList in 'TypeList.pas',
  Feature in 'Feature.pas' {frmFeatures};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmFilmBase, frmFilmBase);
  Application.CreateForm(TfrmFeatures, frmFeatures);
  Application.Run;
end.
