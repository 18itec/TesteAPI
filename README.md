# TesteAPIDelphi

TesteAPIDelphi

Introdu��o:

O sistema tem como objetivo fornecer informa��es detalhadas sobre endere�os a partir de CEPs, utilizando uma API externa desenvolvida utilizando HORSE.

P�blico-alvo: Usu�rios finais do sistema ou internos e externos.

Requisitos: Para se utilizar deste software � necess�rio conex�o com internet.

Funcionais:
O cliente informa um CEP.
Ao clicar em "Consultar", o sistema envia uma requisi��o � API.
A API retorna as informa��es do CEP.
O sistema exibe as informa��es na interface do cliente.

N�o-funcionais:
Desempenho: Tempo de resposta esperado para a consulta � de aproximadamente 2 segundos, dependendo da conex�o de internet.

Seguran�a: Como se trata de um projeto onde n�o h� conex�es com bancos de dados e se trata de informa��es publicas e abertas na internet, n�o foram implementadas nenhum dispositivo de seguran�a como autentica��o para o consumo da API, utiliza��o de certificado SSL.

Disponibilidade: A disponibilidade fica a cargo do tempo das APIs externas que s�o consumidas, bem como a disponibilidade do servidor local.

Manutenibilidade: Facilidade de realizar altera��es e corre��es no sistema, pois se trata de um sistema bem simples.

Arquitetura do Sistema: Aplica��o Servidor e Aplica��o Cliente;

Tecnologias Utilizadas: Delphi 11, Indy, Horse (para acesso � API), componentes visuais utilizados VCL.

Implementa��o:

Servidor:
Descri��o da arquitetura do servidor (Delphi 11, Horse).

Implementa��o da API HORSE: Endpoint para consulta de CEP e status do servidor local, m�todos HTTP via POST e GET, os dados s�o retornados via JSON.

Cliente:
Descri��o da interface do usu�rio: Consiste em um campo informando se o Servidor est� on-line, um campo para informar o CEP, um bot�o para efetuar a consulta e um campo para o retorno com os detalhes do CEP informado.

L�gica de comunica��o com o servidor: As requisi��es s�o enviadas via metodos GET e POST sem body e as respostas s�o processadas com JSON.

Tratamento de erros: Os erros s�o capturados e exibidos ao usu�rio na tela principal no campo de resposta.

Testes: Infelismente n�o foram efetuados os testes, visto que minha vers�o do Delphi n�o contempla o DUNIT.

Manual do Usu�rio: Para utilizar o sistema, execute a Aplica��o "ServerAPI.exe" e possteriormente abra o "ClienteAPI.exe", Informe o CEP desejado e aguarde a resposta.

Interface do Usu�rio: Apresenta um campo para digita��o do CEP e um bot�o "Consultar".

L�gica de Neg�cios: Ao clicar no bot�o, realiza uma requisi��o HTTP para a API HORSE, passando o CEP informado como par�metro, que por sua vez utiliza APIs de terceiros para consultar o CEP informado.

Tratamento da Resposta: Analisa a resposta da API e exibe as informa��es detalhadas do CEP caso seja localizado.

Desenvolvido por
Heber Cinti
(18)99752-8707
