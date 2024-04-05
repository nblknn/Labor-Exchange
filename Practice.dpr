program Practice;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  VacancyListUnit in 'VacancyListUnit.pas' {VacancyListForm},
  VacancyUnit in 'VacancyUnit.pas' {VacancyForm},
  CandidateListUnit in 'CandidateListUnit.pas' {CandidateListForm},
  VacancySearchUnit in 'VacancySearchUnit.pas' {VacancySearchForm},
  CandidateUnit in 'CandidateUnit.pas' {CandidateForm},
  FindCandidatesUnit in 'FindCandidatesUnit.pas' {FindCandidatesForm},
  DeficiteUnit in 'DeficiteUnit.pas' {DeficiteForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TVacancyListForm, VacancyListForm);
  Application.CreateForm(TVacancyForm, VacancyForm);
  Application.CreateForm(TCandidateListForm, CandidateListForm);
  Application.CreateForm(TVacancySearchForm, VacancySearchForm);
  Application.CreateForm(TCandidateForm, CandidateForm);
  Application.CreateForm(TFindCandidatesForm, FindCandidatesForm);
  Application.CreateForm(TDeficiteForm, DeficiteForm);
  Application.Run;
end.
