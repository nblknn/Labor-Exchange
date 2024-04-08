Unit DeficitUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Menus;

Type
    TDeficitForm = Class(TForm)
        SaveDialog: TSaveDialog;
        ListView: TListView;
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMSaveFile: TMenuItem;
        LabelInfo: TLabel;
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure MMSaveFileClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    DeficitForm: TDeficitForm;

Implementation

{$R *.dfm}

Uses CandidateListUnit, VacancyListUnit, MainUnit;

Type
    TTitle = Record
        Title: String[MAXLEN];
        VacancyCount, CandidateCount: Integer;
    End;

Var
    Head: PCandidate;
    TitleArr: Array Of TTitle;

Function FindArrPosition(Title: ShortString): Integer;
Var
    IsInArray: Boolean;
    I: Integer;
Begin
    IsInArray := False;
    I := 0;
    While Not IsInArray And (I < Length(TitleArr)) Do
    Begin
        If AnsiUpperCase(Title) = AnsiUpperCase(TitleArr[I].Title) Then
            IsInArray := True;
        Inc(I);
    End;
    If IsInArray Then
        FindArrPosition := I - 1
    Else
        FindArrPosition := -1;
End;

Procedure FindAllVacancyTitles();
Var
    Temp: PVacancy;
    I: Integer;
Begin
    Temp := VacancyHead;
    While Temp <> Nil Do
    Begin
        I := FindArrPosition(Temp^.Info.Title);
        If I = -1 Then
        Begin
            SetLength(TitleArr, Length(TitleArr) + 1);
            TitleArr[High(TitleArr)].Title := Temp^.Info.Title;
            TitleArr[High(TitleArr)].VacancyCount := 1;
            TitleArr[High(TitleArr)].CandidateCount := 0;
        End
        Else
            Inc(TitleArr[I].VacancyCount);
        Temp := Temp.Next;
    End;
End;

Procedure CountCandidates();
Var
    Temp: PCandidate;
    I: Integer;
Begin
    Temp := CandidateHead;
    While Temp <> Nil Do
    Begin
        I := FindArrPosition(Temp^.Info.Title);
        If I <> -1 Then
            Inc(TitleArr[I].CandidateCount);
        Temp := Temp^.Next;
    End;
End;

Procedure FindDeficiteCandidates();
Var
    I: Integer;
    Temp: PCandidate;
Begin
    For I := Low(TitleArr) To High(TitleArr) Do
        If TitleArr[I].VacancyCount > TitleArr[I].CandidateCount * 10 Then
        Begin
            Temp := CandidateHead;
            While Temp <> Nil Do
            Begin
                If AnsiUpperCase(Temp^.Info.Title)
                  = AnsiUpperCase(TitleArr[I].Title) Then
                Begin
                    AddCandidate(Temp^.Info, Head);
                    AddCandidateToListView(Temp^.Info, DeficitForm.ListView);
                End;
                Temp := Temp^.Next;
            End;
        End;
End;

Procedure TDeficitForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    ClearListView(ListView);
    TitleArr := Nil;
    DeleteCandidateList(Head);
End;

Function TDeficitForm.FormHelp(Command: Word; Data: NativeInt;
  Var CallHelp: Boolean): Boolean;
Begin
    ShowInstruction();
    CallHelp := False;
End;

Procedure TDeficitForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TDeficitForm.FormShow(Sender: TObject);
Begin
    FindAllVacancyTitles();
    CountCandidates();
    FindDeficiteCandidates();
End;

Procedure TDeficitForm.MMSaveFileClick(Sender: TObject);
Begin
    If SaveDialog.Execute Then
        SaveCandidateListToFile(Head, SaveDialog.FileName);
End;

End.
