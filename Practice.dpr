program Practice;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  FirmListUnit in 'FirmListUnit.pas' {FirmListForm},
  VacancyUnit in 'VacancyUnit.pas' {VacancyForm},
  CandidateListUnit in 'CandidateListUnit.pas' {CandidateListForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFirmListForm, FirmListForm);
  Application.CreateForm(TVacancyForm, VacancyForm);
  Application.CreateForm(TCandidateListForm, CandidateListForm);
  Application.Run;
end.
