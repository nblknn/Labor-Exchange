Unit CandidateSelectUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls,
    CandidateListUnit, VacancyListUnit;

Type
    TCandidateSelectForm = Class(TForm)
        LabelVacancy: TLabel;
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMSaveFile: TMenuItem;
        ListViewVacancy: TListView;
        LabelCandidates: TLabel;
        ListViewCandidates: TListView;
        SaveDialog: TSaveDialog;
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure MMSaveFileClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    CandidateSelectForm: TCandidateSelectForm;
    Vacancy: TVacancyInfo;

Implementation

{$R *.dfm}

Uses DateUtils, MainUnit;

Var
    FoundCandidatesHead: PCandidate = Nil;

Function IsCandidateSuitable(Candidate: TCandidateInfo): Boolean;
Var
    CandidateAge: Integer;
Begin
    CandidateAge := YearsBetween(Now, Candidate.BirthDate);
    IsCandidateSuitable := (AnsiUpperCase(String(Vacancy.Speciality))
      = AnsiUpperCase(String(Candidate.Speciality))) And
      (AnsiUpperCase(String(Vacancy.Title))
      = AnsiUpperCase(String(Candidate.Title))) And
      (Vacancy.IsHighEducationRequired And Candidate.HasHighEducation Or
      Not Vacancy.IsHighEducationRequired) And
      Not(Vacancy.MinAge > CandidateAge) And Not(Vacancy.MaxAge < CandidateAge)
      And Not(Vacancy.Salary < Candidate.Salary);
End;

Procedure SelectCandidates();
Var
    Temp: PCandidate;
Begin
    Temp := CandidateHead;
    While Temp <> Nil Do
    Begin
        If IsCandidateSuitable(Temp^.Info) Then
        Begin
            AddCandidate(Temp^.Info, FoundCandidatesHead);
            AddCandidateToListView(Temp^.Info,
              CandidateSelectForm.ListViewCandidates);
        End;
        Temp := Temp.Next;
    End;
End;

Procedure TCandidateSelectForm.FormClose(Sender: TObject;
  Var Action: TCloseAction);
Begin
    ClearListView(ListViewVacancy);
    ClearListView(ListViewCandidates);
    DeleteCandidateList(FoundCandidatesHead);
End;

Function TCandidateSelectForm.FormHelp(Command: Word; Data: NativeInt;
  Var CallHelp: Boolean): Boolean;
Begin
    ShowInstruction();
    CallHelp := False;
End;

Procedure TCandidateSelectForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TCandidateSelectForm.FormShow(Sender: TObject);
Begin
    AddVacancyToListView(Vacancy, ListViewVacancy);
    SelectCandidates();
    MMSaveFile.Enabled := ListViewCandidates.Items.Count > 0;
End;

Procedure TCandidateSelectForm.MMSaveFileClick(Sender: TObject);
Begin
    If SaveDialog.Execute Then
        SaveCandidateListToFile(FoundCandidatesHead, SaveDialog.FileName);
End;

End.
