unit FilmInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls {System.Classes,} ,
  TypeList,
  Vcl.Menus, FilmBase;

type
  TfrmFilmInfo = class(TForm)
    lblTitel: TLabel;
    lblDirectorLastName: TLabel;
    lblDirectorName: TLabel;
    lblDirectorMiddleName: TLabel;
    lblGenre: TLabel;
    lblCountry: TLabel;
    lblYear: TLabel;
    lblDuration: TLabel;
    lblWords: TLabel;
    lblAwards: TLabel;
    lblBudget: TLabel;
    lblBoxOffice: TLabel;
    lblReady: TLabel;
    lblRating: TLabel;
    lblDirector: TLabel;
    btnOK: TButton;
    lblRealTitel: TLabel;
    lblRealDirectorLastName: TLabel;
    lblRealDirectorName: TLabel;
    lblRealDirectorMiddleName: TLabel;
    lblRealGenre: TLabel;
    lblRealCountry: TLabel;
    lblRealYear: TLabel;
    lblRealDuration: TLabel;
    lblRealWords: TLabel;
    lblRealAwards: TLabel;
    lblRealBudget: TLabel;
    lblRealBoxOffice: TLabel;
    lblRealRating: TLabel;
    lblRealReady: TLabel;
    procedure btnOKClick(Sender: TObject);
  end;

var
  frmFilmInfo: TfrmFilmInfo;

implementation

{$R *.dfm}

{ Нажатие на кнопку ОК }
procedure TfrmFilmInfo.btnOKClick(Sender: TObject);
begin
  frmFilmInfo.Close;
  frmFilmBase.btnEdit.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnDelete.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
  frmFilmBase.btnReport.Enabled := frmFilmBase.lvFilmTab.ItemIndex <> -1;
end;

end.
