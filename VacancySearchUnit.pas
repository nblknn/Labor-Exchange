Unit VacancySearchUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VacancyListUnit, Vcl.StdCtrls,
    Vcl.ExtCtrls, Vcl.DBCtrls;

Type
    TVacancySearchForm = Class(TForm)
        EditValue: TEdit;
        ButtonSearch: TButton;
        ButtonCancel: TButton;
        ButtonNext: TButton;
        ComboBoxParam: TComboBox;
        LabelSearch: TLabel;
        LabelInfo: TLabel;
        Procedure ComboBoxParamSelect(Sender: TObject);
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure EditValueChange(Sender: TObject);
        Procedure ButtonSearchClick(Sender: TObject);
        Procedure ButtonNextClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure EditValueKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    VacancySearchForm: TVacancySearchForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Type
    TSearchParameter = (SpFirmName, SpSpeciality, SpTitle);
    TSearchFunc = Function(Param: ShortString; Vacancy: PVacancy): Boolean;

Function AreFirmNamesEqual(Name: ShortString; Vacancy: PVacancy): Boolean;
Begin
    AreFirmNamesEqual := AnsiUpperCase(String(Vacancy.Info.FirmName))
      = AnsiUpperCase(String(Name));
End;

Function AreSpecialitiesEqual(Spec: ShortString; Vacancy: PVacancy): Boolean;
Begin
    AreSpecialitiesEqual := AnsiUpperCase(String(Vacancy.Info.Speciality))
      = AnsiUpperCase(String(Spec));
End;

Function AreTitlesEqual(Title: ShortString; Vacancy: PVacancy): Boolean;
Begin
    AreTitlesEqual := AnsiUpperCase(String(Vacancy.Info.Title))
      = AnsiUpperCase(String(Title));
End;

Const
    AreParamsEqual: Array [TSearchParameter] Of TSearchFunc =
      (AreFirmNamesEqual, AreSpecialitiesEqual, AreTitlesEqual);

Var
    SearchParam: TSearchParameter;
    FoundIndexes: Array Of Integer;
    Count: Integer;

Procedure AddToArray(I: Integer);
Begin
    SetLength(FoundIndexes, Length(FoundIndexes) + 1);
    FoundIndexes[High(FoundIndexes)] := I;
End;

Procedure Search(Param: ShortString);
Var
    Temp: PVacancy;
    I: Integer;
Begin
    I := 0;
    Temp := VacancyHead;
    While Temp <> Nil Do
    Begin
        If AreParamsEqual[SearchParam](Param, Temp) Then
            AddToArray(I);
        Inc(I);
        Temp := Temp.Next;
    End;
End;

Procedure TVacancySearchForm.ButtonSearchClick(Sender: TObject);
Begin
    FoundIndexes := Nil;
    Search(ShortString(EditValue.Text));
    Count := Length(FoundIndexes);
    If Count = 0 Then
        LabelInfo.Caption := 'Вакансии не были найдены.'
    Else
    Begin
        LabelInfo.Caption := 'Было найдено ' + IntToStr(Count) + ' вакансий.';
        ButtonNext.Enabled := True;
    End;
    LabelInfo.Visible := True;
End;

Procedure TVacancySearchForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TVacancySearchForm.ButtonNextClick(Sender: TObject);
Begin
    SelectItemInListView(FoundIndexes[Length(FoundIndexes) - Count],
      VacancyListForm.ListView);
    If Count > 1 Then
        Dec(Count)
    Else
        Count := Length(FoundIndexes);
End;

Procedure TVacancySearchForm.ComboBoxParamSelect(Sender: TObject);
Begin
    LabelInfo.Visible := False;
    ButtonNext.Enabled := False;
    SearchParam := TSearchParameter(ComboBoxParam.ItemIndex);
    EditValue.Enabled := True;
End;

Procedure TVacancySearchForm.EditValueChange(Sender: TObject);
Begin
    ButtonSearch.Enabled := Not(Length(EditValue.Text) > MAXLEN) And
      (EditValue.Text <> '');
End;

Procedure TVacancySearchForm.EditValueKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not(Length(EditValue.Text) < MAXLEN) And (Key <> BACKSPACE) Then
        Key := NULL;
End;

Procedure TVacancySearchForm.FormClose(Sender: TObject;
  Var Action: TCloseAction);
Begin
    EditValue.Text := '';
    EditValue.Enabled := False;
    ComboBoxParam.ClearSelection;
    ComboBoxParam.SetFocus;
    LabelInfo.Visible := False;
    FoundIndexes := Nil;
End;

Procedure TVacancySearchForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = 13) And ButtonSearch.Enabled Then
        ButtonSearch.Click
    Else If (Key In [VK_RIGHT, VK_DOWN]) And ButtonNext.Enabled Then
        ButtonNext.Click
End;

End.
