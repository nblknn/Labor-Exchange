Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

Const
    MAXLEN = 20;
    MINSALARY = 1;
    MAXSALARY = 99_999;
    MINVACATION = 1;
    MAXVACATION = 99;
    MINWORKAGE = 14;
    MAXWORKAGE = 99;

Type
    TMainForm = Class(TForm)
    MainMenu: TMainMenu;
    MMProgramInfo: TMenuItem;
    Label1: TLabel;
    ButtonFirmList: TButton;
    ButtonCandidateList: TButton;
    ButtonDeficite: TButton;
    procedure ButtonFirmListClick(Sender: TObject);
    procedure ButtonCandidateListClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses FirmListUnit, CandidateListUnit;

procedure TMainForm.ButtonCandidateListClick(Sender: TObject);
begin
    CandidateListForm.ShowModal;
end;

procedure TMainForm.ButtonFirmListClick(Sender: TObject);
begin
     FirmListForm.ShowModal;
end;

End.
