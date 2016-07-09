program DH_Junk_Code_Maker;

uses
  Vcl.Forms,
  junk in 'junk.pas' {FormHome},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Charcoal Dark Slate');
  Application.CreateForm(TFormHome, FormHome);
  Application.Run;
end.
