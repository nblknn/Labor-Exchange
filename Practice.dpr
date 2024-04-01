program Practice;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  FirmListUnit in 'FirmListUnit.pas' {FirmListForm},
  VacancyUnit in 'VacancyUnit.pas' {VacancyForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFirmListForm, FirmListForm);
  Application.CreateForm(TVacancyForm, VacancyForm);
  Application.Run;
end.
