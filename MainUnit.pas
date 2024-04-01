Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

Type
    PFirm = ^TFirm;
    TFirm = record
        Name, Speciality, Position: String[30];
        Salary, VacationDays: Integer;
        IsHighEducationRequired: Boolean;
        MinAge, MaxAge: Integer;
        Next: PFirm;
    end;

    PCandidate = ^TCandidate;
    TCandidate = record
        Name, Surname, Patronymic: String[30];
        BirthDate: TDate;
        Speciality: String[30];
        HasHighEducation: Boolean;
        Position: String[30];
        MinSalary: Integer;
        Next: PCandidate;
    end;
    TMainForm = Class(TForm)
    MainMenu: TMainMenu;
    MMProgramInfo: TMenuItem;
    Label1: TLabel;
    ButtonFirmList: TButton;
    ButtonCandidateList: TButton;
    ButtonDeficite: TButton;
    procedure ButtonFirmListClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses FirmListUnit;

procedure TMainForm.ButtonFirmListClick(Sender: TObject);
begin
     FirmListForm.ShowModal;
end;

End.
