Unit VacancySearchUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VacancyListUnit, Vcl.StdCtrls,
    Vcl.ExtCtrls, Vcl.DBCtrls;

Type
    TVacancySearchForm = Class(TForm)
        Edit1: TEdit;
        Button1: TButton;
        Button2: TButton;
        Button3: TButton;
        ComboBox1: TComboBox;
        Label1: TLabel;
        Label2: TLabel;
        Procedure ComboBox1Select(Sender: TObject);
        Procedure Button2Click(Sender: TObject);
        Procedure Edit1Change(Sender: TObject);
        Procedure Button1Click(Sender: TObject);
        Procedure Button3Click(Sender: TObject);
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
    AreFirmNamesEqual := AnsiUpperCase(Vacancy.FirmName) = AnsiUpperCase(Name);
End;

Function AreSpecialitiesEqual(Spec: ShortString; Vacancy: PVacancy): Boolean;
Begin
    AreSpecialitiesEqual := AnsiUpperCase(Vacancy.Speciality)
      = AnsiUpperCase(Spec);
End;

Function AreTitlesEqual(Title: ShortString; Vacancy: PVacancy): Boolean;
Begin
    AreTitlesEqual := AnsiUpperCase(Vacancy.Title) = AnsiUpperCase(Title);
End;

Const
    AreParamsEqual: Array [TSearchParameter] Of TSearchFunc =
      (AreFirmNamesEqual, AreSpecialitiesEqual, AreTitlesEqual);

Var
    SearchParam: TSearchParameter;
    FoundIndexes: Array Of Integer;
    Count: Integer;

Procedure AddToArray(Vacancy: PVacancy; I: Integer);
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
            AddToArray(Temp, I);
        Inc(I);
        Temp := Temp.Next;
    End;
End;

Procedure TVacancySearchForm.Button1Click(Sender: TObject);
Begin
    FoundIndexes := Nil;
    Search(Edit1.Text);
    Count := Length(FoundIndexes);
    If Count = 0 Then
        Label2.Caption := 'Вакансии не были найдены.'
    Else
    Begin
        Label2.Caption := 'Было найдено ' + IntToStr(Count) + ' вакансий.';
        Button3.Enabled := True;
    End;
    Label2.Visible := True;
End;

Procedure TVacancySearchForm.Button2Click(Sender: TObject);
Begin
    FoundIndexes := Nil;
    Close;
End;

Procedure SelectVacancyInListView(I: Integer);
Begin
    VacancyListForm.ListView.Selected := VacancyListForm.ListView.Items[I];
End;

Procedure TVacancySearchForm.Button3Click(Sender: TObject);
Begin
    SelectVacancyInListView(FoundIndexes[Length(FoundIndexes) - Count]);
    If Count > 1 Then
        Dec(Count)
    Else
        Count := Length(FoundIndexes);
End;

Procedure TVacancySearchForm.ComboBox1Select(Sender: TObject);
Begin
    SearchParam := TSearchParameter(ComboBox1.ItemIndex);
    Edit1.Enabled := True;
End;

Procedure TVacancySearchForm.Edit1Change(Sender: TObject);
Begin
    Button1.Enabled := Not(Length(Edit1.Text) > MAXLEN);
End;

End.
