unit SearchVacancyUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FirmListUnit, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TSearchVacancyForm = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBRadioGroup1: TDBRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchVacancyForm: TSearchVacancyForm;

implementation

{$R *.dfm}

end.
