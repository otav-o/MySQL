[TOC]

19:26 23/08/2020 

## Caderno MySQL

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

- Ideia inicial: SQL seria universal, mas as empresas despadronizaram seus bancos de dados. Órgãos de padronização ANSI e ISO (ambos dos EUA) recomendaram métricas.
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
  - DQL (Solicitações): `select`(ou DML)
  - DCL (Controle, acesso de usuários)
  - DTL (Transações)
- data manipulation language

---

- 4 princípios das transações: **Durabilidade** (conforme o desejo do programador), **Isolamento** (transações simultâneas não interferem), **Consistência** (não dar erro, estar OK), **Atomicidade** (ou tudo dá certo, ou retorna ao estado anterior consistente) [DICA]


---
Instalação: 

- [x] Baixar o MySQL Workbench (grosso modo, um editor de código) 
- [x] e o Xampp.

---

### Aula 3 - Criando o primeiro Banco de Dados

- Registrar instâncias separadas de coisas que têm características semelhantes
- Características != valores
- Containers diferentes para coisas diferentes (características são diferentes)
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
- `describe pessoas;` show tables...
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
    
) default charset = utf8mb4;
```

- `not nul`l: constraint que obriga o preenchimento
- nomes entre crases: `` permite espaço e acentuação
- Chaves primárias: matrícula, CPF. Não podem repetir.
- Também dá: 

```mysql
matricula int primary key, -- somente se for chave primária simples

alter table professor
    add constraint pk_aluno primary key(matricula)
-- ou
alter table professor
	modify matricula decimal(5) primary key;
```

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

- Dados sempre entre aspas
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
  - <u>**Modify**</u>: alterar o tipo primitivo e as constraints. Só não consegue renomear o campo (aí utiliza-se outro comando)
  - Deixar não nulo depois de já ter criado a tabela gera warnings e o SGBD completa sozinho com espaços vazios (pelo menos foi o que eu vi) - mas também dá para colocar um default.

```mysql
alter table pessoas
modify column profissao varchar(20) not null default ''; -- tem que repetir tudo?
```

- Renomear a coluna
  - <u>**Change**</u>: mais enjoado pois tem que escrever o nome de antes e depois
  - Dá para mudar (assim como no `modify`) o tipo e as constraints
  - No código abaixo, a coluna vai perder as constraints `not null` e `default ''`, pois não foram repetidas
  - Sintaxe: `alter table [nome tabela] change column [nome antigo] [nome novo] [tipo] [constraints];`

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

- `Unique` é diferente de `primary key`

  - Não pode repetir mas pode ser nulo. Define uma *chave candidata*

  - ```mysql
    unique(rg, rua, cidade) -- define um conjunto unique
    ```

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

{O MySQL não aceite alterar colunas que já estejam como `not null`. Inclusive no seu exemplo as suas colunas estavam em branco e não como `not nul`l.} nao sei oq significa nem como isso chegou aqui

---

### Aula 7 - Manipulando linhas (`update`, `delete` e `truncate`)

- Linha = registro = tupla; Campos = colunas = atributos
- Lembre-se de que`alter table` manipula colunas!

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
- Ou: `set sql_safe_updates = 0;`
  
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

- Chave estrangeira em cascata

```mysql
alter table aluno
	add foreign key (codigo_curso) references curso(cod_curso)
    on delete cascade on update cascade; -- !!!!
    /*agora, se excluir um curso, o SGBD vai procurar todos os alunos
    inscritos nele e excluí-los também*/
    
    /*update em cascata: mudar o codigo do curso e atualizar a chave estrangeira 
	em todos os alunos*/
```

---

### Aula 8 - Gerenciando Cópias de Segurança MySQL

- dump = backup

##### Exportar a base de dados

- Gerar dump é baixar do servidor

- Server -> data export
- marque a exportação de esquema
- veja o arquivo .`sql` pelo bloco de notas

##### Importar o banco

- Muito simples também, em data import

---

### Aula 9 - PHPMyAdmin (parte 1) 

- Lembre-se: o WorkBench serve para acessar um banco de dados que está em um servidor, este não precisa estar na sua máquina para ser modificado. Você só precisa do endereço + usuário e senha.

- PHPMyAdmin: aplicação web que facilita e automatiza a criação de bancos MySQL

  - Bom para aprender: ele mostra o comando que usou no terminal

- Usar o Xampp no terminal: exatamente a mesma coisa de usar o WorkBench. Para iniciar: 

  - > mysql -u root

- http://localhost/phpmyadmin/

---

### Aula 10 - parte 2

- É bom aprender mexer no PHPMyAdmin, mas **jamais** deixe de lado o estudo dos comandos, já que eles são essenciais para conectar seu banco com linguagens de programação.

No console, para ver os comandos:

> show create database exemplo;

> show create table amigos;

- Dá para fazer tudo pela aplicação, só lembrar dos caminhos - às vezes precisa clicar na casinha, por exemplo.

---

### Aula 11 - Select (parte 1)

- Comando mais famoso/com mais parâmetros
  - cuidado: você vai ter que estudar algo específico para Oracle, Access, Postgre, os selects podem variar.
- Importar o banco que ele disponibilizou para download
- Selecionar todas as colunas (*)

```mysql
select * from cursos; -- ordem da chave primária

select * from cursos
order by nome asc; -- ascendent (pode ser omitido)

select * from cursos
order by nome desc; -- decrescente
```

- **Filtrar colunas**: substituir o asterisco pelos nomes
  - A ordem dos nomes no comando será a ordem de exibição

```mysql
select nome, carga, ano from cursos; -- mostra todos os registros das colunas escolhidas

select ano, nome, carga from cursos 
order by ano desc, nome asc; -- duas ordenações
```

- **Filtrar linhas**:
  - Result set: resultado de uma consulta. Não precisa mostrar a coluna ano, mesmo ela sendo o filtro
  - Query: condição. Where ano = '2016'

```mysql
select nome, carga from cursos
where ano = '2016' -- vai mostrar todas as linhas 2016
order by nome;
```

```mysql
where ano <= '2015' -- <, >, <=, >=, =, <> ou !=
```

- `between and`
  - Faixas de valores

```mysql
select * from cursos
where totaulas between '20' and '30' -- inclui 20 e 30
order by nome;
```
- `in`
  - Valores específicos

```mysql
select * from cursos
where ano in ('2014', '2016', '2018')
order by nome;
```

- Expressões lógicas (and, or)

```mysql
select nome, ano from cursos
where carga > 35 and totaulas < 30
order by nome;
```

---
### Aula 12 - Select (parte 2)

- **Operador like** (operador assim como >, <=, between, etc.)
  - Semelhança. É case-insensitive
  - **%** - curinga. Substitui nenhum ou vários caracteres (significa "qualquer coisa")
    - Posição do % faz diferença
  - Com letra maiúscula ou não: o resultado é o mesmo

```mysql
select * from cursos
where nome like 'P%';	-- nomes que começam com P/p
```

```mysql
select * from cursos
where nome like '%a'; -- nomes que terminam com a/A (qualquer coisa encerrada com a)
```

```mysql
select * from cursos
where nome like '%a%'; 	-- 'a' em qualquer lugar, inclusive no início ou final
```

```mysql
select idcurso, nome, carga
where nome not like '%á%'; -- lembrar de combinar operadores
```
- underline (_). Substitui necessariamente algum caractere (não pode estar vazio)
```mysql
select * from cursos
where nome like 'ph%p_';
where nome like 'p__t%';
```

```mysql
select * from gafanhotos
where nome like '%silva%';
```

- **Distinct**
  - Apenas uma ocorrência de cada tupla
  - Ex.: uma listagem
  - Não serve para contar

```mysql
select distinct nacionalidade from gafanhotos
order by nacionalidade;
```

```mysql
select carga from cursos -- mostra com as repetições
order by carga;
```

- **Count**
  - Função de agregação

```mysql
select count(*) from cursos;
```

```mysql
select count(*) from cursos where carga > 40;
```

- **Max**
  - Qual o máximo de um campo
  - Poderia fazer um select ordenar e olhar qual é
  - Pega somente um valor (despreza um segundo de valor igual)

```mysql
select max(carga) from cursos;
```

```mysql
select max(totaulas) from cursos where ano = '2016';
```

- **Min**

```mysql
select nome, min(totaulas) from cursos where ano = '2016';
```

- **Sum**
  - Somar

```mysql
select sum(totaulas) from cursos; -- total de aulas da tabela cursos
```

- **Avg**
  - Média dos valores que atendem à condição de seleção

```mysql
select avg(totaulas) from cursos where ano = '2016';
```
---
### Aula 13 - Select (parte 3)

- Agrupar (group by)

```mysql
select carga from cursos
group by carga;
```
- Contar: exibir uma coluna com o count

```mysql
select carga, count(carga) from cursos -- pode colocar qualquer campo no count, inclusive *
group by carga;
```
- Having: semelhante ao where para o select
  - Mas só dá para usar os dados que foram agrupados
```mysql
select carga, count(nome) from cursos
group by carga
having count(nome) > 3;
```

```mysql
select ano, count(*) from cursos
where totaulas > 30
group by ano 
having ano > 2013 -- só agrupa quem atende a essa condição
order by count(*) desc;
```
- Resultado de um select dentro de outro:
```mysql
select carga, count(*) from cursos 
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos);
```

---

### Aula 14 - Modelo Relacional

- Não é o mais recente (há o orientado a objetos), mas é o mais utilizado
- Entidade: entender como um container com vários dados dentro. Ex.: Produtos - imaginar vários produtos como valores.
- Entidades possuem atributos, que compõem os dados e estes compõem os elementos de cada uma das entidades
- **Dados são representados por atributos que, em conjunto, identificam tuplas (registros) armazenadas dentro de entidades**
- Uso de chaves: base do modelo relacional - relaciona entidades
- Diagrama ER -> Relacionamento: losango; entidade: retângulo
- Classificar por cardinalidades

cliente compra produto (muitos para muitos)

- Relacionar tabelas é trocar chaves
- Sem chave primária não há relação. Ela que vira estrangeira

marido 1 casa com 1 esposa

---

### Aula 15 - Chaves Estrangeiras e JOIN

- InnoDB: uma engine que permite a criação de tabelas. Suporta chaves estrangeiras (integridade referencial) e é compatível com os 4 conceitos fundamentais da transação. Está implícita na criação de qualquer tabela no MySQL

- <u>ACID: 4 regras de uma boa transação</u>
  - **Atomicidade**: não pode ser dividida em sub-tarefas. Ou toda a tarefa é feita, ou nada é considerado
  - **Consistência**: se antes da transação o BD era consistente, ao final dela ele deve continuar sem falhas
  - **Isolamento**: duas transações em paralelo não podem interferir uma na outra
  - **Durabilidade**: a transação deve durar o tempo que for necessário. Não se pode perder dados do nada

- Relacionamento 1 para muitos
  - A chave primária do lado 1 vai para o lado n
  - Não precisa manter o mesmo nome, somente o tipo e tamanho

![image-20201014072440629](C:\Users\Otávio estudos\AppData\Roaming\Typora\typora-user-images\image-20201014072440629.png)

- **Definindo chave estrangeira**
  - Primeiro criar uma chave qualquer; depois configurar como `foreign key` e referenciar outra-tabela(chave-primaria-outra-tabela)

```mysql
alter table gafanhotos -- vai receber a chave estrangeira
add column cursopreferido int; -- cria uma coluna para receber a chave

alter table gafanhotos
foreign key (cursopreferido) -- chama a coluna criada de chave estrangeira
references cursos (idcurso); -- referencia a coluna a outra de outra tabela
```
- **Relacionando registros**

```mysql
update gafanhotos
set curso_preferido = '6' 
where id = '1';
```

- Uma modificação de campo não pode gerar inconsistências: não dá para apagar um curso cuja chave primária é estrangeira em gafanhotos (mas pode apagar um que ainda não foi relacionado)

```mysql
delete from cursos where idcurso = '6'; -- erro de integridade referencial
```

- 

```mysql
alter table aluno
	add constraint fk_codCurso foreign key (codigo_curso)
	references curso(cod_Curso)
;
```



#### Join

- Todo `join` **precisa** de uma clausula **on** para fazer sentido
- Apelidos de colunas: palavra **`as`** é opcional 

##### Inner join

- **`inner join`** só liga o que tem relação nas duas tabelas. É o padrão, basta escrever `join`
- Só mostra as pessoas e os cursos relacionados

```mysql
select gafanhotos.nome, cursos.nome, gafanhotos.curso_preferido -- mostrar isso

from gafanhotos join cursos -- juntar as duas

on cursos.idcurso = gafanhotos.curso_preferido -- onde idcurso for igual a curso preferido

order by gafanhotos.curso_preferido;
```
![image-20201014083919294](C:\Users\Otávio estudos\AppData\Roaming\Typora\typora-user-images\image-20201014083919294.png)

```mysql
select g.nome, c.nome
from gafanhotos as g inner join cursos as c 	-- apelido
on c.idcurso = g.curso_preferido;
```

##### Outer join

- **`left/right outer join`**
- Dá preferência a uma das tabelas, mostrando todos os registros dela.
- `outer` pode ser omitido

```mysql
select g.nome, c.nome

from gafanhotos g left outer join cursos c -- dá preferência à tabela gafanhotos (à esquerda)

on c.idcurso = g.curso_preferido;
```

- - obs.: os apelidos foram usados sem o `as`

- - No código acima, todos os gafanhotos serão mostrados, inclusive os que não têm curso preferido definido. Mas nem todos os cursos irão aparecer.

```mysql
select g.nome, c.nome

from gafanhotos as g right join cursos as c -- pode escrever sem o outer

on g.curso_preferido = c.idcurso;
```

![image-20201014085028929](C:\Users\Otávio estudos\AppData\Roaming\Typora\typora-user-images\image-20201014085028929.png)

- - Já neste daqui, todos os cursos aparecem (inclusive os que ninguém prefere) mas não todas as pessoas.

---

### Aula 16 - Inner join com várias tabelas

- muitos para muitos
- gafanhoto n - asssiste - n curso

- Cuidado para não fazer consultas erradas

```mysql
create table gafanhotos_fazem_cursos (
	id int not null auto_increment,
    primary key (id),
    data date, 
    idgafanhoto int, 
    idcurso int,
    foreign key (idgafanhoto) references gafanhotos (id),
    foreign key (idcurso) references cursos (idcurso)
    ) default charset = utf8mb4;
```

```mysql
insert into gafanhotos_fazem_cursos values
    (default, '2014-03-01', '1', '2');
```

```mysql
select g.nome, a.idcurso, c.nome from gafanhotos g join gafanhotos_fazem_cursos a
    on g.id = a.idgafanhoto
    join cursos c
    on c.idcurso = a.idcurso;
```



#### Exercícios - faça:

- Uma lista com todas os gafanhotos fêmeas
- Uma lista com os dados de todos que nasceram entre 1/jan/2000 e 31/dez/2015. 
  - cuidado com a representação da data (é invertida)
- Um lista com os nomes de todos os homens que são programadores
- Uma lista com os dados de todas as mulheres que nasceram no Brasil e que têm seu nome iniciando com a letra j
- Uma lista com o nome e nacionalidade de todos os homens que têm silva no nome, não nasceram no Brasil e pesam menos de 100 kg
- Qual a maior altura entre os gafanhotos homens que moram no Brasil?
- Qual é a média de peso dos gafanhotos cadastrados?
- Qual é o menor peso entre as gafanhotos mulheres que nasceram fora do Brasil e entre 01/jan/1990 e 31/dez/2000?
- Quantos gafanhotos mulheres têm mais de 1.90 de altura?

---

- Uma lista com as profissões dos gafanhotos e seus respectivos quantitativos
- Quantos gafanhotos homens e quantas mulheres nasceram após 01/jan/2005?
  - Achar o total e depois agrupar por sexo
- Uma lista com os alunos que nasceram *fora* do Brasil, mostrando o país de origem e o total de pessoas nascidas lá. Só nos interessam os países que tiverem mais de 3 alunos com essa nacionalidade.
- Uma lista agrupada pela altura dos gafanhotos, mostrando quantas pessoas pesam mais de 100 kg e que estão acima da média de altura de todos os cadastrados
