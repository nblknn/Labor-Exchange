Unit VacancyListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
    MainUnit, Vcl.ExtCtrls, Vcl.DBCtrls;

Type
    PVacancy = ^TVacancy;

    TVacancyInfo = Record
        FirmName, Speciality, Title: String[MAXLEN];
        Salary, VacationDays: Integer;
        IsHighEducationRequired: Boolean;
        MinAge, MaxAge: Integer;
    End;

    TVacancy = Record
        Info: TVacancyInfo;
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
        ButtonFindCandidates: TButton;
        SaveDialog: TSaveDialog;
        OpenDialog: TOpenDialog;
        MMHelp: TMenuItem;
        MMProgramInfo: TMenuItem;
        MMSeparator: TMenuItem;
        MMInstruction: TMenuItem;
    ButtonSearch: TButton;
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
        Procedure ButtonFindCandidatesClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMProgramInfoClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
        Procedure ListViewDeletion(Sender: TObject; Item: TListItem);
        Procedure ReadVacancyListFromFile();
        Procedure FormCreate(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Procedure AddVacancyToListView(VacancyInfo: TVacancyInfo; ListView: TListView);
Procedure AddVacancy(VacancyInfo: TVacancyInfo; Var Head: PVacancy);
Procedure EditVacancy(OldInfo, NewInfo: TVacancyInfo);
Function IsVacancyInList(Info: TVacancyInfo): Boolean;

Var
    VacancyListForm: TVacancyListForm;
    VacancyHead: PVacancy;
    IsVacancyListSaved: Boolean;
    VacancyAmount: Integer;

Implementation

{$R *.dfm}

Uses VacancyUnit, CandidateSelectUnit, VacancySearchUnit;

Const
    HIGHEDUREQUIRED: Array [Boolean] Of String = ('Не требуется', 'Требуется');

Procedure AddVacancyToListView(VacancyInfo: TVacancyInfo; ListView: TListView);
Var
    NewItem: TListItem;
Begin
    NewItem := ListView.Items.Add;
    NewItem.Caption := String(VacancyInfo.FirmName);
    With NewItem.SubItems, VacancyInfo Do
    Begin
        Add(String(Speciality));
        Add(String(Title));
        Add(IntToStr(Salary));
        Add(IntToStr(VacationDays));
        Add(HIGHEDUREQUIRED[IsHighEducationRequired]);
        Add(IntToStr(MinAge) + '-' + IntToStr(MaxAge));
    End;
End;

Procedure AddVacancy(VacancyInfo: TVacancyInfo; Var Head: PVacancy);
Var
    NewVacancy, Temp: PVacancy;
Begin
    NewVacancy := New(PVacancy);
    NewVacancy^.Info := VacancyInfo;
    NewVacancy^.Next := Nil;
    If Head = Nil Then
        Head := NewVacancy
    Else
    Begin
        Temp := Head;
        While Temp^.Next <> Nil Do
            Temp := Temp^.Next;
        Temp^.Next := NewVacancy;
    End;
End;

Function AreVacanciesEqual(Vacancy1, Vacancy2: TVacancyInfo): Boolean;
Begin
    AreVacanciesEqual := (Vacancy1.FirmName = Vacancy2.FirmName) And
      (Vacancy1.Speciality = Vacancy2.Speciality) And
      (Vacancy1.Title = Vacancy2.Title) And (Vacancy1.Salary = Vacancy2.Salary)
      And (Vacancy1.VacationDays = Vacancy2.VacationDays) And
      (Vacancy1.IsHighEducationRequired = Vacancy2.IsHighEducationRequired) And
      (Vacancy1.MinAge = Vacancy2.MinAge) And
      (Vacancy1.MaxAge = Vacancy2.MaxAge);
End;

Procedure EditVacancyInListView(NewInfo: TVacancyInfo);
Begin
    With VacancyListForm.ListView.Selected, NewInfo Do
    Begin
        Caption := String(FirmName);
        SubItems[0] := String(Speciality);
        SubItems[1] := String(Title);
        SubItems[2] := IntToStr(Salary);
        SubItems[3] := IntToStr(VacationDays);
        SubItems[4] := HIGHEDUREQUIRED[IsHighEducationRequired];
        SubItems[5] := IntToStr(MinAge) + '-' + IntToStr(MaxAge);
    End;
    IsVacancyListSaved := False;
End;

Function IsVacancyInList(Info: TVacancyInfo): Boolean;
Var
    Temp: PVacancy;
Begin
    Temp := VacancyHead;
    While (Temp <> Nil) And Not AreVacanciesEqual(Info, Temp^.Info) Do
        Temp := Temp.Next;
    IsVacancyInList := Temp <> Nil;
End;

Procedure EditVacancy(OldInfo, NewInfo: TVacancyInfo);
Var
    Temp: PVacancy;
Begin
    Temp := VacancyHead;
    While Not AreVacanciesEqual(OldInfo, Temp^.Info) Do
        Temp := Temp^.Next;
    Temp^.Info := NewInfo;
    EditVacancyInListView(NewInfo);
End;

Procedure TVacancyListForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    MainForm.Visible := True;
End;

Procedure TVacancyListForm.FormCreate(Sender: TObject);
Begin
    VacancyHead := Nil;
    IsVacancyListSaved := True;
    VacancyAmount := 0;
End;

Function TVacancyListForm.FormHelp(Command: Word; Data: NativeInt;
  Var CallHelp: Boolean): Boolean;
Begin
    ShowInstruction();
    CallHelp := False;
End;

Procedure TVacancyListForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = VK_DELETE) And ButtonDelete.Enabled Then
        ButtonDelete.Click;
End;

Procedure DeleteVacancy(VacancyInfo: TVacancyInfo);
Var
    Temp, Curr: PVacancy;
Begin
    Temp := VacancyHead;
    If AreVacanciesEqual(VacancyInfo, Temp^.Info) Then
        VacancyHead := Temp^.Next
    Else
    Begin
        While Not AreVacanciesEqual(VacancyInfo, Temp^.Next^.Info) Do
            Temp := Temp^.Next;
        Curr := Temp;
        Temp := Temp^.Next;
        Curr^.Next := Curr^.Next^.Next;
    End;
    Dispose(Temp);
End;

Procedure DeleteVacancyList(Var Head: PVacancy);
Var
    Curr: PVacancy;
Begin
    Curr := Head;
    While Curr <> Nil Do
    Begin
        Head := Head^.Next;
        Dispose(Curr);
        Curr := Head;
    End;
End;

Procedure TVacancyListForm.ButtonAddClick(Sender: TObject);
Begin
    If VacancyAmount < MAXRECORDAMOUNT Then
        VacancyForm.ShowModal
    Else
        Application.MessageBox('Достигнуто максимальное число вакансий!',
          'Ошибка', MB_ICONERROR);
End;

Function GetVacancyInfo(Item: TListItem): TVacancyInfo;
Var
    Vacancy: TVacancyInfo;
Begin
    With Vacancy, Item Do
    Begin
        FirmName := ShortString(Caption);
        Speciality := ShortString(SubItems[0]);
        Title := ShortString(SubItems[1]);
        Salary := StrToInt(SubItems[2]);
        VacationDays := StrToInt(SubItems[3]);
        IsHighEducationRequired := SubItems[4] = HIGHEDUREQUIRED[True];
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
        Dec(VacancyAmount);
    End
    Else
        ListView.ClearSelection;
End;

Procedure TVacancyListForm.ButtonFindCandidatesClick(Sender: TObject);
Begin
    Vacancy := GetVacancyInfo(ListView.Selected);
    CandidateSelectForm.ShowModal;
End;

procedure TVacancyListForm.ButtonSearchClick(Sender: TObject);
begin
    VacancySearchForm.Show;
end;

Procedure TVacancyListForm.ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
Begin
    MMSaveFile.Enabled := ListView.Items.Count > 0;
End;

Procedure TVacancyListForm.ListViewDblClick(Sender: TObject);
Begin
    If ListView.Selected <> Nil Then
    Begin
        OldInfo := GetVacancyInfo(ListView.Selected);
        IsEditing := True;
        VacancyForm.ShowModal;
    End;
End;

Procedure TVacancyListForm.ListViewDeletion(Sender: TObject; Item: TListItem);
Begin
    MMSaveFile.Enabled := ListView.Items.Count > 1;
    IsVacancyListSaved := ListView.Items.Count = 1;
End;

Procedure TVacancyListForm.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
Begin
    ButtonDelete.Enabled := Selected;
    ButtonFindCandidates.Enabled := Selected;
End;

Function IsVacancyCorrect(Vacancy: TVacancyInfo): Boolean;
Begin
    IsVacancyCorrect := IsNumCorrect(Vacancy.Salary, MINSALARY, MAXSALARY) And
      IsNumCorrect(Vacancy.VacationDays, MINVACATION, MAXVACATION) And
      IsNumCorrect(Vacancy.MinAge, MINWORKAGE, MAXWORKAGE) And
      IsNumCorrect(Vacancy.MaxAge, MINWORKAGE, MAXWORKAGE) And
      Not(Vacancy.MinAge > Vacancy.MaxAge);
End;

Procedure TVacancyListForm.ReadVacancyListFromFile();
Var
    InputFile: File Of TVacancyInfo;
    VacancyInfo: TVacancyInfo;
    Head: PVacancy;
    IsCorrect: Boolean;
    Count: Integer;
Begin
    IsCorrect := OpenDialog.Execute And IsFileExtCorrect(OpenDialog.FileName,
      VACANCYFILEEXT);
    If IsCorrect Then
    Begin
        Try
            Head := Nil;
            Count := 0;
            AssignFile(InputFile, OpenDialog.FileName);
            Try
                Reset(InputFile);
                If FileSize(InputFile) > MAXRECORDAMOUNT Then
                    IsCorrect := False;
                While Not Eof(InputFile) And IsCorrect Do
                Begin
                    Read(InputFile, VacancyInfo);
                    AddVacancy(VacancyInfo, Head);
                    IsCorrect := IsVacancyCorrect(VacancyInfo);
                    Inc(Count);
                End;
            Except
                IsCorrect := False;
            End;
        Finally
            CloseFile(InputFile);
        End;
        If IsCorrect Then
        Begin
            DeleteVacancyList(VacancyHead);
            ClearListView(ListView);
            VacancyHead := Head;
            While Head <> Nil Do
            Begin
                AddVacancyToListView(Head^.Info, ListView);
                Head := Head^.Next;
            End;
            VacancyAmount := Count;
            IsVacancyListSaved := True;
        End
        Else
        Begin
            DeleteVacancyList(Head);
            Application.MessageBox
              ('Произошла ошибка при открытии файла! Проверьте корректность данных!',
              'Ошибка', MB_ICONERROR);
        End;
    End;
End;

Procedure TVacancyListForm.MMOpenFileClick(Sender: TObject);
Var
    ButtonSelected: Integer;
Begin
    If Not IsVacancyListSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы хотите сохранить изменения в списке вакансий?', 'Выход',
          MB_YESNOCANCEL + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
            MMSaveFile.Click;
    End;
    ReadVacancyListFromFile();
End;

Procedure SaveVacancyListToFile(Path: String);
Var
    OutputFile: File Of TVacancyInfo;
    Temp: PVacancy;
Begin
    Try
        Temp := VacancyHead;
        AssignFile(OutputFile, Path);
        Rewrite(OutputFile);
        While Temp <> Nil Do
        Begin
            Write(OutputFile, Temp^.Info);
            Temp := Temp^.Next;
        End;
    Finally
        CloseFile(OutputFile);
    End;
End;

Procedure TVacancyListForm.MMSaveFileClick(Sender: TObject);
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := SaveDialog.Execute And IsFileExtCorrect(SaveDialog.FileName,
      VACANCYFILEEXT);
    If IsCorrect Then
        SaveVacancyListToFile(SaveDialog.FileName);
    IsVacancyListSaved := IsCorrect;
End;

Procedure TVacancyListForm.MMProgramInfoClick(Sender: TObject);
Begin
    ShowProgramInfo();
End;

Procedure TVacancyListForm.MMInstructionClick(Sender: TObject);
Begin
    ShowInstruction();
End;

End.
