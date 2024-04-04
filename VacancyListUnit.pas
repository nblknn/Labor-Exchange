Unit VacancyListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
    MainUnit, Vcl.ExtCtrls, Vcl.DBCtrls;

Type
    PVacancy = ^TVacancy;

    TVacancy = Record
        FirmName, Speciality, Title: String[MAXLEN];
        Salary, VacationDays: Integer;
        IsHighEducationRequired: Boolean;
        MinAge, MaxAge: Integer;
        Next: PVacancy;
    End;

    TVacancyListForm = Class(TForm)
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMOpenFile: TMenuItem;
        MMSaveFile: TMenuItem;
        ListView: TListView;
        ButtonAdd: TButton;
        ButtonDelete: TButton;
        ButtonSearch: TButton;
        ButtonFindCandidates: TButton;
        MMInstruction: TMenuItem;
        SaveDialog: TSaveDialog;
        OpenDialog: TOpenDialog;
        Procedure ButtonAddClick(Sender: TObject);
        Procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
          Selected: Boolean);
        Procedure ListViewChange(Sender: TObject; Item: TListItem;
          Change: TItemChange);
        Procedure ButtonDeleteClick(Sender: TObject);
        Procedure ListViewDblClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure MMOpenFileClick(Sender: TObject);
        Procedure ButtonSearchClick(Sender: TObject);
    procedure ButtonFindCandidatesClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Procedure AddVacancyToListView(VacancyInfo: TVacancy; ListView: TListView);
Procedure AddVacancy(VacancyInfo: TVacancy; Var Head: PVacancy);
Procedure EditVacancy(OldInfo, NewInfo: TVacancy);

Var
    VacancyListForm: TVacancyListForm;
    VacancyHead: PVacancy = Nil;

Implementation

{$R *.dfm}

Uses VacancyUnit, VacancySearchUnit, FindCandidatesUnit;

Const
    HIGHEDUCATIONREQUIRED: Array [Boolean] Of String = ('Не требуется',
      'Требуется');

Var
    IsFileSaved: Boolean;

Procedure AddVacancyToListView(VacancyInfo: TVacancy; ListView: TListView);
Var
    NewItem: TListItem;
Begin
    NewItem := ListView.Items.Add;
    NewItem.Caption := VacancyInfo.FirmName;
    With NewItem.SubItems, VacancyInfo Do
    Begin
        Add(Speciality);
        Add(Title);
        Add(IntToStr(Salary));
        Add(IntToStr(VacationDays));
        Add(HIGHEDUCATIONREQUIRED[IsHighEducationRequired]);
        Add(IntToStr(MinAge) + '-' + IntToStr(MaxAge));
    End;
    IsFileSaved := False;
End;

Procedure AddVacancy(VacancyInfo: TVacancy; Var Head: PVacancy);
Var
    NewFirm, Temp: PVacancy;
Begin
    NewFirm := New(PVacancy);
    NewFirm^ := VacancyInfo;
    NewFirm^.Next := Nil;
    If Head = Nil Then
        Head := NewFirm
    Else
    Begin
        Temp := Head;
        While Temp.Next <> Nil Do
            Temp := Temp.Next;
        Temp.Next := NewFirm;
    End;
End;

Function AreVacanciesEqual(Vacancy1, Vacancy2: TVacancy): Boolean;
Begin
    AreVacanciesEqual := (Vacancy1.FirmName = Vacancy2.FirmName) And
      (Vacancy1.Speciality = Vacancy2.Speciality) And
      (Vacancy1.Title = Vacancy2.Title) And (Vacancy1.Salary = Vacancy2.Salary)
      And (Vacancy1.VacationDays = Vacancy2.VacationDays) And
      (Vacancy1.IsHighEducationRequired = Vacancy2.IsHighEducationRequired) And
      (Vacancy1.MinAge = Vacancy2.MinAge) And
      (Vacancy1.MaxAge = Vacancy2.MaxAge);
End;

Procedure EditVacancyInListView(NewInfo: TVacancy);
Begin
    With VacancyListForm.ListView.Selected, NewInfo Do
    Begin
        Caption := FirmName;
        SubItems[0] := Speciality;
        SubItems[1] := Title;
        SubItems[2] := IntToStr(Salary);
        SubItems[3] := IntToStr(VacationDays);
        SubItems[4] := HIGHEDUCATIONREQUIRED[IsHighEducationRequired];
        SubItems[5] := IntToStr(MinAge) + '-' + IntToStr(MaxAge);
    End;
    IsFileSaved := False;
End;

Procedure EditVacancy(OldInfo, NewInfo: TVacancy);
Var
    Temp: PVacancy;
Begin
    Temp := VacancyHead;
    While Not AreVacanciesEqual(OldInfo, Temp^) Do
        Temp := Temp.Next;
    Temp^ := NewInfo;
    EditVacancyInListView(NewInfo); // вызывать из вакансиюнит?
End;

Procedure TVacancyListForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = VK_DELETE) And ButtonDelete.Enabled Then
        ButtonDelete.Click;
End;

Procedure DeleteVacancy(VacancyInfo: TVacancy);
Var
    Temp1, Temp2: PVacancy;
Begin
    Temp1 := VacancyHead;
    If Not AreVacanciesEqual(VacancyInfo, Temp1^) Then
    Begin
        While Not AreVacanciesEqual(VacancyInfo, Temp1.Next^) Do
            Temp1 := Temp1.Next;
        Temp2 := Temp1;
        Temp2.Next := Temp1.Next.Next;
    End
    Else
        VacancyHead := Temp1.Next;
    Dispose(Temp1);
End;

Procedure DeleteVacancyList(Var Head: PVacancy);
Var
    Temp: PVacancy;
Begin
    Temp := Head;
    While Temp <> Nil Do
    Begin
        Head := Head.Next;
        Dispose(Temp);
        Temp := Head;
    End;
End;

Procedure TVacancyListForm.ButtonAddClick(Sender: TObject);
Begin
    VacancyForm.ShowModal;
End;

Function GetVacancyInfo(Item: TListItem): TVacancy;
Var
    Vacancy: TVacancy;
Begin
    With Vacancy, Item Do
    Begin
        FirmName := Caption;
        Speciality := SubItems[0];
        Title := SubItems[1];
        Salary := StrToInt(SubItems[2]);
        VacationDays := StrToInt(SubItems[3]);
        IsHighEducationRequired := SubItems[4] = HIGHEDUCATIONREQUIRED[True];
        MinAge := StrToInt(Copy(SubItems[5], 1, Pos('-', SubItems[5]) - 1));
        MaxAge := StrToInt(Copy(SubItems[5], Pos('-', SubItems[5]) + 1, 2));
    End;
    GetVacancyInfo := Vacancy;
End;

Procedure TVacancyListForm.ButtonDeleteClick(Sender: TObject);
Var
    ButtonSelected: Integer;
Begin
    ButtonSelected := Application.MessageBox
      ('Вы уверены, что хотите удалить выделенную вакансию?', 'Удаление',
      MB_YESNO + MB_ICONQUESTION);
    If ButtonSelected = MrYes Then
    Begin
        DeleteVacancy(GetVacancyInfo(ListView.Selected));
        ListView.Selected.Delete;
        IsFileSaved := False;
    End
    Else
        ListView.ClearSelection;
End;

procedure TVacancyListForm.ButtonFindCandidatesClick(Sender: TObject);
begin
    Vacancy := GetVacancyInfo(ListView.Selected);
    FindCandidatesForm.ShowModal;
end;

Procedure TVacancyListForm.ButtonSearchClick(Sender: TObject);
Begin
    VacancySearchForm.Show;
End;

Procedure TVacancyListForm.ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
Begin
    ButtonSearch.Enabled := ListView.Items.Count > 0;
    MMSaveFile.Enabled := ListView.Items.Count > 0;
End;

Procedure TVacancyListForm.ListViewDblClick(Sender: TObject);
Begin
    OldInfo := GetVacancyInfo(ListView.Selected);
    IsEditing := True;
    VacancyForm.ShowModal;
End;

Procedure TVacancyListForm.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
Begin
    ButtonDelete.Enabled := Selected;
    ButtonFindCandidates.Enabled := Selected;
End;

Procedure TVacancyListForm.MMOpenFileClick(Sender: TObject);
Var
    InputFile: File Of TVacancy;
    VacancyInfo: TVacancy;
    Head: PVacancy;
    Error: TError;
Begin
    If OpenDialog.Execute Then
    Begin
        Error := CheckFileExtension(OpenDialog.FileName);
        If Error = Correct Then
            Try
                Head := Nil;
                AssignFile(InputFile, OpenDialog.FileName);
                Try
                    Reset(InputFile);
                    While Not Eof(InputFile) Do
                    Begin
                        Read(InputFile, VacancyInfo);
                        AddVacancy(VacancyInfo, Head);
                    End;
                Except
                    Error := ErrCantOpenFile;
                End;
            Finally
                CloseFile(InputFile);
            End;
        If Error = Correct Then
        Begin
            DeleteVacancyList(VacancyHead);
            ClearListView(ListView);
            VacancyHead := Head;
            While Head <> Nil Do
            Begin
                AddVacancyToListView(Head^, ListView);
                Head := Head.Next;
            End;
            IsFileSaved := True;
        End
        Else
        Begin
            DeleteVacancyList(Head);
            ShowErrorMessage(Error);
        End;
    End;
End;

Procedure TVacancyListForm.MMSaveFileClick(Sender: TObject);
Var
    OutputFile: File Of TVacancy;
    Temp: PVacancy;
    Error: TError;
Begin
    If SaveDialog.Execute Then
    Begin
        Error := CheckFileExtension(SaveDialog.FileName);
        If Error = Correct Then
            Try
                Temp := VacancyHead;
                AssignFile(OutputFile, SaveDialog.FileName);
                Try
                    Rewrite(OutputFile);
                    While Temp <> Nil Do
                    Begin
                        Write(OutputFile, Temp^);
                        Temp := Temp.Next;
                    End;
                Except
                    Error := ErrCantOpenFile;
                End;
            Finally
                CloseFile(OutputFile);
            End;
        If Error = Correct Then
            IsFileSaved := True
        Else
            ShowErrorMessage(Error);
    End;
End;

End.
