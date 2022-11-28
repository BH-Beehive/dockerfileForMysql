create database Beehive;
use Beehive;

create table registro(
id_registro int primary key auto_increment,
data_registro timestamp default current_timestamp not null,
memoria_uso double,
cpu_uso double,
disco_uso double,
tipo_alerta varchar(15),
check ( tipo_alerta = "VERDE" or tipo_alerta = "AMARELO" or tipo_alerta = "VERMELHO")
);
