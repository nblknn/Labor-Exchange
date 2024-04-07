Unit CandidateSearchUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TCandidateSearchForm = Class(TForm)
        LabelSearch: TLabel;
        LabelInfo: TLabel;
        EditValue: TEdit;
        ButtonSearch: TButton;
        ButtonCancel: TButton;
        ButtonNext: TButton;
        ComboBoxParam: TComboBox;
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
    CandidateSearchForm: TCandidateSearchForm;

Implementation

{$R *.dfm}

Uses MainUnit, CandidateListUnit;

Type
    TSearchParameter = (SpSurname, SpSpeciality, SpTitle);
    TSearchFunc = Function(Param: ShortString; Candidate: PCandidate): Boolean;

Function AreSurnamesEqual(Surname: ShortString; Candidate: PCandidate): Boolean;
Begin
    AreSurnamesEqual := AnsiUpperCase(Candidate.Info.Surname)
      = AnsiUpperCase(Surname);
End;

Function AreSpecialitiesEqual(Spec: ShortString; Candidate: PCandidate)
  : Boolean;
Begin
    AreSpecialitiesEqual := AnsiUpperCase(Candidate.Info.Speciality)
      = AnsiUpperCase(Spec);
End;

Function AreTitlesEqual(Title: ShortString; Candidate: PCandidate): Boolean;
Begin
    AreTitlesEqual := AnsiUpperCase(Candidate.Info.Title)
      = AnsiUpperCase(Title);
End;

Const
    AreParamsEqual: Array [TSearchParameter] Of TSearchFunc = (AreSurnamesEqual,
      AreSpecialitiesEqual, AreTitlesEqual);

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
    Temp: PCandidate;
    I: Integer;
Begin
    I := 0;
    Temp := CandidateHead;
    While Temp <> Nil Do
    Begin
        If AreParamsEqual[SearchParam](Param, Temp) Then
            AddToArray(I);
        Inc(I);
        Temp := Temp.Next;
    End;
End;

Procedure TCandidateSearchForm.ButtonSearchClick(Sender: TObject);
Begin
    FoundIndexes := Nil;
    Search(EditValue.Text);
    Count := Length(FoundIndexes);
    If Count = 0 Then
        LabelInfo.Caption := 'Кандидаты не были найдены.'
    Else
    Begin
        LabelInfo.Caption := 'Было найдено ' + IntToStr(Count) + ' кандидатов.';
        ButtonNext.Enabled := True;
    End;
    LabelInfo.Visible := True;
End;

Procedure TCandidateSearchForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TCandidateSearchForm.ButtonNextClick(Sender: TObject);
Begin
    SelectItemInListView(FoundIndexes[Length(FoundIndexes) - Count],
      CandidateListForm.ListView);
    If Count > 1 Then
        Dec(Count)
    Else
        Count := Length(FoundIndexes);
End;

Procedure TCandidateSearchForm.ComboBoxParamSelect(Sender: TObject);
Begin
    LabelInfo.Visible := False;
    ButtonNext.Enabled := False;
    SearchParam := TSearchParameter(ComboBoxParam.ItemIndex);
    EditValue.Enabled := True;
End;

Procedure TCandidateSearchForm.EditValueChange(Sender: TObject);
Begin
    ButtonSearch.Enabled := Not(Length(EditValue.Text) > MAXLEN) And
      (EditValue.Text <> '');
End;

Procedure TCandidateSearchForm.EditValueKeyPress(Sender: TObject;
  Var Key: Char);
Begin
    If Not(Length(EditValue.Text) < MAXLEN) And (Key <> BACKSPACE) Then
        Key := NULL;
End;

Procedure TCandidateSearchForm.FormClose(Sender: TObject;
  Var Action: TCloseAction);
Begin
    EditValue.Text := '';
    EditValue.Enabled := False;
    ComboBoxParam.ClearSelection;
    ComboBoxParam.SetFocus;
    LabelInfo.Visible := False;
    FoundIndexes := Nil;
End;

Procedure TCandidateSearchForm.FormKeyDown(Sender: TObject; Var Key: Word;
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
