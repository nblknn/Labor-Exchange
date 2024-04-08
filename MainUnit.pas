Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Forms,
    Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
    Vcl.Controls;

Type
    TMainForm = Class(TForm)
        MainMenu: TMainMenu;
        MMHelp: TMenuItem;
        LabelProgramName: TLabel;
        ButtonVacancyList: TButton;
        ButtonCandidateList: TButton;
        ButtonExit: TButton;
        MMInstruction: TMenuItem;
        MMSeparator: TMenuItem;
        MMProgramInfo: TMenuItem;
        Procedure ButtonVacancyListClick(Sender: TObject);
        Procedure ButtonCandidateListClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure ButtonExitClick(Sender: TObject);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMProgramInfoClick(Sender: TObject);
        Procedure FormResize(Sender: TObject);
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
    CANDIDATEFILEEXT = '.can';
    VACANCYFILEEXT = '.vac';
    NULL = #0;
    BACKSPACE = #8;

Function IsFileExtCorrect(Path: String; Const EXT: String): Boolean;
Procedure SelectItemInListView(I: Integer; ListView: TListView);
Procedure ClearListView(ListView: TListView);
Procedure StrEditKeyPress(LEdit: TLabeledEdit; Var Key: Char;
  Const MAXLENGTH: Integer);
Procedure IntEditKeyPress(LEdit: TLabeledEdit; Var Key: Char;
  Const MAX: Integer);
Function IsStrEditCorrect(LEdit: TLabeledEdit): Boolean;
Function IsIntEditCorrect(LEdit: TLabeledEdit;
  Const MINVALUE, MAXVALUE: Integer): Boolean;
Procedure ShowInstruction();
Procedure ShowProgramInfo();

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Uses VacancyListUnit, CandidateListUnit;

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

Procedure StrEditKeyPress(LEdit: TLabeledEdit; Var Key: Char;
  Const MAXLENGTH: Integer);
Begin
    If (Key <> BACKSPACE) And Not(Length(LEdit.Text) < MAXLENGTH) Then
        Key := NULL;
End;

Procedure IntEditKeyPress(LEdit: TLabeledEdit; Var Key: Char;
  Const MAX: Integer);
Begin
    If (Key <> BACKSPACE) And
      Not(Length(LEdit.Text) < Length(IntToStr(MAX))) Then
        Key := NULL
    Else If (LEdit.SelStart = 0) And (Key = '0') Then
        Key := NULL
    Else If (Length(LEdit.Text) > 0) And (StrToInt(LEdit.Text) = 0) And
      (LEdit.SelStart <> 0) And (Key <> BACKSPACE) Then
        Key := NULL;
End;

Procedure SelectItemInListView(I: Integer; ListView: TListView);
Begin
    ListView.Selected := ListView.Items[I];
    ListView.Items[I].MakeVisible(False);
End;

Procedure ClearListView(ListView: TListView);
Begin
    While ListView.Items.Count <> 0 Do
        ListView.Items[0].Delete;
End;

Procedure TMainForm.ButtonCandidateListClick(Sender: TObject);
Begin
    MainForm.Visible := False;
    CandidateListForm.ShowModal;
End;

Procedure TMainForm.ButtonExitClick(Sender: TObject);
Begin
    Close;
End;

Procedure TMainForm.ButtonVacancyListClick(Sender: TObject);
Begin
    MainForm.Visible := False;
    VacancyListForm.ShowModal;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If Not IsVacancyListSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы хотите сохранить изменения в списке вакансий?', 'Выход',
          MB_YESNOCANCEL + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
        Begin
            VacancyListForm.MMSaveFile.Click;
            If Not IsVacancyListSaved Then
                Close;
        End
        Else
            CanClose := IsCandidateListSaved And (ButtonSelected = MrNo);
        IsVacancyListSaved := True; // костыли
    End;
    If Not IsCandidateListSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы хотите сохранить изменения в списке кандидатов?', 'Выход',
          MB_YESNOCANCEL + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
        Begin
            CandidateListForm.MMSaveFile.Click;
            If Not IsCandidateListSaved Then
                Close;
        End
        Else
            CanClose := ButtonSelected = MrNo;
        IsCandidateListSaved := True;
    End;
End;

Procedure TMainForm.FormResize(Sender: TObject);
Begin
    Left := (Screen.Width - Width) Div 2;
    Top := (Screen.Height - Height) Div 2;
End;

Procedure ShowInstruction();
Begin
    Application.MessageBox
      ('1. Для добавления записи в список нажмите на кнопку "Добавить", и введите требующуюся информацию.'#13#10
      + '2. Для редактирования записи нажмите дважды на нужную строку списка.'#13#10
      + '3. Для удаления записи выберите ее в списке и нажмите на кнопку "Удалить".'#13#10
      + '4. Для подбора кандидатов для вакансии выберите нужную вакансию в списке и нажмите на кнопку "Подобрать кандидатов".'#13#10
      + '5. Формат для файлов с вакансиями: *.vac.'#13#10 +
      '6. Формат для файлов с кандидатами: *.can.', 'Инструкция', MB_OK);
End;

Procedure ShowProgramInfo();
Begin
    Application.MessageBox('Биржа труда'#13#10 +
      'Разработчик: Городко Ксения Евгеньевна, 351005'#13#10 +
      'Учебная практика (ознакомительная), вариант 15'#13#10 + 'БГУИР 2024',
      'О программе', MB_OK);
End;

Procedure TMainForm.MMInstructionClick(Sender: TObject);
Begin
    ShowInstruction();
End;

Procedure TMainForm.MMProgramInfoClick(Sender: TObject);
Begin
    ShowProgramInfo();
End;

Function IsFileExtCorrect(Path: String; Const EXT: String): Boolean;
Begin
    If ExtractFileExt(Path) <> EXT Then
        Application.MessageBox(PWideChar('Файл должен иметь разрешение ' + EXT +
          '!'), 'Ошибка', MB_ICONERROR);
    IsFileExtCorrect := ExtractFileExt(Path) = EXT;
End;

End.
