Unit CandidateUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask, CandidateListUnit;

Type
    TCandidateForm = Class(TForm)
        LabelHighEducation: TLabel;
        LabelBirthdate: TLabel;
        ButtonSave: TButton;
        ButtonCancel: TButton;
        CheckBoxHighEducation: TCheckBox;
        DateTimePicker: TDateTimePicker;
        LEditSurname: TLabeledEdit;
        LEditName: TLabeledEdit;
        LEditPatronymic: TLabeledEdit;
        LEditSpeciality: TLabeledEdit;
        LEditTitle: TLabeledEdit;
        LEditSalary: TLabeledEdit;
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure EditOnChange(Sender: TObject);
        Procedure ButtonSaveClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure FormCreate(Sender: TObject);
        Procedure LEditSurnameKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditNameKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditPatronymicKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditSpecialityKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditTitleKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditSalaryKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure ClearControls();
        Procedure ControlOnKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    CandidateForm: TCandidateForm;
    IsEditing: Boolean;
    OldInfo: TCandidateInfo;

Implementation

{$R *.dfm}

Uses MainUnit;

Procedure TCandidateForm.ButtonSaveClick(Sender: TObject);
Var
    NewInfo: TCandidateInfo;
Begin
    With NewInfo Do
    Begin
        Surname := ShortString(LEditSurname.Text);
        Name := ShortString(LEditName.Text);
        Patronymic := ShortString(LEditPatronymic.Text);
        Speciality := ShortString(LEditSpeciality.Text);
        BirthDate := DateTimePicker.Date;
        HasHighEducation := CheckBoxHighEducation.Checked;
        Title := ShortString(LEditTitle.Text);
        Salary := StrToInt(LEditSalary.Text);
    End;
    If IsEditing Then
        EditCandidate(OldInfo, NewInfo)
    Else
    Begin
        If Not IsCandidateInList(NewInfo) Then
        Begin
            AddCandidate(NewInfo, CandidateHead);
            AddCandidateToListView(NewInfo, CandidateListForm.ListView);
            Inc(CandidateAmount);
        End
        Else
            Application.MessageBox('Такой кандидат уже есть в списке!',
              'Ошибка', MB_ICONERROR);
    End;
    IsCandidateListSaved := False;
    Close;
End;

Procedure TCandidateForm.EditOnChange(Sender: TObject);
Begin
    ButtonSave.Enabled := IsStrEditCorrect(LEditSurname) And
      IsStrEditCorrect(LEditName) And IsStrEditCorrect(LEditPatronymic) And
      IsStrEditCorrect(LEditSpeciality) And IsStrEditCorrect(LEditTitle) And
      IsIntEditCorrect(LEditSalary, MINSALARY, MAXSALARY);
End;

Procedure TCandidateForm.ControlOnKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_UP Then
        SelectNext(TWinControl(Sender), False, True)
    Else If Key = VK_DOWN Then
        SelectNext(TWinControl(Sender), True, True)
End;

Procedure TCandidateForm.ClearControls();
Begin
    LEditSurname.Text := '';
    LEditName.Text := '';
    LEditPatronymic.Text := '';
    DateTimePicker.DateTime := DateTimePicker.MaxDate;
    LEditSpeciality.Text := '';
    CheckBoxHighEducation.Checked := False;
    LEditTitle.Text := '';
    LEditSalary.Text := '';
End;

Procedure TCandidateForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    IsEditing := False;
    ClearControls();
    LEditSurname.SetFocus;
End;

Procedure TCandidateForm.FormCreate(Sender: TObject);
Var
    Year, Month, Day: Word;
Begin
    DecodeDate(Now, Year, Month, Day);
    DateTimePicker.MaxDate := EncodeDate(Year - MINWORKAGE, Month, Day);
    DateTimePicker.MinDate := EncodeDate(Year - MAXWORKAGE - 1, Month, Day + 1);
End;

Procedure TCandidateForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = 13) And ButtonSave.Enabled Then
        ButtonSave.Click;
End;

Procedure TCandidateForm.FormShow(Sender: TObject);
Begin
    If IsEditing Then
        With OldInfo Do
        Begin
            LEditSurname.Text := String(Surname);
            LEditName.Text := String(Name);
            LEditPatronymic.Text := String(Patronymic);
            DateTimePicker.DateTime := BirthDate;
            LEditSpeciality.Text := String(Speciality);
            CheckBoxHighEducation.Checked := HasHighEducation;
            LEditTitle.Text := String(Title);
            LEditSalary.Text := IntToStr(Salary);
        End;
End;

Procedure TCandidateForm.LEditNameKeyPress(Sender: TObject; Var Key: Char);
Begin
    StrEditKeyPress(LEditName, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditPatronymicKeyPress(Sender: TObject;
  Var Key: Char);
Begin
    StrEditKeyPress(LEditPatronymic, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditSalaryKeyPress(Sender: TObject; Var Key: Char);
Begin
    IntEditKeyPress(LEditSalary, Key, MAXSALARY);
End;

Procedure TCandidateForm.LEditSpecialityKeyPress(Sender: TObject;
  Var Key: Char);
Begin
    StrEditKeyPress(LEditSpeciality, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditSurnameKeyPress(Sender: TObject; Var Key: Char);
Begin
    StrEditKeyPress(LEditSurname, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditTitleKeyPress(Sender: TObject; Var Key: Char);
Begin
    StrEditKeyPress(LEditTitle, Key, MAXLEN);
End;

Procedure TCandidateForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

End.
