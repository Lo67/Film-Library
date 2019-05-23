program MyLibray;

uses
  Vcl.Forms,
  Menu in 'Menu.pas' {frmMenu},
  FilmBase in 'FilmBase.pas' {frmFilmBase},
  TypeList in 'TypeList.pas',
  Feature in 'Feature.pas' {frmFeatures},
  FilmInfo in 'FilmInfo.pas' {frmFilmInfo};
//  UnitSearch in 'UnitSearch.pas' {frmSearch};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmFilmBase, frmFilmBase);
  Application.CreateForm(TfrmFeatures, frmFeatures);
  Application.CreateForm(TfrmFilmInfo, frmFilmInfo);
 // Application.CreateForm(TfrmSearch, frmSearch);
  Application.Run;
end.
