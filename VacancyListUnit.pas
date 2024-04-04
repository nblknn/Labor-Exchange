Unit FirmListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
    MainUnit, Vcl.ExtCtrls, Vcl.DBCtrls;

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
        SaveDialog: TSaveDialog;
        OpenDialog: TOpenDialog;
        Procedure ButtonAddClick(Sender: TObject);
        Procedure DeleteVacancy(FirmInfo: TFirm);
        Procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
          Selected: Boolean);
        Procedure ListViewChange(Sender: TObject; Item: TListItem;
          Change: TItemChange);
        Procedure ButtonDeleteClick(Sender: TObject);
        Procedure ListViewDblClick(Sender: TObject);
        Procedure EditVacancy(OldInfo, NewInfo: TFirm);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure MMOpenFileClick(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Procedure AddVacancyToListView(FirmInfo: TFirm; ListView: TListView);
Procedure AddVacancy(FirmInfo: TFirm; Var Head: PFirm);

Var
    FirmListForm: TFirmListForm;
    FirmHead: PFirm = Nil;

Implementation

{$R *.dfm}

Uses VacancyUnit, SearchVacancyUnit;

Const
    HIGHEDUCATIONREQUIRED: Array [Boolean] Of String = ('Íå òðåáóåòñÿ',
      'Òðåáóåòñÿ');

Var
    IsFileSaved: Boolean;

Procedure AddVacancy(FirmInfo: TFirm; Var Head: PFirm);
Var
    NewFirm, Temp: PFirm;
Begin
    NewFirm := New(PFirm);
    NewFirm^ := FirmInfo;
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

Function AreVacanciesEqual(Firm1, Firm2: TFirm): Boolean;
Begin
    AreVacanciesEqual := (Firm1.Name = Firm2.Name) And
      (Firm1.Speciality = Firm2.Speciality) And (Firm1.Title = Firm2.Title) And
      (Firm1.Salary = Firm2.Salary) And
      (Firm1.VacationDays = Firm2.VacationDays) And
      (Firm1.IsHighEducationRequired = Firm2.IsHighEducationRequired) And
      (Firm1.MinAge = Firm2.MinAge) And (Firm1.MaxAge = Firm2.MaxAge);
End;

Procedure EditVacancyInListView(NewInfo: TFirm);
Begin
    With FirmListForm.ListView.Selected, NewInfo Do
    Begin
        Caption := Name;
        SubItems[0] := Speciality;
        SubItems[1] := Title;
        SubItems[2] := IntToStr(Salary);
        SubItems[3] := IntToStr(VacationDays);
        SubItems[4] := HIGHEDUCATIONREQUIRED[IsHighEducationRequired];
        SubItems[5] := IntToStr(MinAge) + '-' + IntToStr(MaxAge);
    End;
    IsFileSaved := False;
End;

Procedure TFirmListForm.EditVacancy(OldInfo, NewInfo: TFirm);
Var
    Temp: PFirm;
Begin
    Temp := FirmHead;
    While Not AreVacanciesEqual(OldInfo, Temp^) Do
        Temp := Temp.Next;
    Temp^ := NewInfo;
    EditVacancyInListView(NewInfo); // âûçûâàòü èç âàêàíñèþíèò?
End;

Procedure TFirmListForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
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

Procedure DeleteFirmList(Var Head: PFirm);
Var
    Temp: PFirm;
Begin
    Temp := Head;
    While Temp <> Nil Do
    Begin
        Head := Head.Next;
        Dispose(Temp);
        Temp := Head;
    End;
End;

Procedure AddVacancyToListView(FirmInfo: TFirm; ListView: TListView);
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
    IsFileSaved := False;
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
      ('Âû óâåðåíû, ÷òî õîòèòå óäàëèòü âûäåëåííóþ âàêàíñèþ?', 'Óäàëåíèå',
      MB_YESNO + MB_ICONQUESTION);
    If ButtonSelected = MrYes Then
    Begin
        DeleteVacancy(GetFirmInfo(ListView.Selected));
        ListView.Selected.Delete;
        IsFileSaved := False;
    End
    Else
        ListView.ClearSelection;
End;

procedure TFirmListForm.ButtonSearchClick(Sender: TObject);
begin
    SearchVacancyForm.Show;
end;

Procedure TFirmListForm.ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
Begin
    ButtonSearch.Enabled := ListView.Items.Count > 0;
    MMSaveFile.Enabled := ListView.Items.Count > 0;
End;

Procedure TFirmListForm.ListViewDblClick(Sender: TObject);
Begin
    OldInfo := GetFirmInfo(ListView.Selected);
    IsEditing := True;
    VacancyForm.ShowModal;
End;

Procedure TFirmListForm.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
Begin
    ButtonDelete.Enabled := Selected;
    ButtonFindCandidates.Enabled := Selected;
End;

Procedure TFirmListForm.MMOpenFileClick(Sender: TObject);
Var
    FirmFile: File Of TFirm;
    FirmInfo: TFirm;
    Head: PFirm;
Begin
    If OpenDialog.Execute Then
        Try
            Head := Nil;
            AssignFile(FirmFile, OpenDialog.FileName);
            Try
                Reset(FirmFile);
                While Not Eof(FirmFile) Do
                Begin
                    Read(FirmFile, FirmInfo);
                    AddVacancy(FirmInfo, Head);
                End;
            Except

            End;
        Finally
            CloseFile(FirmFile);
        End;
    If True Then
    Begin
        DeleteFirmList(FirmHead);
        FirmHead := Head;
        While Head <> Nil Do
        Begin
            AddVacancyToListView(Head^, ListView);
            Head := Head.Next;
        End;
        IsFileSaved := True;
    End
    Else
        DeleteFirmList(Head);
End;

Procedure TFirmListForm.MMSaveFileClick(Sender: TObject);
Var
    FirmFile: File Of TFirm;
    Temp: PFirm;
Begin
    If SaveDialog.Execute Then
        Try
            Temp := FirmHead;
            AssignFile(FirmFile, SaveDialog.FileName);
            Try
                Rewrite(FirmFile);
                While Temp <> Nil Do
                Begin
                    Write(FirmFile, Temp^);
                    Temp := Temp.Next;
                End;
            Except

            End;
        Finally
            CloseFile(FirmFile);
        End;
    If True Then
        IsFileSaved := True;
End;

End.
