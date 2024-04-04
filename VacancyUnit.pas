Unit VacancyUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls,
    Vcl.CheckLst, VacancyListUnit;

Type
    TVacancyForm = Class(TForm)
        MainMenu: TMainMenu;
        MMInstruction: TMenuItem;
        LabelName: TLabel;
        LabelSpeciality: TLabel;
        LabelTitle: TLabel;
        LabelVacationDays: TLabel;
        LabelHighEducation: TLabel;
        LabelSalary: TLabel;
        LabelMinAge: TLabel;
        LabelMaxAge: TLabel;
        EditName: TEdit;
        EditSalary: TEdit;
        EditTitle: TEdit;
        EditSpeciality: TEdit;
        EditVacationDays: TEdit;
        EditMinAge: TEdit;
        EditMaxAge: TEdit;
        ButtonSave: TButton;
        ButtonCancel: TButton;
        CheckBoxHighEducation: TCheckBox;
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditOnChange(Sender: TObject);
        Procedure ClearEdits();
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure ButtonSaveClick(Sender: TObject);
        Procedure EditNameKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditSpecialityKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditTitleKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditSalaryKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditVacationDaysKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditMinAgeKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditMaxAgeKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormShow(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Function IsStrEditCorrect(Edit: TEdit): Boolean;
Function IsIntEditCorrect(Edit: TEdit;
  Const MINVALUE, MAXVALUE: Integer): Boolean;
Procedure EditKeyPress(Edit: TEdit; Var Key: Char; Const MAXLENGTH: Integer);

Var
    VacancyForm: TVacancyForm;
    IsEditing: Boolean;
    OldInfo: TVacancy;

Implementation

{$R *.dfm}

Uses MainUnit;

Const
    NULL = #0;
    BACKSPACE = #8;

Function IsStrEditCorrect(Edit: TEdit): Boolean;
Begin
    IsStrEditCorrect := (Length(Edit.Text) > 0) And
      (Length(Edit.Text) < MAXLEN + 1);
End;

Function IsIntEditCorrect(Edit: TEdit;
  Const MINVALUE, MAXVALUE: Integer): Boolean;
Var
    Value: Integer;
Begin
    IsIntEditCorrect := TryStrToInt(Edit.Text, Value) And (Value > MINVALUE - 1)
      And (Value < MAXVALUE + 1);
End;

Function IsAgeRangeCorrect(): Boolean;
Begin
    With VacancyForm Do
        IsAgeRangeCorrect := IsIntEditCorrect(EditMinAge, MINWORKAGE,
          MAXWORKAGE) And IsIntEditCorrect(EditMaxAge, MINWORKAGE, MAXWORKAGE)
          And Not(StrToInt(EditMinAge.Text) > StrToInt(EditMaxAge.Text));
End;

Procedure TVacancyForm.EditOnChange(Sender: TObject);
Begin
    ButtonSave.Enabled := IsStrEditCorrect(EditName) And
      IsStrEditCorrect(EditSpeciality) And IsStrEditCorrect(EditTitle) And
      IsIntEditCorrect(EditSalary, MINSALARY, MAXSALARY) And
      IsIntEditCorrect(EditVacationDays, MINVACATION, MAXVACATION) And
      IsAgeRangeCorrect();
End;

Procedure EditKeyPress(Edit: TEdit; Var Key: Char; Const MAXLENGTH: Integer);
Begin
    If (Key <> BACKSPACE) And Not(Length(Edit.Text) < MAXLENGTH) Then
        Key := NULL;
End;

Procedure TVacancyForm.EditMaxAgeKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditMaxAge, Key, Length(IntToStr(MAXWORKAGE)));
End;

Procedure TVacancyForm.EditMinAgeKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditMinAge, Key, Length(IntToStr(MAXWORKAGE)));
End;

Procedure TVacancyForm.EditNameKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditName, Key, MAXLEN);
End;

Procedure TVacancyForm.EditSalaryKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditSalary, Key, Length(IntToStr(MAXSALARY)));
End;

Procedure TVacancyForm.EditSpecialityKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditSpeciality, Key, MAXLEN);
End;

Procedure TVacancyForm.EditTitleKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditTitle, Key, MAXLEN);
End;

Procedure TVacancyForm.EditVacationDaysKeyPress(Sender: TObject; Var Key: Char);
Begin
    EditKeyPress(EditVacationDays, Key, Length(IntToStr(MAXVACATION)));
End;

Procedure TVacancyForm.ButtonSaveClick(Sender: TObject);
Var
    NewInfo: TVacancy;
Begin
    With NewInfo Do
    Begin
        FirmName := EditName.Text;
        Speciality := EditSpeciality.Text;
        Title := EditTitle.Text;
        Salary := StrToInt(EditSalary.Text);
        VacationDays := StrToInt(EditVacationDays.Text);
        IsHighEducationRequired := CheckBoxHighEducation.Checked;
        MinAge := StrToInt(EditMinAge.Text);
        MaxAge := StrToInt(EditMaxAge.Text);
    End;
    If IsEditing Then
    Begin
        NewInfo.Next := OldInfo.Next;
        EditVacancy(OldInfo, NewInfo);
    End
    Else
    Begin
        AddVacancy(NewInfo, VacancyHead);
        AddVacancyToListView(NewInfo, VacancyListForm.ListView);
    End;
    Close;
End;

Procedure TVacancyForm.ClearEdits();
Begin
    EditName.Text := '';
    EditSpeciality.Text := '';
    EditTitle.Text := '';
    EditSalary.Text := '';
    EditVacationDays.Text := '';
    CheckBoxHighEducation.Checked := False;
    EditMinAge.Text := '';
    EditMaxAge.Text := '';
End;

Procedure TVacancyForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TVacancyForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    IsEditing := False;
    ClearEdits();
    EditName.SetFocus;
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
            EditName.Text := Name;
            EditSpeciality.Text := Speciality;
            EditTitle.Text := Title;
            EditSalary.Text := IntToStr(Salary);
            EditVacationDays.Text := IntToStr(VacationDays);
            CheckBoxHighEducation.Checked := IsHighEducationRequired;
            EditMinAge.Text := IntToStr(MinAge);
            EditMaxAge.Text := IntToStr(MaxAge);
        End;
End;

End.
