19:26 23/08/2020 

## Caderno MySQL

__________________________________
### Aula 1 - O que é um banco de dados?

#### Origem dos bancos de dados

- Década de 50 - primeiros computadores: acadêmicos e militares. Dados eram armazenados em papel, estilo ficha.

- Teoria do banco de dados
  - Registro: "ficha", folha com as informações
  - Tabelas: "pasta", conjunto de fichas
  -  Arquivos: "armário", guarda pastas

"Arquivos guardam tabelas e tabelas guardam registros"

- Década de 60 em diante - digitalização das informações 

	- Registros guardados sequencialmente (um após o outro), de maneira arcaica. (Arquivos sequenciais)
	- Memória física era de leitura sequencial: cartões perfurados e fitas magnéticas. Para ler o registro 5, deve-se passar pelos 4 anteriores.
	- Discos surgiram depois das fitas. Guardam de forma direta, não sequencial, dá para acessar qualquer parte instantaneamente.
	- Os arquivos evoluíram e adotaram os índices (arquivos de acesso direto)

- Departamento de Defesa dos EUA: CODASYL
  - Surge a linguagem Cobol: a primeira que se preocupou com a lógica de programação e com os dados nela.
  - Discussão acerca de uma nova tecnologia: banco de dados
    	

#### Banco de dados

- Base de dados; sistema gerenciador (SGBD/DMS); linguagem de exploração (para acesso ao dado); programas adicionais (gerência de usuários, otimizador)
- IBM: propôs a ideia de dados hierárquicos (Modelo Hierárquico); dados em rede (Modelo em Rede). Problema: não facilitava o relacionamento dos dados.
- Década de 70 - novo modelo: Edgar Codd (IBM). Ligações mais intrínsecas que hierarquia ou rede, agora é relação. (Modelo Relacional)

##### Modelo Relacional

- A partir de um registro armazenado, dá para caminhar por outros, desde que tenha relação. Ex.: históricos de compras de um cliente - estoque da empresa - estoque do fornecedor.

  - Linguagem de exploração: para construir o banco de dados e estabelecer as relações das tabelas e registros.
  - SQL (Structured Query Language), antigo SEQUEL
  - Query: resposta, solicitação

- Ideia inicial: SQL seria universal, mas as empresas despadronizaram seus bancos de dados. Órgãos de padronização ANSI e ISO (ambos dos EUA) recomendaram métricas
- Oracle, IBM, dBase (acabou), Microsoft SQL Server, MySQL

---
### Aula 2 MySQL

- Surgiu em 1994 na Suécia. Projeto livre, registrado como GPL (General Public License). Grátis e aberto ao mesmo tempo.
- Sun Microsystems (a mesma que criou o Java), em 2007, comprou o projeto.
- Oracle compra a Sun em 2009.
- MariaDB é um fork do MySQL, administrada por um dos criadores do MySQL 
- **Partes**: 
  - DDL (Definição, construção): `create database`, `create table`, `alter table`, `drop table`
  - DML (Manipulação, alteração): `insert into`, `update`, `delete`, `truncate`
  - DQL (Solicitações)
  - DCL (Controle, acesso de usuários)
  - DTL (Transações)
- data manipulation language

---

4 princípios das transações: Durabilidade (conforme o desejo do programador), Isolamento (transações simultâneas não interferem), Consistência (não dar erro, estar OK), Atomicidade (ou tudo dá certo, ou retorna ao estado anterior consistente) [DICA]


---
Instalação: 

- [x] Baixar o MySQL Workbench (grosso modo, um editor de código) 
- [x] e o Xampp.

---

### Aula 3 - Criando o primeiro Banco de Dados

- Registrar instâncias separadas de coisas que têm características semelhantes
- Características != valores
- Containers diferentes para coisas diferentes (as características diferentes)
  - Pessoas, jogos
- Banco de dados possui várias <u>tabelas</u>, estas têm <u>registros</u>, estes têm <u>campos</u>
- Criar um banco de dados: (ligar antes o servidor)

```mysql
create database cadastro;
```

- Criar uma tabela

```mysql
create table pessoas (
    
nome varchar(30),
idade tinyint(3), -- o 3 não é obrigatório
sexo char(1), -- como não é varChar, vai reservar o espaço de qualquer forma, podendo ficar vazio
peso float,
altura float,
nacionalidade varchar(20) -- não tem vírgula no último comando

);
```

- Atenção: atualizar painel esquerdo para enxergar as modificações
- describe pessoas; show tables...
- Antes: `use cadastro;`

#### Tipos primitivos MySQL:

1. **numérico**
	- <u>inteiro</u>: TinyInt, SmallInt, Int, MediumInt, BigInt (diferença: bytes utilizados em disco)
	- <u>real</u>: Decimal, Float, Double, Real
	- <u>lógico</u>: Bit, Boolean

2. **data/tempo**: Date, DateTime, TimeStamp, Time, Year
3. **literal** 
	- <u>caractere</u>: Char (fixo, tudo ocupa o mesmo espaço), varChar (variável)
	- <u>texto</u>: TinyText, Text, MediumText, LongText (descrições, parágrafos)
	- <u>binário</u>: TinyBlob, Blob, MediumBlob, LongBlob (permite guardar qualquer coisa em binário, até uma imagem)
	- <u>coleção</u>: Enum e Set (configurar os valores permitidos)
4. **espacial**: Geometry, Point, Polygon, MultiPolygon (informações volumétricas)

- cada um dos sub-tipos tem uma precisão

- É importante dimensionar bem um BD
- Int: 11 bytes, TinyInt: 3 bytes
- Também dá para usar pelo prompt
- Sem uma chave primária, há o risco de duplicidade de registros

---

### Aula 4 - Melhorando a Estrutura do Banco de Dados

- Alter table: alterar a estrutura de uma tabela já criada.
- Colocar chaves primárias

```mysql
drop database cadastro;
```

```mysql
create database cadastro
default character set utf8mb4 -- constraints
default collate utf8mb4_general_ci;	-- collation
-- codificação e collation padrão
```

```mysql
create table pessoas (
    
	id int not null auto_increment,

	nome varchar(30) not null, -- até 30 letras
	nascimento date, -- em vez de cadastrar idade
	sexo enum ('M','F'), -- quais são os valores aceitos. Melhor que char. Também poderia set
	peso decimal(5, 2), -- 5 casas ao todo, 2 dígitos após a vírgula
	altura decimal(3, 2),
	nacionalidade varchar(20) default 'Brasil',
    
	primary key (id)
    
)default charset = utf8mb4;
```

- `not nul`l: constraint que obriga o preenchimento
- nomes entre crases: `` permite espaço e acentuação
- Chaves primárias: matrícula, CPF. Não podem repetir, não existem duas tuplas (registros) iguais.

---

### Aula 5 - Inserindo Dados na Tabela (`insert into`)

- Dados das pessoas

- `create table`: comando de definição de estrutura de BD. É um dos comandos DDL (Data Definition Language), assim como o `create database`

- pegar todos os campos e colocar em uma lista

```mysql
insert into pessoas
	(`id`, `nome`, `nascimento`, sexo, peso, altura, nacionalidade)
values
	('1', 'Godofredo', '1984-01-02', 'M', '78.5', '1.83', 'Brasil');
```

- O que está entre aspas são dados, o que não está são constraints
- Como o id é `auto_increment`, ele pode ser omitido. Então nenhuma das listas o teria, elas começariam no nome.
- Se quiser adicionar: `default`

- Pode omitir os campos se os dados forem inseridos na ordem

```mysql
insert into pessoas values
	(default, 'Claudio', '1975-04-22', 'M', '99', '2.15', 'Brasil'), 
	(default, 'Pedro', '1999-12-3', 'M', '87', '2', default),
	(default, 'Janaina1', '1997-11-12', 'F', '75.4', '1.66', 'Brasil');

select * from pessoas;
```

- `select * from pessoas;`serve para mostrar os dados da tabela
  - diferente de`describe pessoas` ou `desc pessoas` (estes mostram a estrutura)
- `insert into` é comando DML

---

### Aula 6 - Alterando a estrutura da tabela (`alter table` e `drop table`)

#### alter table 

- <u>add column</u>: Adicionar no final (padrão)

```mysql
alter table pessoas
add column profissao varchar(10);
```

- <u>drop column</u>: Remover uma coluna

```mysql
alter table pessoas
drop column profissao;
```

- Adicionar antes do final

```mysql
alter table pessoas
add column profissao varchar(10) after nome;
```

- Adicionar na primeira posição

```mysql
alter table pessoas
add column profissao varchar(10) first;
```

- Alterar a estrutura de uma definição: 
  - <u>Modify</u>: alterar o tipo primitivo e as constraints. Só não consegue renomear o campo (aí utiliza-se outro comando)
  - Deixar não nulo depois de já ter criado gera warnings e o SGBD completa sozinho com espaços vazios (pelo menos foi o que eu vi) - mas também dá para colocar um default.

```mysql
alter table pessoas
modify column profissao varchar(20) not null default '';
```

- Renomear a coluna
  - <u>Change</u>: mais enjoado pois tem que escrever o nome de antes e depois
  - Dá para mudar também o tipo e as constraints
  - No código abaixo, a coluna vai perder as constraints `not null` e `default ''`, pois não foram repetidas
  - Sintaxe: `change column [nome antigo] [nome novo] [tipo] [constraints];`

```mysql
alter table pessoas
change column profissao prof varchar(20);
```

- Renomear a <u>tabela</u> inteira

```mysql
alter table pessoas
rename to gafanhotos;
```

- Se existir/se não existir

```mysql
create table if not exists cursos (
	nome varchar(30) not null unique,
	descricao text,
	carga int unsigned,
	totaulas int
	ano year default '2020'
) default charset = utfbmb4;
```

`Unique` é diferente de `primary key`

`Unsigned`: sem sinal (economiza um byte). Não permite negativo.

*Cuidado*: sem o `if not exists`, você pode sobrescrever a tabela antiga e perdê-la!

- Adicionar a chave primária

```mysql
alter table cursos
add primary key (id);
```

#### Drop table

- Além de ser um parâmetro de `alter table` (para apagar coluna), o drop também pode apagar uma tabela ou um BD, como já foi visto.

```mysql
drop table if exists teste;
```

O MySQL não aceite alterar colunas que já estejam como NOT NULL. Inclusive no seu exemplo as suas colunas estavam em branco e não como `not nul`l.

### Aula 7 - Manipulando linhas (`update`, `delete` e `truncate`)

- Linha = registro = tupla; Campos = colunas = atributos
- Lembre-se `alter table`: manipular colunas

- Modificar 1 valor por vez em um registro

```mysql
update cursos
set nome = 'HTML5'
where id = '1';
```

- Modificar + de 1 valor em um registro

```mysql
update cursos
set nome = 'Java', ano = '2015', carga = '40'
where ano = '2018'
limit 2;
```

- **Cuidado**: há o risco de modificar várias linhas ao mesmo tempo se não usar o `where` com a chave primária ou utilizar o `limit`
  - É possível modificar todos os cursos que têm 40h, por exemplo, mas é muito perigoso
  - O Workbench, por padrão, só permite modificar uma linha por vez, mesmo que não tenha o limit. Ir em edit -> preferences -> sql editor -> desmarcar a opção atualizações seguras e depois reconectar o banco. Marque novamente quando o projeto for sério.

- Remover uma linha

```mysql
delete from cursos
where ano = '2050' limit 2; -- desativar o safe update antes
```

- Apagar todos os registros

```mysql
truncate cursos;
```

ou `truncate table cursos;`. Mantém os cabeçalhos das colunas normalmente.

- `drop table` (DDL) vs `truncate table` (DML)
  - `drop table` apaga tudo, até a estrutura
  - `truncate`: apaga os dados mas mantém a tabela

---

### Aula 8 - Gerenciando Cópias de Segurança MySQL

