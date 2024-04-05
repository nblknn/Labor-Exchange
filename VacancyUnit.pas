Unit VacancyUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
    Vcl.ExtCtrls, VacancyListUnit, Vcl.Mask;

Type
    TVacancyForm = Class(TForm)
        LabelHighEducation: TLabel;
        ButtonSave: TButton;
        ButtonCancel: TButton;
        CheckBoxHighEducation: TCheckBox;
        LEditFirmName: TLabeledEdit;
        LEditSpeciality: TLabeledEdit;
        LEditTitle: TLabeledEdit;
        LEditSalary: TLabeledEdit;
        LEditVacationDays: TLabeledEdit;
        LEditMinAge: TLabeledEdit;
        LEditMaxAge: TLabeledEdit;
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditOnChange(Sender: TObject);
        Procedure ClearEdits();
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure ButtonSaveClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure LEditFirmNameKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditSpecialityKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditTitleKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditSalaryKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditVacationDaysKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditMinAgeKeyPress(Sender: TObject; Var Key: Char);
        Procedure LEditMaxAgeKeyPress(Sender: TObject; Var Key: Char);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    VacancyForm: TVacancyForm;
    IsEditing: Boolean;
    OldInfo: TVacancy;

Implementation

{$R *.dfm}

Uses MainUnit;

Function IsAgeRangeCorrect(): Boolean;
Begin
    With VacancyForm Do
        IsAgeRangeCorrect := IsIntEditCorrect(LEditMinAge, MINWORKAGE,
          MAXWORKAGE) And IsIntEditCorrect(LEditMaxAge, MINWORKAGE, MAXWORKAGE)
          And Not(StrToInt(LEditMinAge.Text) > StrToInt(LEditMaxAge.Text));
End;

Procedure TVacancyForm.EditOnChange(Sender: TObject);
Begin
    ButtonSave.Enabled := IsStrEditCorrect(LEditFirmName) And
      IsStrEditCorrect(LEditSpeciality) And IsStrEditCorrect(LEditTitle) And
      IsIntEditCorrect(LEditSalary, MINSALARY, MAXSALARY) And
      IsIntEditCorrect(LEditVacationDays, MINVACATION, MAXVACATION) And
      IsAgeRangeCorrect();
End;

Procedure TVacancyForm.ButtonSaveClick(Sender: TObject);
Var
    NewInfo: TVacancy;
Begin
    With NewInfo Do
    Begin
        FirmName := LEditFirmName.Text;
        Speciality := LEditSpeciality.Text;
        Title := LEditTitle.Text;
        Salary := StrToInt(LEditSalary.Text);
        VacationDays := StrToInt(LEditVacationDays.Text);
        IsHighEducationRequired := CheckBoxHighEducation.Checked;
        MinAge := StrToInt(LEditMinAge.Text);
        MaxAge := StrToInt(LEditMaxAge.Text);
    End;
    If IsEditing Then
        EditVacancy(OldInfo, NewInfo)
    Else
    Begin
        AddVacancy(NewInfo, VacancyHead);
        AddVacancyToListView(NewInfo, VacancyListForm.ListView);
    End;
    Close;
End;

Procedure TVacancyForm.ClearEdits();
Begin
    LEditFirmName.Text := '';
    LEditSpeciality.Text := '';
    LEditTitle.Text := '';
    LEditSalary.Text := '';
    LEditVacationDays.Text := '';
    CheckBoxHighEducation.Checked := False;
    LEditMinAge.Text := '';
    LEditMaxAge.Text := '';
End;

Procedure TVacancyForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TVacancyForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    IsEditing := False;
    ClearEdits();
    LEditFirmName.SetFocus;
End;

Procedure TVacancyForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = 13) And ButtonSave.Enabled Then
        ButtonSave.Click;
End;

Procedure TVacancyForm.FormShow(Sender: TObject);
Begin
    If IsEditing Then
        With OldInfo Do
        Begin
            LEditFirmName.Text := FirmName;
            LEditSpeciality.Text := Speciality;
            LEditTitle.Text := Title;
            LEditSalary.Text := IntToStr(Salary);
            LEditVacationDays.Text := IntToStr(VacationDays);
            CheckBoxHighEducation.Checked := IsHighEducationRequired;
            LEditMinAge.Text := IntToStr(MinAge);
            LEditMaxAge.Text := IntToStr(MaxAge);
        End;
End;

Procedure TVacancyForm.LEditFirmNameKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditFirmName, Key, MAXLEN);
End;

Procedure TVacancyForm.LEditMaxAgeKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditMaxAge, Key, Length(IntToStr(MAXWORKAGE)));
End;

Procedure TVacancyForm.LEditMinAgeKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditMinAge, Key, Length(IntToStr(MAXWORKAGE)));
End;

Procedure TVacancyForm.LEditSalaryKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditSalary, Key, Length(IntToStr(MAXSALARY)));
End;

Procedure TVacancyForm.LEditSpecialityKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditSpeciality, Key, MAXLEN);
End;

Procedure TVacancyForm.LEditTitleKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(LEditTitle, Key, MAXLEN);
End;

Procedure TVacancyForm.LEditVacationDaysKeyPress(Sender: TObject;
  Var Key: Char);
Begin
    EditKeyPress(LEditVacationDays, Key, Length(IntToStr(MAXVACATION)));
End;

End.
