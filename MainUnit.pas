Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

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
      'Проверьте корректность данных!', 'Файл должен иметь разрешение *.txt!',
      'Произошла ошибка при открытии файла!',
      'Произошла ошибка при записи в файл!');

Procedure ShowErrorMessage(Error: TError);

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses FirmListUnit, CandidateListUnit;

Procedure ShowErrorMessage(Error: TError);
Begin
    Application.MessageBox(ERRORMESSAGES[Error], 'Ошибка', MB_ICONERROR);
End;

Procedure TMainForm.ButtonCandidateListClick(Sender: TObject);
Begin
    CandidateListForm.ShowModal;
End;

Procedure TMainForm.ButtonFirmListClick(Sender: TObject);
Begin
    FirmListForm.ShowModal;
End;

End.
