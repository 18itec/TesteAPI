# TesteAPIDelphi

TesteAPIDelphi

Introdução:

O sistema tem como objetivo fornecer informações detalhadas sobre endereços a partir de CEPs, utilizando uma API externa desenvolvida utilizando HORSE.

Público-alvo: Usuários finais do sistema ou internos e externos.

Requisitos: Para se utilizar deste software é necessário conexão com internet.

Funcionais:
O cliente informa um CEP.
Ao clicar em "Consultar", o sistema envia uma requisição à API.
A API retorna as informações do CEP.
O sistema exibe as informações na interface do cliente.

Não-funcionais:
Desempenho: Tempo de resposta esperado para a consulta é de aproximadamente 2 segundos, dependendo da conexão de internet.

Segurança: Como se trata de um projeto onde não há conexões com bancos de dados e se trata de informações publicas e abertas na internet, não foram implementadas nenhum dispositivo de segurança como autenticação para o consumo da API, utilização de certificado SSL.

Disponibilidade: A disponibilidade fica a cargo do tempo das APIs externas que são consumidas, bem como a disponibilidade do servidor local.

Manutenibilidade: Facilidade de realizar alterações e correções no sistema, pois se trata de um sistema bem simples.

Arquitetura do Sistema: Aplicação Servidor e Aplicação Cliente;

Tecnologias Utilizadas: Delphi 11, Indy, Horse (para acesso à API), componentes visuais utilizados VCL.

Implementação:

Servidor:
Descrição da arquitetura do servidor (Delphi 11, Horse).

Implementação da API HORSE: Endpoint para consulta de CEP e status do servidor local, métodos HTTP via POST e GET, os dados são retornados via JSON.

Cliente:
Descrição da interface do usuário: Consiste em um campo informando se o Servidor está on-line, um campo para informar o CEP, um botão para efetuar a consulta e um campo para o retorno com os detalhes do CEP informado.

Lógica de comunicação com o servidor: As requisições são enviadas via metodos GET e POST sem body e as respostas são processadas com JSON.

Tratamento de erros: Os erros são capturados e exibidos ao usuário na tela principal no campo de resposta.

Testes: Infelismente não foram efetuados os testes, visto que minha versão do Delphi não contempla o DUNIT.

Manual do Usuário: Para utilizar o sistema, execute a Aplicação "ServerAPI.exe" e possteriormente abra o "ClienteAPI.exe", Informe o CEP desejado e aguarde a resposta.

Interface do Usuário: Apresenta um campo para digitação do CEP e um botão "Consultar".

Lógica de Negócios: Ao clicar no botão, realiza uma requisição HTTP para a API HORSE, passando o CEP informado como parâmetro, que por sua vez utiliza APIs de terceiros para consultar o CEP informado.

Tratamento da Resposta: Analisa a resposta da API e exibe as informações detalhadas do CEP caso seja localizado.

Desenvolvido por
Heber Cinti
(18)99752-8707
