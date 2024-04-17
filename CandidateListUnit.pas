Unit CandidateListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, MainUnit;

Type
    PCandidate = ^TCandidate;

    TCandidateInfo = Record
        Surname, Name, Patronymic, Speciality, Title: String[MAXLEN];
        BirthDate: TDateTime;
        HasHighEducation: Boolean;
        Salary: Integer;
    End;

    TCandidate = Record
        Info: TCandidateInfo;
        Next: PCandidate;
    End;

    TCandidateListForm = Class(TForm)
        ButtonAdd: TButton;
        ButtonDelete: TButton;
        ButtonDeficite: TButton;
        ListView: TListView;
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMOpenFile: TMenuItem;
        MMSaveFile: TMenuItem;
        OpenDialog: TOpenDialog;
        SaveDialog: TSaveDialog;
        MMHelp: TMenuItem;
        MMProgramInfo: TMenuItem;
        MMSeparator: TMenuItem;
        MMInstruction: TMenuItem;
    ButtonSearch: TButton;
        Procedure ButtonAddClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure ButtonDeleteClick(Sender: TObject);
        Procedure ListViewChange(Sender: TObject; Item: TListItem;
          Change: TItemChange);
        Procedure ListViewDblClick(Sender: TObject);
        Procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
          Selected: Boolean);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure ButtonDeficiteClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMProgramInfoClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
        Procedure ListViewDeletion(Sender: TObject; Item: TListItem);
        Procedure FormCreate(Sender: TObject);
        Procedure ReadCandidateListFromFile();
        Procedure MMOpenFileClick(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Procedure AddCandidateToListView(CandidateInfo: TCandidateInfo;
  ListView: TListView);
Procedure AddCandidate(CandidateInfo: TCandidateInfo; Var Head: PCandidate);
Procedure EditCandidate(OldInfo, NewInfo: TCandidateInfo);
Procedure DeleteCandidateList(Var Head: PCandidate);
Procedure SaveCandidateListToFile(Head: PCandidate; Path: String);
Function IsCandidateInList(Info: TCandidateInfo): Boolean;

Var
    CandidateListForm: TCandidateListForm;
    CandidateHead: PCandidate;
    IsCandidateListSaved: Boolean;
    CandidateAmount: Integer;

Implementation

{$R *.dfm}

Uses CandidateUnit, DeficitUnit, DateUtils, CandidateSearchUnit;

Const
    HIGHEDUCATION: Array [Boolean] Of String = ('Нет', 'Есть');

Procedure AddCandidateToListView(CandidateInfo: TCandidateInfo;
  ListView: TListView);
Var
    NewItem: TListItem;
Begin
    NewItem := ListView.Items.Add;
    NewItem.Caption := String(CandidateInfo.Surname);
    With NewItem.SubItems, CandidateInfo Do
    Begin
        Add(String(Name));
        Add(String(Patronymic));
        Add(DateToStr(BirthDate));
        Add(String(Speciality));
        Add(HIGHEDUCATION[HasHighEducation]);
        Add(String(Title));
        Add(IntToStr(Salary));
    End;
End;

Procedure AddCandidate(CandidateInfo: TCandidateInfo; Var Head: PCandidate);
Var
    NewCandidate, Temp: PCandidate;
Begin
    NewCandidate := New(PCandidate);
    NewCandidate^.Info := CandidateInfo;
    NewCandidate^.Next := Nil;
    If Head = Nil Then
        Head := NewCandidate
    Else
    Begin
        Temp := Head;
        While Temp^.Next <> Nil Do
            Temp := Temp^.Next;
        Temp^.Next := NewCandidate;
    End;
End;

Function AreCandidatesEqual(Candidate1, Candidate2: TCandidateInfo): Boolean;
Begin
    AreCandidatesEqual := (Candidate1.Surname = Candidate2.Surname) And
      (Candidate1.Name = Candidate2.Name) And
      (Candidate1.Patronymic = Candidate2.Patronymic) And
      (Candidate1.Speciality = Candidate2.Speciality) And
      (Candidate1.Title = Candidate2.Title) And
      (Candidate1.BirthDate = Candidate2.BirthDate) And
      (Candidate1.HasHighEducation = Candidate2.HasHighEducation) And
      (Candidate1.Salary = Candidate2.Salary);
End;

Procedure EditCandidateInListView(NewInfo: TCandidateInfo);
Begin
    With CandidateListForm.ListView.Selected, NewInfo Do
    Begin
        Caption := String(Surname);
        SubItems[0] := String(Name);
        SubItems[1] := String(Patronymic);
        SubItems[2] := DateToStr(BirthDate);
        SubItems[3] := String(Speciality);
        SubItems[4] := HIGHEDUCATION[HasHighEducation];
        SubItems[5] := String(Title);
        SubItems[6] := IntToStr(Salary);
    End;
    IsCandidateListSaved := False;
End;

Procedure EditCandidate(OldInfo, NewInfo: TCandidateInfo);
Var
    Temp: PCandidate;
Begin
    Temp := CandidateHead;
    While Not AreCandidatesEqual(OldInfo, Temp^.Info) Do
        Temp := Temp^.Next;
    Temp^.Info := NewInfo;
    EditCandidateInListView(NewInfo); // вызывать из candidateюнит?
End;

Function IsCandidateInList(Info: TCandidateInfo): Boolean;
Var
    Temp: PCandidate;
Begin
    Temp := CandidateHead;
    While (Temp <> Nil) And Not AreCandidatesEqual(Info, Temp^.Info) Do
        Temp := Temp.Next;
    IsCandidateInList := Temp <> Nil;
End;

Procedure DeleteCandidate(CandidateInfo: TCandidateInfo);
Var
    Temp, Curr: PCandidate;
Begin
    Temp := CandidateHead;
    If Not AreCandidatesEqual(CandidateInfo, Temp^.Info) Then
    Begin
        While Not AreCandidatesEqual(CandidateInfo, Temp^.Next^.Info) Do
            Temp := Temp^.Next;
        Curr := Temp;
        Temp := Temp^.Next;
        Curr^.Next := Curr^.Next^.Next;
    End
    Else
        CandidateHead := Temp^.Next;
    Dispose(Temp);
End;

Procedure DeleteCandidateList(Var Head: PCandidate);
Var
    Temp: PCandidate;
Begin
    Temp := Head;
    While Temp <> Nil Do
    Begin
        Head := Head^.Next;
        Dispose(Temp);
        Temp := Head;
    End;
End;

Function GetCandidateInfo(Item: TListItem): TCandidateInfo;
Var
    Candidate: TCandidateInfo;
Begin
    With Candidate, Item Do
    Begin
        Surname := ShortString(Caption);
        Name := ShortString(SubItems[0]);
        Patronymic := ShortString(SubItems[1]);
        BirthDate := StrToDate(SubItems[2]);
        Speciality := ShortString(SubItems[3]);
        HasHighEducation := HIGHEDUCATION[True] = SubItems[4];
        Title := ShortString(SubItems[5]);
        Salary := StrToInt(SubItems[6]);
    End;
    GetCandidateInfo := Candidate;
End;

Procedure TCandidateListForm.ButtonAddClick(Sender: TObject);
Begin
    If CandidateAmount < MAXRECORDAMOUNT Then
        CandidateForm.ShowModal
    Else
        Application.MessageBox('Достигнуто максимальное число кандидатов!',
          'Ошибка', MB_ICONERROR);
End;

Procedure TCandidateListForm.ButtonDeficiteClick(Sender: TObject);
Begin
    DeficitForm.ShowModal;
End;

Procedure TCandidateListForm.ButtonDeleteClick(Sender: TObject);
Var
    ButtonSelected: Integer;
Begin
    ButtonSelected := Application.MessageBox
      ('Вы уверены, что хотите удалить выделенного кандидата?', 'Удаление',
      MB_YESNO + MB_ICONQUESTION);
    If ButtonSelected = MrYes Then
    Begin
        DeleteCandidate(GetCandidateInfo(ListView.Selected));
        ListView.Selected.Delete;
        Dec(CandidateAmount);
    End
    Else
        ListView.ClearSelection;
End;

procedure TCandidateListForm.ButtonSearchClick(Sender: TObject);
begin
    CandidateSearchForm.Show;
end;

Procedure TCandidateListForm.FormClose(Sender: TObject;
  Var Action: TCloseAction);
Begin
    MainForm.Visible := True;
End;

Procedure TCandidateListForm.FormCreate(Sender: TObject);
Begin
    CandidateHead := Nil;
    IsCandidateListSaved := True;
    CandidateAmount := 0;
End;

Function TCandidateListForm.FormHelp(Command: Word; Data: NativeInt;
  Var CallHelp: Boolean): Boolean;
Begin
    ShowInstruction();
    CallHelp := False;
End;

Procedure TCandidateListForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = VK_DELETE) And ButtonDelete.Enabled Then
        ButtonDelete.Click;
End;

Procedure TCandidateListForm.ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
Begin
    ButtonDeficite.Enabled := ListView.Items.Count > 0;
    MMSaveFile.Enabled := ListView.Items.Count > 0;
End;

Procedure TCandidateListForm.ListViewDblClick(Sender: TObject);
Begin
    If ListView.Selected <> Nil Then
    Begin
        OldInfo := GetCandidateInfo(ListView.Selected);
        IsEditing := True;
        CandidateForm.ShowModal;
    End;
End;

Procedure TCandidateListForm.ListViewDeletion(Sender: TObject; Item: TListItem);
Begin
    ButtonDeficite.Enabled := ListView.Items.Count > 1;
    MMSaveFile.Enabled := ListView.Items.Count > 1;
    IsCandidateListSaved := ListView.Items.Count = 1;
End;

Procedure TCandidateListForm.ListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
Begin
    ButtonDelete.Enabled := Selected;
End;

Procedure TCandidateListForm.MMInstructionClick(Sender: TObject);
Begin
    ShowInstruction();
End;

Procedure TCandidateListForm.MMOpenFileClick(Sender: TObject);
Var
    ButtonSelected: Integer;
Begin
    If Not IsCandidateListSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы хотите сохранить изменения в списке кандидатов?', 'Выход',
          MB_YESNOCANCEL + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
            MMSaveFile.Click;
    End;
    ReadCandidateListFromFile();
End;

Function IsCandidateCorrect(Candidate: TCandidateInfo): Boolean;
Begin
    IsCandidateCorrect := IsNumCorrect(Candidate.Salary, MINSALARY, MAXSALARY)
      And IsNumCorrect(YearsBetween(Now, Candidate.BirthDate), MINWORKAGE,
      MAXWORKAGE);
End;

Procedure TCandidateListForm.ReadCandidateListFromFile();
Var
    InputFile: File Of TCandidateInfo;
    CandidateInfo: TCandidateInfo;
    Head: PCandidate;
    IsCorrect: Boolean;
    Count: Integer;
Begin
    IsCorrect := OpenDialog.Execute And IsFileExtCorrect(OpenDialog.FileName,
      CANDIDATEFILEEXT);
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
                    Read(InputFile, CandidateInfo);
                    AddCandidate(CandidateInfo, Head);
                    IsCorrect := IsCandidateCorrect(CandidateInfo);
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
            DeleteCandidateList(CandidateHead);
            ClearListView(ListView);
            CandidateHead := Head;
            While Head <> Nil Do
            Begin
                AddCandidateToListView(Head^.Info, ListView);
                Head := Head^.Next;
            End;
            CandidateAmount := Count;
            IsCandidateListSaved := True;
        End
        Else
        Begin
            DeleteCandidateList(Head);
            Application.MessageBox
              ('Произошла ошибка при открытии файла! Проверьте корректность данных!',
              'Ошибка', MB_ICONERROR);
        End;
    End;
End;

Procedure TCandidateListForm.MMProgramInfoClick(Sender: TObject);
Begin
    ShowProgramInfo();
End;

Procedure SaveCandidateListToFile(Head: PCandidate; Path: String);
Var
    OutputFile: File Of TCandidateInfo;
    Temp: PCandidate;
Begin
    Try
        Temp := Head;
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

Procedure TCandidateListForm.MMSaveFileClick(Sender: TObject);
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := SaveDialog.Execute And IsFileExtCorrect(SaveDialog.FileName,
      CANDIDATEFILEEXT);
    If IsCorrect Then
        SaveCandidateListToFile(CandidateHead, SaveDialog.FileName);
    IsCandidateListSaved := IsCorrect;
End;

End.
