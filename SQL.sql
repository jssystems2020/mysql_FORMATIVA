drop database if exists somativa;
create database somativa; 
use somativa; 
create table bebidas(   
    codBebida integer(6) primary key not null auto_increment, 
    nomeBebida varchar(40) not null,
    volumeVasilhame integer(6) not null
);
create table tipo_Bebida(
    codBebida integer(6) not null,
    tipoBebida varchar(20),
    constraint fk_tipo_babidas foreign key (codBebida) references bebidas(codBebida)
);
create table pratileiras(
    numPratileiras integer(8) primary key not null, 
    posicaoDeposito varchar(30) not null,
    pesoSuportado decimal(8,2) not null,
    dataAquisicao date
);
create table movimento(
    numPedido integer(8) primary key not null,
    codBebida integer(6) not null,
    numPratileiras integer(8) not null,
    dataMovimento date not null,
    tipoMovimento varchar(30) not null,
    totalVasilhames decimal(8,2) not null,
    valorUnitario decimal (8,2) not null,
    constraint fk_bebidas_movimento foreign key (codBebida) references bebidas (codBebida), 
    constraint fk_pratileiras_movimento foreign key (numPratileiras) references pratileiras (numPratileiras)
);
insert into bebidas values
(10001,"cerveja",240),
(10002,"guarana",60),
(10003,"energetico",120),
(10004,"whisky",140);

insert into tipo_Bebida values
(10001,"com álcool"), 
(10001,"sem álcool"), 
(10002,"sem álcool"),
(10003,"sem álcool"),
(10003,"com álcool"),
(10004,"com álcool");

insert into pratileiras values
(1,"latas",500,curdate()),
(2,"garrafas plastica",1000,curdate()-1),
(3,"garrafas de vidros",2000,curdate()+1),
(4,"garrafas retornaveis",1200,curdate()+2);

insert into movimento values
(200001,10001,1,curdate(),"cerveja",48,100),
(200002,10002,2,curdate()-1,"guarana",30,300),
(200003,10003,4,curdate()+1,"whisky",38,1000),
(200004,10004,3,curdate()+2,"energetico",100,700);

create view vw_estoque as
select m.numPedido, m.codBebida, m.numPratileiras, m.dataMovimento, m.tipoMovimento, m.totalVasilhames, m.valorUnitario, valorUnitario * totalVasilhames as valorTotal from movimento m left join bebidas b on m.codBebida = b.codBebida;