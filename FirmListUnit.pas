Unit FirmListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
    MainUnit;

Type
    PFirm = ^TFirm;

    TFirm = Record
        Name, Speciality, Title: String[MAXLEN];
        Salary, VacationDays: Integer;
        IsHighEducationRequired: Boolean;
        MinAge, MaxAge: Integer;
        Next: PFirm;
    End;

    TFirmListForm = Class(TForm)
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
        Procedure ButtonAddClick(Sender: TObject);
        Procedure AddVacancyToListView(FirmInfo: TFirm);
        Procedure AddVacancy(FirmInfo: TFirm);
        Procedure DeleteVacancy(FirmInfo: TFirm);
        Procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
          Selected: Boolean);
        Procedure ListViewChange(Sender: TObject; Item: TListItem;
          Change: TItemChange);
        Procedure ButtonDeleteClick(Sender: TObject);
        Procedure ListViewDblClick(Sender: TObject);
        Procedure EditVacancy(OldInfo, NewInfo: TFirm);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FirmListForm: TFirmListForm;
    FirmHead: PFirm = Nil;

Implementation

{$R *.dfm}

Uses VacancyUnit;

Const
    HIGHEDUCATIONREQUIRED: Array [Boolean] Of String = ('Не требуется',
      'Требуется');

Procedure TFirmListForm.AddVacancy(FirmInfo: TFirm);
Var
    NewFirm, Temp: PFirm;
Begin
    NewFirm := New(PFirm);
    NewFirm^ := FirmInfo;
    NewFirm^.Next := Nil;
    If FirmHead = Nil Then
        FirmHead := NewFirm
    Else
    Begin
        Temp := FirmHead;
        While Temp.Next <> Nil Do
            Temp := Temp.Next;
        Temp.Next := FirmHead;
    End;
    AddVacancyToListView(FirmInfo);
End;

Function AreVacanciesEqual(Firm1, Firm2: TFirm): Boolean;
Begin
    AreVacanciesEqual := (Firm1.Name = Firm2.Name) And
      (Firm1.Speciality = Firm2.Speciality) And (Firm1.Title = Firm2.Title) And
      (Firm1.Salary = Firm2.Salary) And
      (Firm1.VacationDays = Firm2.VacationDays) And
      (Firm1.IsHighEducationRequired = Firm2.IsHighEducationRequired) And
      (Firm1.MinAge = Firm2.MinAge) And (Firm1.MaxAge = Firm2.MaxAge);
End;

Procedure TFirmListForm.EditVacancy(OldInfo, NewInfo: TFirm);
Var
    Temp: PFirm;
Begin
    Temp := FirmHead;
    While Not AreVacanciesEqual(OldInfo, Temp^) Do
        Temp := Temp.Next;
    Temp^ := NewInfo;
End;

Procedure TFirmListForm.DeleteVacancy(FirmInfo: TFirm);
Var
    Temp1, Temp2: PFirm;
Begin
    Temp1 := FirmHead;
    If Not AreVacanciesEqual(FirmInfo, Temp1^) Then
    Begin
        While Not AreVacanciesEqual(FirmInfo, Temp1.Next^) Do
            Temp1 := Temp1.Next;
        Temp2 := Temp1;
        Temp2.Next := Temp1.Next.Next;
    End
    Else
        FirmHead := Temp1.Next;
    Dispose(Temp1);
End;

Procedure TFirmListForm.AddVacancyToListView(FirmInfo: TFirm);
Var
    NewItem: TListItem;
Begin
    NewItem := ListView.Items.Add;
    NewItem.Caption := FirmInfo.Name;
    With NewItem.SubItems, FirmInfo Do
    Begin
        Add(Speciality);
        Add(Title);
        Add(IntToStr(Salary));
        Add(IntToStr(VacationDays));
        Add(HIGHEDUCATIONREQUIRED[IsHighEducationRequired]);
        Add(IntToStr(MinAge) + '-' + IntToStr(MaxAge));
    End;
End;

Procedure TFirmListForm.ButtonAddClick(Sender: TObject);
Begin
    VacancyForm.ShowModal;
End;

Function GetFirmInfo(Item: TListItem): TFirm;
Var
    FirmInfo: TFirm;
Begin
    With FirmInfo, Item Do
    Begin
        Name := Caption;
        Speciality := SubItems[0];
        Title := SubItems[1];
        Salary := StrToInt(SubItems[2]);
        VacationDays := StrToInt(SubItems[3]);
        IsHighEducationRequired := SubItems[4] = HIGHEDUCATIONREQUIRED[True];
        MinAge := StrToInt(Copy(SubItems[5], 1, Pos('-', SubItems[5]) - 1));
        MaxAge := StrToInt(Copy(SubItems[5], Pos('-', SubItems[5]) + 1, 2));
    End;
    GetFirmInfo := FirmInfo;
End;

Procedure TFirmListForm.ButtonDeleteClick(Sender: TObject);
Var
    ButtonSelected: Integer;
Begin
    ButtonSelected := Application.MessageBox
      ('Вы уверены, что хотите удалить выделенную вакансию?', 'Удаление',
      MB_YESNO + MB_ICONQUESTION);
    If ButtonSelected = MrYes Then
    Begin
        DeleteVacancy(GetFirmInfo(ListView.Selected));
        ListView.Selected.Delete;
        // MMSaveFile.Enabled := MainListView.Items.Count > 0;
    End
    Else
        ListView.ClearSelection;
End;

Procedure TFirmListForm.ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
Begin
    ButtonSearch.Enabled := ListView.Items.Count > 0;
End;

Procedure TFirmListForm.ListViewDblClick(Sender: TObject);
Begin
    VacancyInfo := GetFirmInfo(ListView.Selected);
    IsEditing := True;
    VacancyForm.ShowModal;
End;

Procedure TFirmListForm.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
Begin
    ButtonDelete.Enabled := Selected;
    ButtonFindCandidates.Enabled := Selected;
End;

End.
