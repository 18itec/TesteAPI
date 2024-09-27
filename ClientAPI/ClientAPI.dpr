program ClientAPI;

uses
  Vcl.Forms,
  uClienteAPI in 'uClienteAPI.pas' {FPrincipal},
  uProcess in 'uProcess.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
