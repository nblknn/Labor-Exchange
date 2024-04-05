Unit CandidateUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask;

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
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    CandidateForm: TCandidateForm;
    IsEditing: Boolean;

Implementation

{$R *.dfm}

Uses CandidateListUnit, MainUnit;

Procedure TCandidateForm.ButtonSaveClick(Sender: TObject);
Var
    CandidateInfo: TCandidate;
Begin
    With CandidateInfo Do
    Begin
        Surname := LEditSurname.Text;
        Name := LEditName.Text;
        Patronymic := LEditPatronymic.Text;
        Speciality := LEditSpeciality.Text;
        BirthDate := DateTimePicker.DateTime;
        HasHighEducation := CheckBoxHighEducation.Checked;
        Title := LEditTitle.Text;
        Salary := StrToInt(LEditSalary.Text);
    End;
    // If IsEditing Then
    // CandidateListForm.EditVacancy(OldInfo, CandidateInfo)
    // Else
    AddCandidate(CandidateInfo, CandidateHead);
    AddCandidateToListView(CandidateInfo, CandidateListForm.ListView);
    Close;
End;

Procedure TCandidateForm.EditOnChange(Sender: TObject);
Begin
    ButtonSave.Enabled := IsStrEditCorrect(LEditSurname) And
      IsStrEditCorrect(LEditName) And IsStrEditCorrect(LEditPatronymic) And
      IsStrEditCorrect(LEditSpeciality) And IsStrEditCorrect(LEditTitle) And
      IsIntEditCorrect(LEditSalary, MINSALARY, MAXSALARY);
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

Procedure TCandidateForm.LEditNameKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditName, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditPatronymicKeyPress(Sender: TObject;
  Var Key: Char);
Begin
    EditKeyPress(LEditPatronymic, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditSalaryKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditSalary, Key, Length(IntToStr(MAXSALARY)));
End;

Procedure TCandidateForm.LEditSpecialityKeyPress(Sender: TObject;
  Var Key: Char);
Begin
    EditKeyPress(LEditSpeciality, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditSurnameKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditSurname, Key, MAXLEN);
End;

Procedure TCandidateForm.LEditTitleKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditTitle, Key, MAXLEN);
End;

Procedure TCandidateForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

End.
