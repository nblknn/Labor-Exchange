Unit CandidateListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
    MainUnit;

Type
    PCandidate = ^TCandidate;

    TCandidate = Record
        Name, Surname, Patronymic, Speciality, Title: String[MAXLEN];
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
        MMInstruction: TMenuItem;
        Procedure ButtonAddClick(Sender: TObject);
        Procedure AddCandidate(CandidateInfo: TCandidate);
        Procedure AddCandidateToListView(CandidateInfo: TCandidate);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    CandidateListForm: TCandidateListForm;

Implementation

{$R *.dfm}

Uses CandidateUnit;

Const
    HIGHEDUCATION: Array [Boolean] Of String = ('Нет', 'Есть');

Var
    CandidateHead: PCandidate = Nil;

Procedure TCandidateListForm.AddCandidateToListView(CandidateInfo: TCandidate);
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

Procedure TCandidateListForm.AddCandidate(CandidateInfo: TCandidate);
Var
    NewCandidate, Temp: PCandidate;
Begin
    NewCandidate := New(PCandidate);
    NewCandidate^ := CandidateInfo;
    NewCandidate^.Next := Nil;
    If CandidateHead = Nil Then
        CandidateHead := NewCandidate
    Else
    Begin
        Temp := CandidateHead;
        While Temp.Next <> Nil Do
            Temp := Temp.Next;
        Temp.Next := NewCandidate;
    End;
    AddCandidateToListView(CandidateInfo);
End;

Procedure TCandidateListForm.ButtonAddClick(Sender: TObject);
Begin
    CandidateForm.ShowModal;
End;

Procedure TCandidateListForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
