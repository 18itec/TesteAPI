unit uProcess;

interface

uses  System.SysUtils,System.JSON,IdHTTP,
      System.Classes, System.Variants,
      IdSSLOpenSSL,IdSSLOpenSSLHeaders,
      System.IOUtils;

type
  TProcess = class
  private
    URLx: String;
    JSONRead: String;
    FBairro: string;
    FCEP: string;
    FCidade: string;
    FRua: string;
    FUF: string;
    FError: string;
    JSONObject: TJSONObject;
    JsonValue: TJSONValue;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetRua(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetError(const Value: string);
  public
    property CEP: string read FCEP write SetCEP;
    property Rua: string read FRua write SetRua;
    property Bairro: string read FBairro write SetBairro;
    property Cidade: string read FCidade write SetCidade;
    property UF: string read FUF write SetUF;
    property Error: string read FError write SetError;
    function SendRequest(const cep:String): TProcess;
    function ClearResult(const Text:String): String;
    function TestServer:Boolean;
    procedure PrepareReq;
  end;

var
  http : TIdHttp;
  objHTTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;

implementation

{ TProcess }

function TProcess.ClearResult(const Text: String): String;
begin
  Result:= StringReplace(Text,'"','',[rfReplaceAll, rfIgnoreCase]);
end;

procedure TProcess.PrepareReq;
begin
  try
    if not(Assigned(objHTTPIOHandler)) then
      objHTTPIOHandler  := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

    if not(Assigned(http)) then
      http:= TIdHttp.Create(nil);

    http.Request.Method                     := 'POST';
    http.Response.KeepAlive                 := True;
    http.Request.UserAgent                  := 'Mozilla/3.0 (compatible; Indy Library)';
    http.Request.Accept                     := 'text/html,application/json,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
    http.HTTPOptions                        := [hoForceEncodeParams];
    http.ConnectTimeout                     := 60 * 1000;
    http.ReadTimeout                        := 5 * 60 * 1000;
    http.Request.ContentType                := 'application/x-www-form-urlencoded';
    http.Request.CharSet                    := 'utf-8';
    http.Request.Connection                 := 'keep-alive';
    http.HandleRedirects                    := True;
    objHTTPIOHandler                        := TIdSSLIOHandlerSocketOpenSSL.Create();
    objHTTPIOHandler.ReadTimeout            := 5 * 60 * 1000;
    objHTTPIOHandler.SSLOptions.Method      := sslvTLSv1_2;
    objHTTPIOHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
    http.IOHandler                          := objHTTPIOHandler;

  except
  end;
end;

function TProcess.SendRequest(const cep: String): TProcess;
begin

    try
       try

          PrepareReq;
          URLx:= 'http://localhost:9000/cep/'+cep;

          if not(Assigned(JSONObject)) then
            JSONObject  := TJSONObject.Create;

          JSONRead:= http.Get(URLx);

          JSONObject  := TJSONObject.ParseJSONValue(JSONRead) as TJSONObject;
          Result      := TProcess.Create;
          Result.Error:= '';
          try
            Result.CEP     := JSONObject.GetValue('cep').ToString;
            Result.Rua     := JSONObject.GetValue('logradouro').ToString;
            Result.Bairro  := JSONObject.GetValue('bairro').ToString;
            Result.Cidade  := JSONObject.GetValue('localidade').ToString;
            Result.UF      := JSONObject.GetValue('uf').ToString;
          except
            try
              Result.CEP     := JSONObject.GetValue('cep').ToString;
              Result.Rua     := JSONObject.GetValue('address_name').ToString;
              Result.Bairro  := JSONObject.GetValue('district').ToString;
              Result.Cidade  := JSONObject.GetValue('city').ToString;
              Result.UF      := JSONObject.GetValue('state').ToString;
            except
              try
                Result.CEP     := JSONObject.GetValue('code').ToString;
                Result.Rua     := JSONObject.GetValue('address').ToString;
                Result.Bairro  := JSONObject.GetValue('district').ToString;
                Result.Cidade  := JSONObject.GetValue('city').ToString;
                Result.UF      := JSONObject.GetValue('state').ToString;
              except
                Result.Error:= 'CEP n�o encontrado.';
              end;
            end;
          end;
       except
          on E: Exception do
            Result.Error:= 'Erro: ' + E.Message
       end;
    finally
      FreeAndNil(JSONObject);
      FreeAndNil(JsonValue);
      FreeAndNil(http);
      FreeAndNil(objHTTPIOHandler);
    end;

end;

procedure TProcess.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TProcess.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TProcess.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TProcess.SetError(const Value: string);
begin
  FError := Value;
end;

procedure TProcess.SetRua(const Value: string);
begin
  FRua := Value;
end;

procedure TProcess.SetUF(const Value: string);
begin
  FUF := Value;
end;

function TProcess.TestServer: Boolean;
begin
    try
      Result:= False;
       try
          PrepareReq;
          URLx:= 'http://localhost:9000/test';

          try
            Result:= http.Get(URLx) = 'ok';
          except
          end;
       except
       end;
    finally
      FreeAndNil(http);
      FreeAndNil(objHTTPIOHandler);
    end;
end;

end.
