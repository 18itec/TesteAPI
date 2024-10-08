unit uClienteAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFPrincipal = class(TForm)
    EdtCEP: TEdit;
    BtnConsult: TButton;
    gpStatus: TGroupBox;
    pnlStatusServer: TPanel;
    gpResult: TGroupBox;
    mResult: TMemo;
    BtnClose: TButton;
    procedure BtnConsultClick(Sender: TObject);
    procedure ExecuteQuery;
    procedure FormCreate(Sender: TObject);
    procedure TestServer;
    procedure EdtCEPEnter(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses uProcess;

procedure TFPrincipal.BtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFPrincipal.BtnConsultClick(Sender: TObject);
begin
  ExecuteQuery;
end;

procedure TFPrincipal.EdtCEPEnter(Sender: TObject);
begin
  mResult.Lines.Clear;
end;

procedure TFPrincipal.ExecuteQuery;
var
  Process: TProcess;
begin
  mResult.Lines.Clear;
  if Length(EdtCEP.Text) <= 0 then
  begin
    ShowMessage('Informe um CEP para consultar');
    EdtCEP.SetFocus;
    Exit;
  end;

  Application.ProcessMessages;
  mResult.Lines.Add('Consultado API...');
  BtnConsult.Caption:= 'Aguarde...';

  try
    Process := TProcess.Create;
    Process := Process.SendRequest(EdtCEP.Text);
    EdtCEP.Clear;
    mResult.Lines.Clear;
    if Length(Process.Error) <= 0 then
    begin
      mResult.Lines.Add(' CEP: '   +Process.ClearResult(Process.CEP));
      mResult.Lines.Add(' Rua: '   +Process.ClearResult(Process.Rua));
      mResult.Lines.Add(' Bairro: '+Process.ClearResult(Process.Bairro));
      mResult.Lines.Add(' Cidade: '+Process.ClearResult(Process.Cidade));
      mResult.Lines.Add(' Estado: '+Process.ClearResult(Process.UF));
    end
    else
    begin
      mResult.Lines.Add(Process.ClearResult(Process.Error));
    end;

  finally
    FreeAndNil(Process);
    BtnConsult.Caption:= 'Consultar';
  end;

end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  TestServer;
end;

procedure TFPrincipal.TestServer;
var
  pTest: TProcess;
begin

  try
    pTest := TProcess.Create;
    if pTest.TestServer then
    begin
      pnlStatusServer.Caption:= 'On-Line';
      pnlStatusServer.Color:=$00B0FFB0;
      EdtCEP.Clear;
      EdtCEP.Enabled:=True;
      BtnConsult.Enabled:=True;
    end
    else
    begin
      pnlStatusServer.Caption:= 'Off-Line';
      pnlStatusServer.Color:=$009595FF;
      EdtCEP.Clear;
      EdtCEP.Enabled:=false;
      BtnConsult.Enabled:=false;
    end;

  finally
    FreeAndNil(pTest);
  end;
end;

end.

