unit UnitAboutProgramm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmAboutProgramm = class(TForm)
    lblAboutProgramm: TLabel;
    procedure FormCreate(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutProgramm: TfrmAboutProgramm;

implementation

{$R *.dfm}

procedure TfrmAboutProgramm.FormCreate(Sender: TObject;
  var Action: TCloseAction);
begin
 // lblAboutProgramm.Caption := 'ѕрограмма позвол€ет в удобной и доступной пользователю форме систематизирвать информачию об имеющихс€ фильмах. ¬ы можете добавить, редактировать, сортировать и удал€ть фильмы в вашем каталоге. ќсуществл€ть просмотр дополнительной информации, а так же искать фильмы по выбраным критери€м. '
end;

end.
