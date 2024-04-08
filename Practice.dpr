Program Practice;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  VacancyListUnit in 'VacancyListUnit.pas' {VacancyListForm},
  VacancyUnit in 'VacancyUnit.pas' {VacancyForm},
  CandidateListUnit in 'CandidateListUnit.pas' {CandidateListForm},
  CandidateUnit in 'CandidateUnit.pas' {CandidateForm},
  FindCandidatesUnit in 'FindCandidatesUnit.pas' {FindCandidatesForm},
  DeficitUnit in 'DeficitUnit.pas' {DeficitForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

Begin
    Application.Initialize;
    // Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Lavender Classico');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TVacancyListForm, VacancyListForm);
  Application.CreateForm(TVacancyForm, VacancyForm);
  Application.CreateForm(TCandidateListForm, CandidateListForm);
  Application.CreateForm(TCandidateForm, CandidateForm);
  Application.CreateForm(TFindCandidatesForm, FindCandidatesForm);
  Application.CreateForm(TDeficitForm, DeficitForm);
  Application.Run;

End.
