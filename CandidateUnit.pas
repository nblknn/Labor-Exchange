Unit CandidateUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
    Vcl.WinXPickers,
    Vcl.ComCtrls, VacancyUnit, MainUnit;

Type
    TCandidateForm = Class(TForm)
        LabelSurname: TLabel;
        LabelName: TLabel;
        LabelPatronymic: TLabel;
        LabelSpeciality: TLabel;
        LabelHighEducation: TLabel;
        LabelBirthdate: TLabel;
        LabelTitle: TLabel;
        LabelSalary: TLabel;
        EditSurname: TEdit;
        EditPatronymic: TEdit;
        EditName: TEdit;
        EditSpeciality: TEdit;
        EditTitle: TEdit;
        EditSalary: TEdit;
        ButtonSave: TButton;
        ButtonCancel: TButton;
        CheckBoxHighEducation: TCheckBox;
        MainMenu: TMainMenu;
        MMInstruction: TMenuItem;
        DateTimePicker: TDateTimePicker;
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure EditOnChange(Sender: TObject);
        Procedure ButtonSaveClick(Sender: TObject);
        Procedure EditSurnameKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditNameKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditPatronymicKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditSpecialityKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditTitleKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditSalaryKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure FormCreate(Sender: TObject);
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

Uses CandidateListUnit;

Procedure TCandidateForm.ButtonSaveClick(Sender: TObject);
Var
    CandidateInfo: TCandidate;
Begin
    With CandidateInfo Do
    Begin
        Surname := EditSurname.Text;
        Name := EditName.Text;
        Patronymic := EditPatronymic.Text;
        Speciality := EditSpeciality.Text;
        BirthDate := DateTimePicker.DateTime;
        HasHighEducation := CheckBoxHighEducation.Checked;
        Title := EditTitle.Text;
        Salary := StrToInt(EditSalary.Text);
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
    ButtonSave.Enabled := IsStrEditCorrect(EditSurname) And
      IsStrEditCorrect(EditName) And IsStrEditCorrect(EditPatronymic) And
      IsStrEditCorrect(EditSpeciality) And IsStrEditCorrect(EditTitle) And
      IsIntEditCorrect(EditSalary, MINSALARY, MAXSALARY);
End;

Procedure TCandidateForm.EditNameKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditName, Key, MAXLEN);
End;

Procedure TCandidateForm.EditPatronymicKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditPatronymic, Key, MAXLEN);
End;

Procedure TCandidateForm.EditSalaryKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditSalary, Key, Length(IntToStr(MAXSALARY)));
End;

Procedure TCandidateForm.EditSpecialityKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditSpeciality, Key, MAXLEN);
End;

Procedure TCandidateForm.EditSurnameKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditSurname, Key, MAXLEN);
End;

Procedure TCandidateForm.EditTitleKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditTitle, Key, MAXLEN);
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

Procedure TCandidateForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

End.
