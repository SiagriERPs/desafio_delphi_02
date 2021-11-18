# Desafio Trade

Quer fazer parte da transformação do campo ~~escrevendo~~ codando o futuro do agronegócio?

Se deseja participar do nosso processo seletivo, siga as instruções deste desafio e execute os seguintes passos: 

* Nos mande sua resolução em um *pull request* neste repositório.


# Sobre a Aliare

A [Aliare](https://www.aliare.co) está entre as maiores empresas de software para agronegócio do país. Nascemos no agro e somos especialistas em levar tecnologia para gestão de empresas e propriedades rurais.

Estamos com nossos clientes, pra fazer o campo acontecer. Temos orgulho de ajudar a construir o presente e o futuro do agronegócio.



# O desafio

Um determinado produtor necessita armazenar a sua produção de soja deste ano. Sendo assim este produtor irá realizar um contrato de venda para uma trade que será responsável por armazenar os grãos em seus silos.

Basicamente no contrato de venda identificamos o produtor, a trade, o grão que será negociado e a quantidade. Cada contrato deve permitir a negociação de apenas um tipo de grão.
	
Uma trade pode possuir mais de um silo para armazenagem que geralmente tem a capacidade de armazenamento de 90.000 kg de grãos, independente do grão armazenado.
	
Desenvolva um aplicativo que seja possível gerenciar os contratos de vendas realizados entre o produtor e a trade, de forma que na gravação do contrato o sistema faça a distribuição automática dos grãos nos silos da trade. 
  
Cuidado com o limite de cada silo e suas validações básicas.
  
	O aplicativo deve permitir filtrar os contratos informando o CNPJ do produtor ou da trade.
	O aplicativo deve permitir gerenciar vários contratos de venda, de várias trades e produtores diferentes.
	O aplicativo deve permitir imprimir um relatório contendo todos os contratos cadastrados informando o nome do produto, nome da trade, o grão do contrato e a quantidade armazenada em kg.
  
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
