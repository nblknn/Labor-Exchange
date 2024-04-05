Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
    Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls;

Type
    TError = (Correct, ErrIncorrectValue, ErrIncorrectFileExt, ErrCantOpenFile,
      ErrCantSaveFile);

    TMainForm = Class(TForm)
        MainMenu: TMainMenu;
        MMHelp: TMenuItem;
        LabelProgramName: TLabel;
        ButtonFirmList: TButton;
        ButtonCandidateList: TButton;
        ButtonExit: TButton;
        MMInstruction: TMenuItem;
        MMSeparator: TMenuItem;
        MMProgramInfo: TMenuItem;
        Procedure ButtonFirmListClick(Sender: TObject);
        Procedure ButtonCandidateListClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure ButtonExitClick(Sender: TObject);
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
Function CheckFileExtension(Path: String): TError;
Procedure ClearListView(ListView: TListView);
Procedure EditKeyPress(LEdit: TLabeledEdit; Var Key: Char;
  Const MAXLENGTH: Integer);
Function IsStrEditCorrect(LEdit: TLabeledEdit): Boolean;
Function IsIntEditCorrect(LEdit: TLabeledEdit;
  Const MINVALUE, MAXVALUE: Integer): Boolean;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses VacancyListUnit, CandidateListUnit;

Const
    NULL = #0;
    BACKSPACE = #8;

Procedure ShowErrorMessage(Error: TError);
Begin
    Application.MessageBox(ERRORMESSAGES[Error], 'Ошибка', MB_ICONERROR);
End;

Function IsStrEditCorrect(LEdit: TLabeledEdit): Boolean;
Begin
    IsStrEditCorrect := (Length(LEdit.Text) > 0) And
      (Length(LEdit.Text) < MAXLEN + 1);
End;

Function IsIntEditCorrect(LEdit: TLabeledEdit;
  Const MINVALUE, MAXVALUE: Integer): Boolean;
Var
    Value: Integer;
Begin
    IsIntEditCorrect := TryStrToInt(LEdit.Text, Value) And
      (Value > MINVALUE - 1) And (Value < MAXVALUE + 1);
End;

Procedure EditKeyPress(LEdit: TLabeledEdit; Var Key: Char;
  Const MAXLENGTH: Integer);
Begin
    If (Key <> BACKSPACE) And Not(Length(LEdit.Text) < MAXLENGTH) Then
        Key := NULL;
End;

Procedure ClearListView(ListView: TListView);
Begin
    While ListView.Items.Count <> 0 Do
        ListView.Items[0].Delete;
End;

Procedure TMainForm.ButtonCandidateListClick(Sender: TObject);
Begin
    CandidateListForm.ShowModal;
End;

Procedure TMainForm.ButtonExitClick(Sender: TObject);
Begin
    Close;
End;

Procedure TMainForm.ButtonFirmListClick(Sender: TObject);
Begin
    VacancyListForm.ShowModal;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    // fill
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

End.
