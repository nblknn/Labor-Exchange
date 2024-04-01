unit VacancyUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TVacancyForm = class(TForm)
    MainMenu: TMainMenu;
    MMInstruction: TMenuItem;
    LabelName: TLabel;
    LabelSpeciality: TLabel;
    LabelPosition: TLabel;
    LabelVacationDays: TLabel;
    LabelHighEducation: TLabel;
    LabelSalary: TLabel;
    LabelMinAge: TLabel;
    LabelMaxAge: TLabel;
    EditName: TEdit;
    EditSalary: TEdit;
    EditPosition: TEdit;
    EditSpeciality: TEdit;
    EditVacationDays: TEdit;
    EditMinAge: TEdit;
    Edit7: TEdit;
    RadioButtonRequired: TRadioButton;
    RadioButtonNotRequired: TRadioButton;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VacancyForm: TVacancyForm;

implementation

{$R *.dfm}

procedure TVacancyForm.ButtonCancelClick(Sender: TObject);
begin
    Close;
end;

procedure TVacancyForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_ESCAPE then
       Close;
end;

end.
