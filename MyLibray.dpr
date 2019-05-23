program MyLibray;

uses
  Vcl.Forms,
  Menu in 'Menu.pas' {frmMenu},
  FilmBase in 'FilmBase.pas' {frmFilmBase},
  TypeList in 'TypeList.pas',
  Feature in 'Feature.pas' {frmFeatures},
  FilmInfo in 'FilmInfo.pas' {frmFilmInfo},
  UnitAlgoritms in 'UnitAlgoritms.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmFilmBase, frmFilmBase);
  Application.CreateForm(TfrmFeatures, frmFeatures);
  Application.CreateForm(TfrmFilmInfo, frmFilmInfo);
  Application.Run;
end.
