unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth,
    uSisUsuario, uAcessToken, uSisUsuarioSession, DateUtils,
    uSisProvasJSON, uSisProvas, uSisProvasPerguntas, uSisProvasPerguntasRespostas,
    uSisUsuarioProvas, uSisUsuarioProvasJSON, uSisUsuarioProvasPerguntas,
    uSisUsuarioProvasPerguntasRespostas;

type
  TApiMethods = class(TDSServerModule)
  private
    function GetNewAcessToken(const Prefix: string): string;
    function CalcularAcertos(const IDUsuarioProva, IDProva: Integer;
      const ConsultaSisUsuarioProvas: ISisUsuarioProvas): TJSONObject;
    function PopularJSONProva(
      const ConsultaSisUsuarioProvas: ISisUsuarioProvas): TJSONObject;
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function UpdateLogin(const JObject: TJSONObject): TJSONObject;
    function UpdateUser(const JObject: TJSONObject): TJSONObject;
    function UpdateUsuarioProvas(const JObject: TJSONObject): TJSONObject;
    function UpdateUsuarioProvasPerguntas(const JObject: TJSONObject): TJSONObject;
    function UpdateUsuarioProvasBookMarks(const JObject: TJSONObject): TJSONObject;
    function UpdateUsuarioProvasPerguntasRespostas(const JObject: TJSONObject): TJSONObject;

    function Simulados: TJSONObject;
    function UsuarioProvas(const Usuario, Prova: Integer): TJSONObject;
    function UsuarioProvasPerguntas(const IDUsuarioProva, IDProvaPergunta: Integer): TJSONObject;
    function UsuarioProvasPerguntasMax(const IDUsuarioProva: Integer): TJSONObject;
    function UsuarioProvasPerguntasProx(const Prova, Ordem: Integer): TJSONObject;
    function UsuarioProvasPerguntasRespostas(const IDUsuarioProvaPergunta: Integer): TJSONObject;
    function UsuarioPerguntasCategorias(const IDProva, IDUsuario: Integer): TJSONObject;
    function FinalizarProva(const Usuario, Prova: Integer; const DataHoraFim: string): TJSONObject;
    function ProvasPerguntas(const IDProvaPergunta, IDUsuarioProva: Integer): TJSONObject;
    function PerguntasCategorias(const IDProva: Integer): TJSONObject;
  end;

implementation

{$R *.dfm}

uses System.StrUtils,
     Soap.XSBuiltIns,
     RespostasJSON,
     uSisCategorias,
     uSisPerguntasCategoriasJSON;

function TApiMethods.CalcularAcertos(const IDUsuarioProva, IDProva: Integer;
  const ConsultaSisUsuarioProvas: ISisUsuarioProvas): TJSONObject;
var
  Sis_provas: ISisProvas;
  Item_Sis_provas_perguntas, Sis_provas_perguntas: ISisProvasPerguntas;
  Sis_provas_perguntas_respostas, Item_Sis_provas_perguntas_respostas: ISisProvasPerguntasRespostas;
  Sis_usuario_provas_perguntas: ISisUsuarioProvasPerguntas;
  Sis_usuario_provas_perguntas_respostas: ISisUsuarioProvasPerguntasRespostas;
  QuantidadeRespostasCorretas: Integer;
  RespostasCertas, RespondidasCertas: Integer;
begin
  QuantidadeRespostasCorretas := 0;
  Sis_provas_perguntas := TSisProvasPerguntas.New
                                             .ConsultaIDProva(IDProva)
                                             .Find;
  try
    for Item_Sis_provas_perguntas in Sis_provas_perguntas.ListaISisProvasPerguntas do
    begin
      RespostasCertas := 0;
      RespondidasCertas := 0;
      Sis_usuario_provas_perguntas := TSisUsuarioProvasPerguntas.New
                                                                .ConsultaIDUsuarioProva(IDUsuarioProva)
                                                                .ConsultaIDProvaPergunta(Item_Sis_provas_perguntas.ID)
                                                                .Find;
      try
        Sis_provas_perguntas_respostas := TSisProvasPerguntasRespostas.New
                                                                      .ConsultaIDPergunta(Item_Sis_provas_perguntas.ID)
                                                                      .Find;
        try
          for Item_Sis_provas_perguntas_respostas in Sis_provas_perguntas_respostas.ListaSisProvasPerguntasRespostas do
          begin
            Sis_usuario_provas_perguntas_respostas := TSisUsuarioProvasPerguntasRespostas.New
                                                                                         .ConsultaIDUsuarioProvaPergunta(Sis_usuario_provas_perguntas.ID)
                                                                                         .ConsultaIDProvaPerguntaResposta(Item_Sis_provas_perguntas_respostas.ID)
                                                                                         .Find;
            try
              if (Item_Sis_provas_perguntas_respostas.Certa) then
              begin
                RespostasCertas := RespostasCertas + 1;

                if (Sis_usuario_provas_perguntas_respostas.ID > 0) then
                  RespondidasCertas := RespondidasCertas + 1;
              end;
            finally
              Sis_usuario_provas_perguntas_respostas := nil;
            end;
          end;
        finally
          Sis_provas_perguntas_respostas := nil;
        end;

        if (RespostasCertas = RespondidasCertas) then
        begin
          QuantidadeRespostasCorretas := QuantidadeRespostasCorretas + 1;
          TSisUsuarioProvasPerguntas.New
                                    .ID(Sis_usuario_provas_perguntas.id)
                                    .Acertou(True)
                                    .Update;
        end;
      finally
        Sis_usuario_provas_perguntas := nil;
      end;
    end;

    Result := PopularJSONProva(
      TSisUsuarioProvas.New
                       .ID(ConsultaSisUsuarioProvas.ID)
                       .IDProva(ConsultaSisUsuarioProvas.IDProva)
                       .IDUsuario(ConsultaSisUsuarioProvas.IDUsuario)
                       .DataHoraInicio(ConsultaSisUsuarioProvas.DataHoraInicio)
                       .DataHoraFim(ConsultaSisUsuarioProvas.DataHoraFim)
                       .QuantidadeAcertos(QuantidadeRespostasCorretas)
                       .Update);
  finally
    Sis_provas := nil;
  end;
end;

function TApiMethods.PerguntasCategorias(const IDProva: Integer): TJSONObject;
var
  Item_SisCategorias, SisCategorias: ISisCategorias;
  Item_SisUsuarioProvas, SisUsuarioProvas: ISisUsuarioProvas;
  SisUsuarioProvasPerguntas: ISisUsuarioProvasPerguntas;
  Item_SisProvasPerguntas, SisProvasPerguntas: ISisProvasPerguntas;
  Categoria: TCategorias;
  QuantidadePerguntas, QuantidadeCertas: Integer;
begin
  SisCategorias := TSisCategorias.New
                                 .Find;
  try
    SisUsuarioProvas := TSisUsuarioProvas.New
                                         .ConsultaIDProva(IDProva)
                                         .Find;
    try
      Categoria := TCategorias.Create;
      try
        for Item_SisCategorias in SisCategorias.ListaSisCategorias do
        begin
          QuantidadeCertas := 0;
          SisProvasPerguntas :=
            TSisProvasPerguntas.New
                               .ConsultaIDProva(IDProva)
                               .ConsultaIDCategoria(Item_SisCategorias.ID)
                               .Find;
          try
            QuantidadePerguntas := Length(SisProvasPerguntas.ListaISisProvasPerguntas) * Length(SisUsuarioProvas.ListaSisUsuarioProvas);
            for Item_SisProvasPerguntas in SisProvasPerguntas.ListaISisProvasPerguntas do
            begin
              for Item_SisUsuarioProvas in SisUsuarioProvas.ListaSisUsuarioProvas do
              begin
                SisUsuarioProvasPerguntas :=
                  TSisUsuarioProvasPerguntas.New
                                            .ConsultaIDUsuarioProva(Item_SisUsuarioProvas.ID)
                                            .ConsultaIDProvaPergunta(Item_SisProvasPerguntas.ID)
                                            .Find;
                try
                  if SisUsuarioProvasPerguntas.Acertou then
                    QuantidadeCertas := QuantidadeCertas + 1;
                finally
                  SisUsuarioProvasPerguntas := nil;
                end;
              end;
            end;
          finally
            SisProvasPerguntas := nil;
          end;

          with Categoria.Add do
          begin
            descricao := Item_SisCategorias.Descricao;
            percentual := ((QuantidadeCertas * 100) / QuantidadePerguntas);
          end;
        end;

        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Categoria.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Categoria);
      end;
    finally
      SisUsuarioProvas := nil;
    end;
  finally
    SisCategorias := nil;
  end;
end;

function TApiMethods.PopularJSONProva(const ConsultaSisUsuarioProvas: ISisUsuarioProvas): TJSONObject;
var
  Sis_usuario_provas: TSis_usuario_provasClass;
begin
  Sis_usuario_provas := TSis_usuario_provasClass.Create;
  try
    Sis_usuario_provas.id := ConsultaSisUsuarioProvas.ID;
    Sis_usuario_provas.id_prova := ConsultaSisUsuarioProvas.IDProva;
    Sis_usuario_provas.id_usuario := ConsultaSisUsuarioProvas.IDUsuario;
    Sis_usuario_provas.data_hora_inicio := ConsultaSisUsuarioProvas.DataHoraInicio;
    Sis_usuario_provas.data_hora_fim := ConsultaSisUsuarioProvas.DataHoraFim;
    Sis_usuario_provas.quantidade_acertos := ConsultaSisUsuarioProvas.QuantidadeAcertos;
    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas.ToJsonString), 0) as TJSONObject;
  finally
    FreeAndNil(Sis_usuario_provas);
  end;
end;

function TApiMethods.ProvasPerguntas(const IDProvaPergunta, IDUsuarioProva: Integer): TJSONObject;
var
  ConsultaSisUsuario: ISisUsuario;
  ConsultaSisUsuarioProvas: ISisUsuarioProvas;
  ConsultaSisProvasPerguntasRespostas, ItemSisProvasPerguntasRespostas: ISisProvasPerguntasRespostas;
  ConsultaSisUsuariosProvasPerguntas, ItemSisUsuariosProvasPerguntas: ISisUsuarioProvasPerguntas;
  ConsultaSisUsuariosProvasPerguntasRespostas, ItemSisUsuariosProvasPerguntasRespostas: ISisUsuarioProvasPerguntasRespostas;
  Nome, Questoes: string;
  Respostas: TRespostas;
  RespostasClass: TRespostasClass;
  Compartilhar: Boolean;
begin
  Respostas := TRespostas.Create;
  try
    ConsultaSisUsuariosProvasPerguntas :=
      TSisUsuarioProvasPerguntas.New
                                .ConsultaIDProvaPergunta(IDProvaPergunta)
                                .ConsultaIDUsuarioProva(IDUsuarioProva)
                                .Find;
    try
      for ItemSisUsuariosProvasPerguntas in ConsultaSisUsuariosProvasPerguntas.ListaUsuarioProvasPerguntas do
      begin
        Nome := EmptyStr;
        Questoes := EmptyStr;

        ConsultaSisUsuarioProvas :=
          TSisUsuarioProvas.New
                           .ConsultaID(ItemSisUsuariosProvasPerguntas.IDUsuarioProva)
                           .Find;
        try
          ConsultaSisUsuario :=
            TSisUsuario.New
                       .ConsultaID(ConsultaSisUsuarioProvas.IDUsuario)
                       .Find;
          try
            Nome := ConsultaSisUsuario.Nome;
            Compartilhar := ConsultaSisUsuario.Compartilhar;
          finally
            ConsultaSisUsuario := nil;
          end;
        finally
          ConsultaSisUsuarioProvas := nil;
        end;

        ConsultaSisUsuariosProvasPerguntasRespostas :=
          TSisUsuarioProvasPerguntasRespostas.New
                                             .ConsultaIDUsuarioProvaPergunta(ItemSisUsuariosProvasPerguntas.ID)
                                             .Find;
        try
          for ItemSisUsuariosProvasPerguntasRespostas in ConsultaSisUsuariosProvasPerguntasRespostas.ListaUsuarioProvasPerguntasRespostas do
          begin
            ConsultaSisProvasPerguntasRespostas :=
              TSisProvasPerguntasRespostas.New
                                          .ConsultaID(ItemSisUsuariosProvasPerguntasRespostas.IDProvaPerguntaResposta)
                                          .Find;
            try
              for ItemSisProvasPerguntasRespostas in ConsultaSisProvasPerguntasRespostas.ListaSisProvasPerguntasRespostas do
              begin
                if (Questoes.IsEmpty) then
                  Questoes := ItemSisProvasPerguntasRespostas.Opcao
                else Questoes := Questoes + ',' + ItemSisProvasPerguntasRespostas.Opcao;
              end;
            finally
              ConsultaSisProvasPerguntasRespostas := nil;
            end;
          end;
        finally
          ConsultaSisUsuariosProvasPerguntasRespostas := nil;
        end;

        if (Compartilhar) then
        begin
          RespostasClass := Respostas.Add;
          RespostasClass.nome := Nome;
          RespostasClass.questoes := Questoes;
        end;
      end;
    finally
      ConsultaSisUsuariosProvasPerguntas := nil;
    end;

    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Respostas.ToJsonString), 0) as TJSONObject;
  finally
    FreeAndNil(Respostas);
  end;
end;

function TApiMethods.FinalizarProva(const Usuario, Prova: Integer;
  const DataHoraFim: string): TJSONObject;
var
  ConsultaSisUsuarioProvas: ISisUsuarioProvas;

  function ISODateStrToDate(DateStr: string): TDateTime;
  var
    xsDate: TXSDateTime;
  begin
    xsDate := TXSDateTime.Create;
    try
      xsDate.XSToNative(DateStr);
      Exit(xsDate.AsDateTime);
    finally
      xsDate.Free;
    end;
  end;
begin
  ConsultaSisUsuarioProvas := TSisUsuarioProvas.New
                                               .ConsultaIDUsuario(Usuario)
                                               .ConsultaIDProva(Prova)
                                               .Find;
  try
    if (ConsultaSisUsuarioProvas.DataHoraFim > 0) then
    begin
      Result := PopularJSONProva(ConsultaSisUsuarioProvas);
    end
    else
    begin
      ConsultaSisUsuarioProvas.DataHoraFim(ISODateStrToDate(DataHoraFim))
                              .Update;
      Result := CalcularAcertos(ConsultaSisUsuarioProvas.ID, Prova, ConsultaSisUsuarioProvas);
    end;
  finally
    ConsultaSisUsuarioProvas := nil;
  end;
end;

function TApiMethods.GetNewAcessToken(const Prefix: string): string;
var
  reg: array [1..50] of word;
  I: Integer;
begin
  Result := '';
  DecodeDate(Date,reg[1],reg[2],reg[3]);
  reg[1] := StrToInt(Copy(IntToStr(reg[1]),3,2));
  DecodeTime(Time,reg[4],reg[5],reg[6],reg[7]);
  reg[7] := reg[7] div 4;
  randomize;
  for i := 1 to 50 do
  begin
    if (i >= 2) and (i <= 49) then
      reg[i] := reg[i]+random(100);

    Result := Result+IntToHex(reg[i],2);
  end;

  Result := Prefix + Result;
end;

function TApiMethods.UsuarioPerguntasCategorias(const IDProva, IDUsuario: Integer): TJSONObject;
var
  Item_SisCategorias, SisCategorias: ISisCategorias;
  SisUsuarioProvas: ISisUsuarioProvas;
  SisUsuarioProvasPerguntas: ISisUsuarioProvasPerguntas;
  Item_SisProvasPerguntas, SisProvasPerguntas: ISisProvasPerguntas;
  Categoria: TCategorias;
  QuantidadePerguntas, QuantidadeCertas: Integer;
begin
  SisCategorias := TSisCategorias.New
                                 .Find;
  try
    SisUsuarioProvas := TSisUsuarioProvas.New
                                         .ConsultaIDProva(IDProva)
                                         .ConsultaIDUsuario(IDUsuario)
                                         .Find;
    try
      Categoria := TCategorias.Create;
      try
        for Item_SisCategorias in SisCategorias.ListaSisCategorias do
        begin
          QuantidadeCertas := 0;
          SisProvasPerguntas :=
            TSisProvasPerguntas.New
                               .ConsultaIDProva(IDProva)
                               .ConsultaIDCategoria(Item_SisCategorias.ID)
                               .Find;
          try
            QuantidadePerguntas := Length(SisProvasPerguntas.ListaISisProvasPerguntas);
            for Item_SisProvasPerguntas in SisProvasPerguntas.ListaISisProvasPerguntas do
            begin
              SisUsuarioProvasPerguntas :=
                TSisUsuarioProvasPerguntas.New
                                          .ConsultaIDUsuarioProva(SisUsuarioProvas.ID)
                                          .ConsultaIDProvaPergunta(Item_SisProvasPerguntas.ID)
                                          .Find;
              try
                if SisUsuarioProvasPerguntas.Acertou then
                  QuantidadeCertas := QuantidadeCertas + 1;
              finally
                SisUsuarioProvasPerguntas := nil;
              end;
            end;
          finally
            SisProvasPerguntas := nil;
          end;

          with Categoria.Add do
          begin
            descricao := Item_SisCategorias.Descricao;
            percentual := ((QuantidadeCertas * 100) / QuantidadePerguntas);
          end;
        end;

        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Categoria.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Categoria);
      end;
    finally
      SisUsuarioProvas := nil;
    end;
  finally
    SisCategorias := nil;
  end;
end;

function TApiMethods.UsuarioProvas(const Usuario, Prova: Integer): TJSONObject;
var
  Sis_usuario_provas: TSis_usuario_provasClass;
  ConsultaSisUsuarioProvas: ISisUsuarioProvas;
begin
  ConsultaSisUsuarioProvas := TSisUsuarioProvas.New
                                               .ConsultaIDUsuario(Usuario)
                                               .ConsultaIDProva(Prova)
                                               .Find;
  try
    if (ConsultaSisUsuarioProvas.ID > 0) then
    begin
      Sis_usuario_provas := TSis_usuario_provasClass.Create;
      try
        Sis_usuario_provas.id := ConsultaSisUsuarioProvas.ID;
        Sis_usuario_provas.id_prova := ConsultaSisUsuarioProvas.IDProva;
        Sis_usuario_provas.id_usuario := ConsultaSisUsuarioProvas.IDUsuario;
        Sis_usuario_provas.data_hora_inicio := ConsultaSisUsuarioProvas.DataHoraInicio;
        Sis_usuario_provas.data_hora_fim := ConsultaSisUsuarioProvas.DataHoraFim;
        Sis_usuario_provas.quantidade_acertos := ConsultaSisUsuarioProvas.QuantidadeAcertos;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_usuario_provas);
      end;
    end
    else
    begin
      Sis_usuario_provas := TSis_usuario_provasClass.Create;
      try
        Sis_usuario_provas.id_prova := Prova;
        Sis_usuario_provas.id_usuario := Usuario;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_usuario_provas);
      end;
    end;
  finally
    ConsultaSisUsuarioProvas := nil;
  end;
end;

function TApiMethods.UsuarioProvasPerguntas(const IDUsuarioProva, IDProvaPergunta: Integer): TJSONObject;
var
  Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
  ConsultaSisUsuarioProvasPerguntas: ISisUsuarioProvasPerguntas;
begin
  ConsultaSisUsuarioProvasPerguntas := TSisUsuarioProvasPerguntas.New
                                                                 .ConsultaIDUsuarioProva(IDUsuarioProva)
                                                                 .ConsultaIDProvaPergunta(IDProvaPergunta)
                                                                 .Find;
  try
    if (ConsultaSisUsuarioProvasPerguntas.ID > 0) then
    begin
      Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.Create;
      try
        Sis_usuario_provas_perguntas.id := ConsultaSisUsuarioProvasPerguntas.ID;
        Sis_usuario_provas_perguntas.id_usuario_prova := ConsultaSisUsuarioProvasPerguntas.IDUsuarioProva;
        Sis_usuario_provas_perguntas.id_prova_pergunta := ConsultaSisUsuarioProvasPerguntas.IDProvaPergunta;
        Sis_usuario_provas_perguntas.ordem := ConsultaSisUsuarioProvasPerguntas.Ordem;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas_perguntas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_usuario_provas_perguntas);
      end;
    end
    else
    begin
      Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.Create;
      try
        Sis_usuario_provas_perguntas.id := ConsultaSisUsuarioProvasPerguntas.ID;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas_perguntas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_usuario_provas_perguntas);
      end;
    end;
  finally
    ConsultaSisUsuarioProvasPerguntas := nil;
  end;
end;

function TApiMethods.UsuarioProvasPerguntasMax(const IDUsuarioProva: Integer): TJSONObject;
var
  Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
  ConsultaSisUsuarioProvasPerguntas: ISisUsuarioProvasPerguntas;
begin
  ConsultaSisUsuarioProvasPerguntas := TSisUsuarioProvasPerguntas.New
                                                                 .ConsultaIDUsuarioProva(IDUsuarioProva)
                                                                 .Find;
  try
    if (ConsultaSisUsuarioProvasPerguntas.ID > 0) then
    begin
      Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.Create;
      try
        Sis_usuario_provas_perguntas.id := ConsultaSisUsuarioProvasPerguntas.ID;
        Sis_usuario_provas_perguntas.id_usuario_prova := ConsultaSisUsuarioProvasPerguntas.IDUsuarioProva;
        Sis_usuario_provas_perguntas.id_prova_pergunta := ConsultaSisUsuarioProvasPerguntas.IDProvaPergunta;
        Sis_usuario_provas_perguntas.ordem := ConsultaSisUsuarioProvasPerguntas.Ordem;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas_perguntas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_usuario_provas_perguntas);
      end;
    end
    else
    begin
      Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.Create;
      try
        Sis_usuario_provas_perguntas.id := ConsultaSisUsuarioProvasPerguntas.ID;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas_perguntas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_usuario_provas_perguntas);
      end;
    end;
  finally
    ConsultaSisUsuarioProvasPerguntas := nil;
  end;
end;

function TApiMethods.UsuarioProvasPerguntasProx(
  const Prova, Ordem: Integer): TJSONObject;
var
  Sis_provas_perguntas: TSis_provas_perguntasClass;
  SisProvasPerguntas: ISisProvasPerguntas;
  SisProvasPerguntasRespostas: ISisProvasPerguntasRespostas;
begin
  SisProvasPerguntas := TSisProvasPerguntas.New
                                           .ConsultaIDProva(Prova)
                                           .ConsultaOrdem(Ordem)
                                           .Find;
  try
    if (SisProvasPerguntas.ID > 0) then
    begin
      Sis_provas_perguntas := TSis_provas_perguntasClass.Create;
      try
        Sis_provas_perguntas.id := SisProvasPerguntas.ID;
        Sis_provas_perguntas.id_prova := SisProvasPerguntas.IDProva;
        Sis_provas_perguntas.pergunta := SisProvasPerguntas.Pergunta;
        Sis_provas_perguntas.ordem := Ordem;
        Sis_provas_perguntas.categoria := TSisCategorias.New
                                                        .ConsultaID(SisProvasPerguntas.IDCategoria)
                                                        .Find
                                                        .Descricao;
        for SisProvasPerguntasRespostas in SisProvasPerguntas.ListaSisProvasPerguntasRespostas do
        begin
          with Sis_provas_perguntas.Add do
          begin
            id := SisProvasPerguntasRespostas.ID;
            id_pergunta := SisProvasPerguntasRespostas.IDPergunta;
            resposta := SisProvasPerguntasRespostas.Resposta;
            opcao := SisProvasPerguntasRespostas.Opcao;
            certa := SisProvasPerguntasRespostas.Certa;
          end;
        end;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_provas_perguntas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_provas_perguntas);
      end;
    end
    else
    begin
      Sis_provas_perguntas := TSis_provas_perguntasClass.Create;
      try
        Sis_provas_perguntas.ordem := Ordem;
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_provas_perguntas.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(Sis_provas_perguntas);
      end;
    end;
  finally
    SisProvasPerguntas := nil;
  end;
end;

function TApiMethods.UsuarioProvasPerguntasRespostas(
  const IDUsuarioProvaPergunta: Integer): TJSONObject;
var
  Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
  ConsultaSisUsuarioProvasPerguntas: ISisUsuarioProvasPerguntas;
  ConsultaSisUsuarioProvasPerguntasRespostas, ListaUsuarioProvasPerguntasRespostas: ISisUsuarioProvasPerguntasRespostas;
begin
  ConsultaSisUsuarioProvasPerguntasRespostas :=
    TSisUsuarioProvasPerguntasRespostas.New
                                       .ConsultaIDUsuarioProvaPergunta(IDUsuarioProvaPergunta)
                                       .Find;
  try
    Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.Create;
    try
      Sis_usuario_provas_perguntas.id := IDUsuarioProvaPergunta;
      ConsultaSisUsuarioProvasPerguntas :=
        TSisUsuarioProvasPerguntas.New
                                  .ConsultaID(IDUsuarioProvaPergunta)
                                  .Find;
      try
        Sis_usuario_provas_perguntas.id_prova_pergunta :=
          ConsultaSisUsuarioProvasPerguntas.IDProvaPergunta;
        Sis_usuario_provas_perguntas.id_usuario_prova :=
          ConsultaSisUsuarioProvasPerguntas.IDUsuarioProva;
        Sis_usuario_provas_perguntas.ordem :=
          ConsultaSisUsuarioProvasPerguntas.Ordem;
      finally
        ConsultaSisUsuarioProvasPerguntas := nil;
      end;

      for ListaUsuarioProvasPerguntasRespostas in ConsultaSisUsuarioProvasPerguntasRespostas.ListaUsuarioProvasPerguntasRespostas do
      begin
        with Sis_usuario_provas_perguntas.AddSis_usuario_provas_perguntas_respostas do
        begin
          id := ListaUsuarioProvasPerguntasRespostas.ID;
          id_usuario_prova_pergunta := ListaUsuarioProvasPerguntasRespostas.IDUsuarioProvaPergunta;
          id_prova_pergunta_resposta := ListaUsuarioProvasPerguntasRespostas.IDProvaPerguntaResposta;
        end;
      end;

      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas_perguntas.ToJsonString), 0) as TJSONObject;
    finally
      FreeAndNil(Sis_usuario_provas_perguntas);
    end;
  finally
    ConsultaSisUsuarioProvasPerguntasRespostas := nil;
  end;
end;

function TApiMethods.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TApiMethods.UpdateUsuarioProvasBookMarks(const JObject: TJSONObject): TJSONObject;
begin
  Result := nil;
end;

function TApiMethods.UpdateLogin(const JObject: TJSONObject): TJSONObject;
var
  EMail, Senha, AcessToken: string;
  ID: Integer;
  AccessToken: TAcessToken;
begin
  try
    EMail := JObject.Values['email'].Value;
    Senha := JObject.Values['senha'].Value;
    ID := TSisUsuario.New
                     .ConsultaEmail(EMail)
                     .Find
                     .ID;
    if (ID > 0) then
    begin
      ID := TSisUsuario.New
                       .ConsultaEmail(EMail)
                       .ConsultaSenha(Senha)
                       .Find
                       .ID;
      if (ID > 0) then
      begin
        AcessToken := GetNewAcessToken('AT');
        TSisUsuarioSession.New
                          .TokenType('Bearer')
                          .ExpiresIn(7200)
                          .Data(Now)
                          .AccessToken(AcessToken)
                          .IDUsuario(ID)
                          .Insert;

        AccessToken := TAcessToken.Create;
        try
          AccessToken.access_token := AcessToken;
          AccessToken.expires_in := 7200;
          AccessToken.token_type := 'Bearer';
          AccessToken.id := ID;
          Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AccessToken.ToJsonString), 0) as TJSONObject; //AccessToken.ToJsonString;
        finally
          FreeAndNil(AccessToken);
        end;
      end
      else
      begin
        AccessToken := TAcessToken.Create;
        try
          AccessToken.email_password := 'P';
          Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AccessToken.ToJsonString), 0) as TJSONObject;
        finally
          FreeAndNil(AccessToken);
        end;
      end;
    end
    else
    begin
      AccessToken := TAcessToken.Create;
      try
        AccessToken.email_password := 'E';
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AccessToken.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(AccessToken);
      end;
    end;
  except
    on E: Exception do
    begin
      AccessToken := TAcessToken.Create;
      try
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AccessToken.ToJsonString), 0) as TJSONObject;
      finally
        FreeAndNil(AccessToken);
      end;
    end;
  end;
end;

function TApiMethods.UpdateUsuarioProvasPerguntas(const JObject: TJSONObject): TJSONObject;
var
  Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
  SisUsuarioProvasPerguntas: ISisUsuarioProvasPerguntas;
begin
  Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.FromJsonString(JObject.ToJSON);
  try
    try
      SisUsuarioProvasPerguntas := TSisUsuarioProvasPerguntas.New
                                                             .IDUsuarioProva(Trunc(Sis_usuario_provas_perguntas.id_usuario_prova))
                                                             .IDProvaPergunta(Trunc(Sis_usuario_provas_perguntas.id_prova_pergunta))
                                                             .Ordem(Sis_usuario_provas_perguntas.ordem)
                                                             .Insert;

      Sis_usuario_provas_perguntas.id := SisUsuarioProvasPerguntas.ID;
      Sis_usuario_provas_perguntas.id_usuario_prova := SisUsuarioProvasPerguntas.IDUsuarioProva;
      Sis_usuario_provas_perguntas.id_prova_pergunta := SisUsuarioProvasPerguntas.IDProvaPergunta;
      Sis_usuario_provas_perguntas.ordem := SisUsuarioProvasPerguntas.Ordem;

      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas_perguntas.ToJsonString), 0) as TJSONObject;
    finally
      SisUsuarioProvasPerguntas := nil;
    end;
  finally
    FreeAndNil(Sis_usuario_provas_perguntas);
  end;
end;

function TApiMethods.UpdateUsuarioProvas(const JObject: TJSONObject): TJSONObject;
var
  Sis_usuario_provas: TSis_usuario_provasClass;
  SisUsuarioProvas: ISisUsuarioProvas;
begin
  Sis_usuario_provas := TSis_usuario_provasClass.FromJsonString(JObject.ToJSON);
  try
    try
      if (Sis_usuario_provas.ID > 0) then
      begin
        SisUsuarioProvas := TSisUsuarioProvas.New
                                             .QuantidadeAcertos(Trunc(Sis_usuario_provas.quantidade_acertos))
                                             .DataHoraFim(Sis_usuario_provas.data_hora_fim)
                                             .Update;
      end
      else
      begin
        SisUsuarioProvas := TSisUsuarioProvas.New
                                             .IDUsuario(Trunc(Sis_usuario_provas.id_usuario))
                                             .IDProva(Trunc(Sis_usuario_provas.id_prova))
                                             .DataHoraInicio(Sis_usuario_provas.data_hora_inicio)
                                             .Insert;
      end;

      Sis_usuario_provas.id := SisUsuarioProvas.ID;
      Sis_usuario_provas.data_hora_inicio := SisUsuarioProvas.DataHoraInicio;
      Sis_usuario_provas.data_hora_fim := SisUsuarioProvas.DataHoraFim;
      Sis_usuario_provas.quantidade_acertos := SisUsuarioProvas.QuantidadeAcertos;

      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas.ToJsonString), 0) as TJSONObject;
    finally
      SisUsuarioProvas := nil;
    end;
  finally
    FreeAndNil(Sis_usuario_provas);
  end;
end;

function TApiMethods.UpdateUsuarioProvasPerguntasRespostas(const JObject: TJSONObject): TJSONObject;
var
  Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
  Sis_usuario_provas_perguntas_respostas: TSis_usuario_provas_perguntas_respostasClass;
  SisUsuarioProvasPerguntasRespostas: ISisUsuarioProvasPerguntasRespostas;
begin
  Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.FromJsonString(JObject.ToJSON);
  try
    for Sis_usuario_provas_perguntas_respostas in Sis_usuario_provas_perguntas.Sis_usuario_provas_perguntas_respostas do
    begin
      try
        SisUsuarioProvasPerguntasRespostas :=
          TSisUsuarioProvasPerguntasRespostas.New
                                             .IDUsuarioProvaPergunta(Trunc(Sis_usuario_provas_perguntas_respostas.id_usuario_prova_pergunta))
                                             .IDProvaPerguntaResposta(Trunc(Sis_usuario_provas_perguntas_respostas.id_prova_pergunta_resposta))
                                             .Insert;
         Sis_usuario_provas_perguntas_respostas.id := SisUsuarioProvasPerguntasRespostas.ID;
      finally
        SisUsuarioProvasPerguntasRespostas := nil;
      end;
    end;

    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Sis_usuario_provas_perguntas.ToJsonString), 0) as TJSONObject;
  finally
    FreeAndNil(Sis_usuario_provas_perguntas);
  end;
end;

function TApiMethods.UpdateUser(const JObject: TJSONObject): TJSONObject;
var
  Nome, EMail, Senha: string;
  Compartilhar: Boolean;
  SisUsuario: ISisUsuario;
begin
  Result := nil;
  EMail := JObject.Values['email'].Value;
  Senha := JObject.Values['senha'].Value;
  if Assigned(JObject.Values['nome']) then
  begin
    Compartilhar := JObject.Values['compartilhar'].AsType<Boolean>;
    Nome := JObject.Values['nome'].Value;
    if (TSisUsuario.New
                   .ConsultaEmail(EMail)
                   .Find
                   .ID > 0) then
    begin
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes('{"success": false, "message": "E-Mail já cadastrado."}'), 0) as TJSONObject;
    end
    else if (TSisUsuario.New
                        .ConsultaNome(Nome)
                        .Find
                        .ID > 0) then
    begin
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes('{"success": false, "message": "Nome já cadastrado."}'), 0) as TJSONObject;
    end
    else
    begin
      if (TSisUsuario.New
                 .Nome(Nome)
                 .Email(EMail)
                 .Senha(Senha)
                 .Compartilhar(Compartilhar)
                 .Insert
                 .ID > 0) then
      begin
        Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes('{"success": true, "message": "Cadastro efetuado com sucesso."}'), 0) as TJSONObject;
      end;
    end;
  end
  else
  begin
    SisUsuario :=
      TSisUsuario.New
                 .ConsultaEmail(EMail)
                 .ConsultaSenha(Senha)
                 .Find;
    try
      Result :=
        TJSONObject.ParseJSONValue(
          TEncoding.ASCII.GetBytes(
            '{"nome": "' +
            SisUsuario.Nome + '",' +
            '"adm":' + ifThen(SisUsuario.Adm, '"True"', '"False"') + '}'), 0) as TJSONObject;
    finally
      SisUsuario := nil;
    end;
  end;
end;

function TApiMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TApiMethods.Simulados: TJSONObject;
var
  Provas: TProvas;
  SisProvas: ISisProvas;
  SisProvasPerguntas: ISisProvasPerguntas;
  SisProvasPerguntasRespostas: ISisProvasPerguntasRespostas;
  lOrdem: Integer;
begin
  lOrdem := 1;
  SisProvas := TSisProvas.New
                         .Find;
  try
    Provas := TProvas.Create;
    try
      with Provas.Add.sis_prova do
      begin
        id := SisProvas.ID;
        descricao := SisProvas.Descricao;
        tempo := SisProvas.Tempo;
        for SisProvasPerguntas in SisProvas.ListaSisProvasPerguntas do
        begin
          with Add do
          begin
            id := SisProvasPerguntas.ID;
            id_prova := SisProvasPerguntas.IDProva;
            pergunta := SisProvasPerguntas.Pergunta;
            ordem := lOrdem;
            Inc(lOrdem);
            for SisProvasPerguntasRespostas in SisProvasPerguntas.ListaSisProvasPerguntasRespostas do
            begin
              with Add do
              begin
                id := SisProvasPerguntasRespostas.ID;
                id_pergunta := SisProvasPerguntasRespostas.IDPergunta;
                resposta := SisProvasPerguntasRespostas.Resposta;
                opcao := SisProvasPerguntasRespostas.Opcao;
                certa := SisProvasPerguntasRespostas.Certa;
              end;
            end;
          end;
        end;
      end;

      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Provas.ToJsonString), 0) as TJSONObject;
    finally
      FreeAndNil(Provas);
    end;
  finally
    SisProvas := nil;
  end;
end;

end.

