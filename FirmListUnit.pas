unit FirmListUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls;

type
  TFirmListForm = class(TForm)
    MainMenu: TMainMenu;
    N1: TMenuItem;
    MMOpenFile: TMenuItem;
    MMSaveFile: TMenuItem;
    ListView1: TListView;
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    ButtonSearch: TButton;
    ButtonFindCandidates: TButton;
    procedure ButtonAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FirmListForm: TFirmListForm;

implementation

{$R *.dfm}

Uses VacancyUnit;

procedure TFirmListForm.ButtonAddClick(Sender: TObject);
begin
    VacancyForm.ShowModal;
end;

end.
