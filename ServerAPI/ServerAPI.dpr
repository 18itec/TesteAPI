program ServerAPI;
{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  System.SysUtils,
  IdHTTP,IdSSLOpenSSL,IdSSLOpenSSLHeaders;

var
  HTTP: TIdHttp;
  objHTTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  JSONRead,
  URL_ViaCEP,
  URL_APICEP,
  UR_AWS,
  CEP: String;

begin

  {$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

    THorse.Get('/test',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('ok');
    end);

  THorse.Get('/cep/:id',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin

      CEP         := Req.Params.Field('id').AsString;
      URL_ViaCEP  :='https://viacep.com.br/ws/'+CEP+'/json/';
      URL_APICEP  :='https://cdn.apicep.com/file/apicep/'+CEP+'.json';
      UR_AWS      :='https://cep.awesomeapi.com.br/json/'+CEP;

      try

        if not(Assigned(objHTTPIOHandler)) then
          objHTTPIOHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(nil);

        if not(Assigned(http)) then
          HTTP:= TIdHttp.Create(nil);

        HTTP.Request.UserAgent                  := 'Mozilla/3.0 (compatible; Indy Library)';
        HTTP.Request.Accept                     := 'json,application';
        HTTP.Request.CharSet                    := 'utf-8';
        objHTTPIOHandler                        := TIdSSLIOHandlerSocketOpenSSL.Create();
        objHTTPIOHandler.SSLOptions.Method      := sslvTLSv1_2;
        objHTTPIOHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
        HTTP.IOHandler                          := objHTTPIOHandler;
        HTTP.Request.Method                     := 'GET';

        try
          JSONRead:= HTTP.Get(URL_ViaCEP);
        except
          try
            JSONRead:= HTTP.Get(URL_APICEP);
          except
            try
              JSONRead:= HTTP.Get(UR_AWS);
            except
              JSONRead:= '{"Msg": "It is not possible to consult the zip code."}';
            end;
          end;
        end;

        if (HTTP.ResponseCode = 200) then
          Res.Send(JSONRead)
        else
          Res.Send('"Error": "Status Code: '+IntToStr(HTTP.ResponseCode)+'"}');
          Writeln('Status code response: '+IntToStr(HTTP.ResponseCode)+' to the query: '+CEP);
      finally
        FreeAndNil(HTTP);
        FreeAndNil(objHTTPIOHandler);
      end;

    end);
  THorse.Listen(9000,
    procedure
    begin
      Writeln(Format('Server is runing on %s:%d', [THorse.Host, THorse.Port]));
      Readln;
    end);

end.
