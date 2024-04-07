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
        SaveDialog: TSaveDialog;
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure MMSaveFileClick(Sender: TObject);
    function FormHelp(Command: Word; Data: NativeInt;
      var CallHelp: Boolean): Boolean;
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FindCandidatesForm: TFindCandidatesForm;
    Vacancy: TVacancyInfo;

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
        CandidateAge := YearsBetween(Now, Temp^.Info.BirthDate);
        If (AnsiUpperCase(Vacancy.Speciality)
          = AnsiUpperCase(Temp^.Info.Speciality)) And
          (AnsiUpperCase(Vacancy.Title) = AnsiUpperCase(Temp^.Info.Title)) And
          (Vacancy.IsHighEducationRequired And Temp^.Info.HasHighEducation Or
          Not Vacancy.IsHighEducationRequired) And
          Not(Vacancy.MinAge > CandidateAge) And
          Not(Vacancy.MaxAge < CandidateAge) And
          Not(Vacancy.Salary < Temp^.Info.Salary) Then
        Begin
            AddCandidate(Temp^.Info, FoundCandidatesHead);
            AddCandidateToListView(Temp^.Info,
              FindCandidatesForm.ListViewCandidates);
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

function TFindCandidatesForm.FormHelp(Command: Word; Data: NativeInt;
  var CallHelp: Boolean): Boolean;
begin
    ShowInstruction();
    CallHelp := False;
end;

Procedure TFindCandidatesForm.FormShow(Sender: TObject);
Begin
    AddVacancyToListView(Vacancy, ListViewVacancy);
    FindCandidates();
    MMSaveFile.Enabled := ListViewCandidates.Items.Count > 0;
End;

Procedure TFindCandidatesForm.MMSaveFileClick(Sender: TObject);
Begin
    If SaveDialog.Execute Then
        SaveCandidateListToFile(FoundCandidatesHead, SaveDialog.FileName);
End;

End.
