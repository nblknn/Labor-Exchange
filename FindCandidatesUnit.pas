Unit FindCandidatesUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls,
    CandidateListUnit, VacancyListUnit;

Type
    TFindCandidatesForm = Class(TForm)
        LabelVacancy: TLabel;
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMSaveFile: TMenuItem;
        ListViewVacancy: TListView;
        LabelCandidates: TLabel;
        ListViewCandidates: TListView;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FindCandidatesForm: TFindCandidatesForm;
    Vacancy: TVacancy;

Implementation

{$R *.dfm}

Uses DateUtils, MainUnit;

Var
    FoundCandidatesHead: PCandidate = Nil;

Procedure FindCandidates();
Var
    Temp: PCandidate;
    CandidateAge: Integer;
Begin
    Temp := CandidateHead;
    While Temp <> Nil Do
    Begin
        CandidateAge := YearsBetween(Now, Temp.BirthDate);
        If (AnsiUpperCase(Vacancy.Speciality) = AnsiUpperCase(Temp.Speciality))
          And (AnsiUpperCase(Vacancy.Title) = AnsiUpperCase(Temp.Title)) And
          (Vacancy.IsHighEducationRequired And Temp.HasHighEducation Or
          Not Vacancy.IsHighEducationRequired) And
          Not(Vacancy.MinAge > CandidateAge) And
          Not(Vacancy.MaxAge < CandidateAge) And
          Not(Vacancy.Salary < Temp.Salary) Then
        Begin
            AddCandidate(Temp^, FoundCandidatesHead);
            AddCandidateToListView(Temp^, FindCandidatesForm.ListViewCandidates);
        End;
        Temp := Temp.Next;
    End;
End;

Procedure TFindCandidatesForm.FormClose(Sender: TObject;
  Var Action: TCloseAction);
Begin
    ClearListView(ListViewVacancy);
    ClearListView(ListViewCandidates);
    DeleteCandidateList(FoundCandidatesHead);
End;

Procedure TFindCandidatesForm.FormShow(Sender: TObject);
Begin
    AddVacancyToListView(Vacancy, ListViewVacancy);
    FindCandidates();
    MMSaveFile.Enabled := ListViewCandidates.Items.Count > 0;
End;

End.
