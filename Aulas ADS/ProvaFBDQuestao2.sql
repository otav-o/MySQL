create database sistemabancario;
use sistemabancario;

create table if not exists agencia (
	numero_agencia varchar(5),
		primary key(numero_agencia),
	nome_agencia varchar(15),
	cidade_agencia varchar(30)
) default charset = utf8mb4;

select * from agencia;

create table if not exists emprestimo (
	numero_emprestimo int not null, 
		primary key (numero_emprestimo),
	quantia int,
	numero_agencia varchar(5),
		foreign key(numero_agencia) references agencia (numero_agencia)
) default charset = utf8mb4;

create table if not exists cliente (
	numero_cliente int not null,
		primary key (numero_cliente),
	nome_cliente varchar(15),
	estado char(2),
	cidade varchar(15),
	telefone varchar(12),
	sexo enum('M', 'F')
) default charset = utf8mb4;

create table conta (
	numero_conta int not null,
		primary key (numero_conta),
	ano_abertura Year,
	saldo int,
	numero_cliente int,
		foreign key (numero_cliente) references cliente(numero_cliente),
	numero_agencia varchar(5),
		foreign key (numero_agencia) references agencia(numero_agencia)
) default charset = utf8mb4;

create table emprestimo_cliente (
	numero_cliente int,
		foreign key (numero_cliente) references cliente(numero_cliente),
	numero_emprestimo int,
		foreign key (numero_emprestimo) references emprestimo(numero_emprestimo)

) default charset = utf8mb4;

desc agencia;
alter table agencia
	change column nome_agencia nome varchar(15), 
	modify cidade_agencia varchar(25);

desc cliente;
alter table cliente
	add column uf char(2),
	add column cpf decimal(11) not null unique,
	modify column sexo enum('M', 'F') not null
	-- change column rua_cliente endereco varchar(30) -- não existe!
;

desc conta;
alter table conta
	add column data_abertura date;

desc emprestimo;
alter table emprestimo
	add column ano_emprestimo year(4) default 2017;