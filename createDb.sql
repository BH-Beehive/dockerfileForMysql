create database Beehive;
use Beehive;

create table plano(
id_plano int primary key auto_increment,
tipo_plano varchar(10),
check ( tipo_plano = "Basic" or tipo_plano = "Standart" or tipo_plano = "Premium"),
valor decimal(7,2)
);

insert into plano values(null,'Basic',100.00),
(null,'Standart',200.00),
(null,'Premium',400.00);

create table empresa(
id_empresa int primary key auto_increment,
nome_empresa varchar(100) not null,
cnpj char(18) unique not null,
telefone_fixo varchar(15) unique not null,
telefone_celular varchar(15) unique not null,
email varchar(50) unique not null,
senha varchar(25) not null,
cep char(8) not null,
logradouro varchar(45) not null,
estado varchar(30) not null,
cidade varchar(30) not null,
fk_plano int,
foreign key (fk_plano) references plano(id_plano),
plano_ativo boolean
);

insert into empresa values (null,"hospital albert einstein","75.565.133/0001-04","5923-6724","(84)97242-2370" ,"albert_einstein@gmail.com","albert@114","04831120","Rua Saude", "SP","São Paulo",1,true);

create table usuario_suporte(
id_usuario int primary key auto_increment,
nome_suporte varchar(45) not null,
email_slack varchar(50) unique not null,
senha varchar(50) not null,
telefone varchar(15) unique,
celular char(15) unique,
cpf char(14) unique not null,
fk_empresa int,
foreign key (fk_empresa) references empresa(id_empresa)
);
insert into usuario_suporte values (null,"Bruno Caldeira","bruno_caldeira@albert.com","bruno@321","(87)2016-3838","(79)90508-4826","772.579.371-25",1);



create table setor (
id_setor int primary key auto_increment,
nome_setor varchar(45),
fk_empresa int,
foreign key (fk_empresa) references empresa(id_empresa),
nivel_prioridade char(1) not null,
check (nivel_prioridade = 1 or nivel_prioridade = 2 or nivel_prioridade = 3)
);
insert into setor values (null,"Triagem",1,2),
(null,"Laboratorio",1,1);


create table maquina(
id_maquina int primary key auto_increment,
host_name varchar(30) unique not null,
token_acesso varchar(15) unique not null,
token_ativo boolean not null,
tipo varchar(15) not null,
check(tipo = "Maquina" or tipo = "Servidor"),
memoria_total double,
disco_total double,
arquitetura char(3),
sistema_operacional varchar(15),
processador varchar(75),
fk_empresa int ,
foreign key (fk_empresa) references empresa(id_empresa),
fk_setor int,
foreign key (fk_setor) references setor(id_setor)
)auto_increment = 100;

 insert into maquina values (null,'633791bb8af21','491072A',true,'maquina','500000000','200000000','x64','Windows','
Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz',1,1);

update maquina set memoria_total = 10.0 , disco_total = 10.0 , arquitetura = 64 , sistema_operacional = "linux" , processador = "alguma" where token_acesso = "138e813kj1323";



create table registro(
id_registro int primary key auto_increment,
data_registro timestamp default current_timestamp not null,
fk_maquina int not null, 
foreign key (fk_maquina) references maquina(id_maquina),
memoria_uso double,
cpu_uso double,
disco_uso double,
tipo_alerta varchar(15),
check ( tipo_alerta = "VERDE" or tipo_alerta = "AMARELO" or tipo_alerta = "VERMELHO")
);

 
 insert into maquina values (null,'maq04','61072A',true,'servidor','500000000','200000000','x64','linux','
Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz',1,1),
(null,'maq05','605072B',true,'maquina','500000000','200000000','x64','linux','
Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz',1,2);


update maquina set disco_total = 237000 where id_maquina = 107;



update registro set tipo_alerta = "Vermelho" where id_registro = 5;


update registro set tipo_alerta = "Vermelho" where fk_maquina = "102";