unit FilmInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls {System.Classes,} ,
  TypeList,
  Vcl.Menus;

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
    chbxReady: TCheckBox;
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
  end;

var
  frmFilmInfo: TfrmFilmInfo;

implementation

{$R *.dfm}



end.
