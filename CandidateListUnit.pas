Unit CandidateListUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, MainUnit;

Type
    PCandidate = ^TCandidate;

    TCandidate = Record
        Name, Surname, Patronymic, Speciality, Position: String[MAXLEN];
        BirthDate: TDate;
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
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    CandidateListForm: TCandidateListForm;

Implementation

{$R *.dfm}

End.
