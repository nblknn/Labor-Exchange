Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls;

Type
    TError = (Correct, ErrIncorrectValue, ErrIncorrectFileExt, ErrCantOpenFile,
      ErrCantSaveFile);

    TMainForm = Class(TForm)
        MainMenu: TMainMenu;
        MMProgramInfo: TMenuItem;
        Label1: TLabel;
        ButtonFirmList: TButton;
        ButtonCandidateList: TButton;
        ButtonDeficite: TButton;
        Procedure ButtonFirmListClick(Sender: TObject);
        Procedure ButtonCandidateListClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Const
    MAXLEN = 20;
    MINSALARY = 1;
    MAXSALARY = 99_999;
    MINVACATION = 1;
    MAXVACATION = 99;
    MINWORKAGE = 14;
    MAXWORKAGE = 99;
    ERRORMESSAGES: Array [TError] Of PWideChar = ('',
      '��������� ������������ ������!', '���� ������ ����� ���������� *.txt!',
      '��������� ������ ��� �������� �����!',
      '��������� ������ ��� ������ � ����!');

Procedure ShowErrorMessage(Error: TError);
Function CheckFileExtension(Path: String): TError;
Procedure ClearListView(ListView: TListView);

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses VacancyListUnit, CandidateListUnit;

Procedure ShowErrorMessage(Error: TError);
Begin
    Application.MessageBox(ERRORMESSAGES[Error], '������', MB_ICONERROR);
End;

Procedure TMainForm.ButtonCandidateListClick(Sender: TObject);
Begin
    CandidateListForm.ShowModal;
End;

Procedure TMainForm.ButtonFirmListClick(Sender: TObject);
Begin
    VacancyListForm.ShowModal;
End;

Function CheckFileExtension(Path: String): TError;
Var
    Error: TError;
Begin
    Error := Correct;
    If ExtractFileExt(Path) <> '.txt' Then
        Error := ErrIncorrectFileExt;
    CheckFileExtension := Error;
End;

Procedure ClearListView(ListView: TListView);
begin
    while ListView.Items.Count <> 0 do
       ListView.Items[0].Delete;
end;

End.
