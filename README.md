# Desafio Receituário

Quer fazer parte da transformação do campo ~~escrevendo~~ codando o futuro do agronegócio?

Se deseja participar do nosso processo seletivo, siga as instruções deste desafio e execute os seguintes passos: 

* Nos mande sua resolução em um *pull request* neste repositório.


# Sobre a Aliare

A [Aliare](https://www.aliare.co) está entre as maiores empresas de software para agronegócio do país. Nascemos no agro e somos especialistas em levar tecnologia para gestão de empresas e propriedades rurais.

Estamos com nossos clientes, pra fazer o campo acontecer. Temos orgulho de ajudar a construir o presente e o futuro do agronegócio.



# O desafio

Alguns produtos utilizados no campo, são controlados pelo ministério da Agricultura, estes produtos exigem um receituário assinado por um Técnico Agrícola.

Considerando a descrição acima, desenvolva um aplicativo onde o usuário possa realizar uma venda e automaticamente o sistema identifique os produtos que possuem necessidade de emissão de receita. Com os itens necessários para emissão de receita, será criado um registro de solicitação de assinatura vinculado ao técnico selecionado no ato da venda.

## Requisitos 
* Cadastro de clientes:
> Deverá ser criado um cadastro de clientes contendo o nome e CPF do cliente. Este cadastro deverá possuir as validações necessárias para garantir as consistências dos dados.
* Cadastro de técnico agrícola:
> Deverá ser criado apenas uma tabela técnico agrícola contendo o nome, CPF e número de registro, não será necessário criar tela para cadastro dessas informações. O número de registro deverá ser do tipo string. Efetue a carga desta tabela com pelo menos 3 técnicos agrícolas.
* Cadastro de produtos:
> Deverá ser criado uma tela para cadastro de produto onde o cliente informa o nome, valor e se o produto exige controle especial. Implemente as validações necessárias para garantir as consistências de dados.
* Pedido de venda:
> Crie uma tela para realização do pedido de venda, nesta tela o usuário irá informar o cliente para quem está realizando a venda, a data do pedido será preenchida automaticamente com a data atual do sistema. O usuário deverá informar no mínimo 1 produto para efetuar a gravação do pedido de venda. O usuário deverá informar a quantidade do item e o aplicativo deverá calcular automaticamente o total de cada item bem como o total do pedido.
Caso não exista nenhum item na receita que exija controle especial, o aplicativo deverá gravar o pedido com status “Concluído”.
Caso exista produtos com controle especial, o sistema deverá automaticamente criar uma solicitação de receita, informando o pedido, itens que exigem controle especial e o técnico responsável pela assinatura, o pedido deverá ficar com o status “Aguardando Receita”.
Fique livre para desenvolver este controle de solicitação da forma que entender melhor, só cuide para que todos os itens necessários para realização de uma assinatura estejam presentes.
* Solicitação de receita:
> Deverá ser criado uma consulta onde o usuário possa consultar todas as solicitações de receitas pendentes de assinatura. Após localizar as receitas pendentes, o usuário deverá selecionar a solicitação de receita e acionar a opção de “Assinar Receita”. Dessa forma assim que a assinatura for realizada o status do pedido irá mudar para “Pedido concluído”.
  
  Siga abaixo a estrutura de diretórios  já criada para este projeto:
  
![image](https://user-images.githubusercontent.com/28271306/138889763-cfb52e98-4a38-44f0-8cb8-48404732ddd2.png)

	bin: Todos os binários do projeto devem ficar na pasta bin.
	data: Local onde fica o arquivo fdb referente ao banco de dados.
	docs: Neste diretório devem ficar os documentos como scripts para criação da estrutura de tabelas e outros documentos que achar necessário.
	src: Neste diretório deve ficar o código fonte.

## Recomendações

* Utilize [Delphi Community Edition](https://www.embarcadero.com/br/products/delphi/starter);
* Utilize apenas componentes nativos do Delphi Community Edition;
* Para banco de dados utilize Firebird versão 2.1. Pode ser baixado [clicando aqui](http://sourceforge.net/projects/firebird/files/firebird-win32/2.1.7-Release/Firebird-2.1.7.18553_0_Win32.exe/download);
* Utilize boas práticas de codificação, isso será avaliado;
* Desenvolva a aplicação de forma que ela compile facilmente em qualquer equipamento, sem a necessidade de iteração com configurações;
* Mostre que você manja dos paranauê do Delphi;
* Código limpo (clean code), organizado e documentado (quando necessário);
* Use e abuse de:
  * SOLID, GOF, entre outros;
  * Reaproveitamento de código;
  * Criatividade;
  * Performance;
  * Manutenabilidade;
  * Testes Unitários (quando necessário)
  * ... pois avaliaremos tudo isso!
