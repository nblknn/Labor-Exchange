Unit CandidateListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, MainUnit;

Type
    PCandidate = ^TCandidate;

    TCandidate = Record
        Surname, Name, Patronymic, Speciality, Title: String[MAXLEN];
        BirthDate: TDateTime;
        HasHighEducation: Boolean;
        Salary: Integer;
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
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Procedure AddCandidateToListView(CandidateInfo: TCandidate;
  ListView: TListView);
Procedure AddCandidate(CandidateInfo: TCandidate; Var Head: PCandidate);
Procedure EditCandidate(OldInfo, NewInfo: TCandidate);
Procedure DeleteCandidateList(Var Head: PCandidate);

Var
    CandidateListForm: TCandidateListForm;
    CandidateHead: PCandidate = Nil;

Implementation

{$R *.dfm}

Uses CandidateUnit, DeficiteUnit;

Const
    HIGHEDUCATION: Array [Boolean] Of String = ('Нет', 'Есть');

Var
    IsFileSaved: Boolean;

Procedure AddCandidateToListView(CandidateInfo: TCandidate;
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
End;

Procedure AddCandidate(CandidateInfo: TCandidate; Var Head: PCandidate);
Var
    NewCandidate, Temp: PCandidate;
Begin
    NewCandidate := New(PCandidate);
    NewCandidate^ := CandidateInfo;
    NewCandidate^.Next := Nil;
    If Head = Nil Then
        Head := NewCandidate
    Else
    Begin
        Temp := Head;
        While Temp.Next <> Nil Do
            Temp := Temp.Next;
        Temp.Next := NewCandidate;
    End;
End;

Function AreCandidatesEqual(Candidate1, Candidate2: TCandidate): Boolean;
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

Procedure EditCandidateInListView(NewInfo: TCandidate);
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
    IsFileSaved := False;
End;

Procedure EditCandidate(OldInfo, NewInfo: TCandidate);
Var
    Temp: PCandidate;
Begin
    Temp := CandidateHead;
    While Not AreCandidatesEqual(OldInfo, Temp^) Do
        Temp := Temp.Next;
    Temp^ := NewInfo;
    EditCandidateInListView(NewInfo); // вызывать из candidateюнит?
End;

Procedure DeleteCandidate(CandidateInfo: TCandidate);
Var
    Temp1, Temp2: PCandidate;
Begin
    Temp1 := CandidateHead;
    If Not AreCandidatesEqual(CandidateInfo, Temp1^) Then
    Begin
        While Not AreCandidatesEqual(CandidateInfo, Temp1.Next^) Do
            Temp1 := Temp1.Next;
        Temp2 := Temp1;
        Temp2.Next := Temp1.Next.Next;
        Temp1 := Temp1.Next;
    End
    Else
        CandidateHead := Temp1.Next;
    Dispose(Temp1);
End;

Procedure DeleteCandidateList(Var Head: PCandidate);
Var
    Temp: PCandidate;
Begin
    Temp := Head;
    While Temp <> Nil Do
    Begin
        Head := Head.Next;
        Dispose(Temp);
        Temp := Head;
    End;
End;

Function GetCandidateInfo(Item: TListItem): TCandidate;
Var
    Candidate: TCandidate;
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
        IsFileSaved := False;
    End
    Else
        ListView.ClearSelection;
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
    // OldInfo := GetCandidateInfo(ListView.Selected);
    IsEditing := True;
    CandidateForm.ShowModal;
End;

Procedure TCandidateListForm.ListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
Begin
    ButtonDelete.Enabled := Selected;
End;

Procedure TCandidateListForm.MMOpenFileClick(Sender: TObject);
Var
    InputFile: File Of TCandidate;
    CandidateInfo: TCandidate;
    Head: PCandidate;
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
                        Read(InputFile, CandidateInfo);
                        AddCandidate(CandidateInfo, Head);
                    End;
                Except
                    Error := ErrCantOpenFile;
                End;
            Finally
                CloseFile(InputFile);
            End;
        If Error = Correct Then
        Begin
            DeleteCandidateList(CandidateHead);
            ClearListView(ListView);
            CandidateHead := Head;
            While Head <> Nil Do
            Begin
                AddCandidateToListView(Head^, ListView);
                Head := Head.Next;
            End;
            IsFileSaved := True;
        End
        Else
        Begin
            DeleteCandidateList(Head);
            ShowErrorMessage(Error);
        End;
    End;
End;

Procedure TCandidateListForm.MMSaveFileClick(Sender: TObject);
Var
    OutputFile: File Of TCandidate;
    Temp: PCandidate;
    Error: TError;
Begin
    If SaveDialog.Execute Then
    Begin
        Error := CheckFileExtension(SaveDialog.FileName);
        If Error = Correct Then
            Try
                Temp := CandidateHead;
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
