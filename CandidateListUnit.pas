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
        ButtonSearch: TButton;
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
        Procedure ButtonAddClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure ButtonDeleteClick(Sender: TObject);
        Procedure ListViewChange(Sender: TObject; Item: TListItem;
          Change: TItemChange);
        Procedure ListViewDblClick(Sender: TObject);
        Procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
          Selected: Boolean);
        Procedure MMOpenFileClick(Sender: TObject);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure ButtonDeficiteClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMProgramInfoClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
        Procedure ButtonSearchClick(Sender: TObject);
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
Function SaveCandidateListToFile(Head: PCandidate; Path: String): Boolean;

Var
    CandidateListForm: TCandidateListForm;
    CandidateHead: PCandidate = Nil;
    IsCandidateListSaved: Boolean = True;

Implementation

{$R *.dfm}

Uses CandidateUnit, DeficiteUnit, CandidateSearchUnit;

Const
    HIGHEDUCATION: Array [Boolean] Of String = ('Нет', 'Есть');

Procedure AddCandidateToListView(CandidateInfo: TCandidateInfo;
  ListView: TListView);
Var
    NewItem: TListItem;
Begin
    NewItem := ListView.Items.Add;
    NewItem.Caption := CandidateInfo.Surname;
    With NewItem.SubItems, CandidateInfo Do
    Begin
        Add(Name);
        Add(Patronymic);
        Add(DateToStr(BirthDate));
        Add(Speciality);
        Add(HIGHEDUCATION[HasHighEducation]);
        Add(Title);
        Add(IntToStr(Salary));
    End;
    IsCandidateListSaved := False;
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
        Caption := Surname;
        SubItems[0] := Name;
        SubItems[1] := Patronymic;
        SubItems[2] := DateToStr(BirthDate);
        SubItems[3] := Speciality;
        SubItems[4] := HIGHEDUCATION[HasHighEducation];
        SubItems[5] := Title;
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

Procedure DeleteCandidate(CandidateInfo: TCandidateInfo);
Var
    Temp1, Temp2: PCandidate;
Begin
    Temp1 := CandidateHead;
    If Not AreCandidatesEqual(CandidateInfo, Temp1^.Info) Then
    Begin
        While Not AreCandidatesEqual(CandidateInfo, Temp1^.Next^.Info) Do
            Temp1 := Temp1^.Next;
        Temp2 := Temp1;
        Temp2^.Next := Temp1^.Next^.Next;
        Temp1 := Temp1^.Next;
    End
    Else
        CandidateHead := Temp1^.Next;
    Dispose(Temp1);
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
        Surname := Caption;
        Name := SubItems[0];
        Patronymic := SubItems[1];
        BirthDate := StrToDate(SubItems[2]);
        Speciality := SubItems[3];
        HasHighEducation := HIGHEDUCATION[True] = SubItems[4];
        Title := SubItems[5];
        Salary := StrToInt(SubItems[6]);
    End;
    GetCandidateInfo := Candidate;
End;

Procedure TCandidateListForm.ButtonAddClick(Sender: TObject);
Begin
    CandidateForm.ShowModal;
End;

Procedure TCandidateListForm.ButtonDeficiteClick(Sender: TObject);
Begin
    DeficiteForm.ShowModal;
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
        IsCandidateListSaved := False;
    End
    Else
        ListView.ClearSelection;
End;

Procedure TCandidateListForm.ButtonSearchClick(Sender: TObject);
Begin
    CandidateSearchForm.Show;
End;

Procedure TCandidateListForm.FormClose(Sender: TObject;
  Var Action: TCloseAction);
Begin
    MainForm.Visible := True;
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
    ButtonSearch.Enabled := ListView.Items.Count > 0;
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
    InputFile: File Of TCandidateInfo;
    CandidateInfo: TCandidateInfo;
    Head: PCandidate;
    IsCorrect: Boolean;
Begin
    IsCorrect := OpenDialog.Execute And IsFileExtCorrect(OpenDialog.FileName,
      CANDIDATEFILEEXT);
    If IsCorrect Then
    Begin
        Try
            Head := Nil;
            AssignFile(InputFile, OpenDialog.FileName);
            Try
                Reset(InputFile);
                While Not Eof(InputFile) Do
                Begin
                    Read(InputFile, CandidateInfo);
                    AddCandidate(CandidateInfo, Head);
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
            IsCandidateListSaved := True;
        End
        Else
        Begin
            DeleteCandidateList(Head);
            Application.MessageBox('Произошла ошибка при открытии файла!',
              'Ошибка', MB_ICONERROR);
        End;
    End;
End;

Procedure TCandidateListForm.MMProgramInfoClick(Sender: TObject);
Begin
    ShowProgramInfo();
End;

Function SaveCandidateListToFile(Head: PCandidate; Path: String): Boolean;
Var
    OutputFile: File Of TCandidateInfo;
    Temp: PCandidate;
    IsCorrect: Boolean;
Begin
    IsCorrect := IsFileExtCorrect(Path, CANDIDATEFILEEXT);
    If IsCorrect Then
        Try
            Temp := Head;
            AssignFile(OutputFile, Path);
            Try
                Rewrite(OutputFile);
                While Temp <> Nil Do
                Begin
                    Write(OutputFile, Temp^.Info);
                    Temp := Temp^.Next;
                End;
            Except
                IsCorrect := False;
            End;
        Finally
            CloseFile(OutputFile);
        End;
    If Not IsCorrect Then
        Application.MessageBox('Произошла ошибка при записи в файл!', 'Ошибка',
          MB_ICONERROR);
    SaveCandidateListToFile := IsCorrect;
End;

Procedure TCandidateListForm.MMSaveFileClick(Sender: TObject);
Begin
    If SaveDialog.Execute Then
        IsCandidateListSaved := SaveCandidateListToFile(CandidateHead,
          SaveDialog.FileName);
End;

End.
