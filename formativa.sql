create database agendamento;
use agendamento;



create table ocupacao(
	ocupacaoID bigint not null auto_increment,
    nomeOcp varchar(50),
	primary key(ocupacaoID)
);

create table regraacesso(
	acessoID bigint not null auto_increment,
    acesso enum("Administrador", "Gestor", "Usuário", "Visitante", "Aluno"),
    primary key(acessoID)
);

create table item(
	itemID bigint not null auto_increment,
    nome varchar(100) not null,
    primary key(itemID)
);

create table usuario(
	usuarioID bigint not null auto_increment,
    nome varchar(70) not null,
    ocupacaoFK bigint not null,
    acessoFK bigint not null,
	email varchar(50) not null,
    DtNasc date not null,
    senha varchar(20) not null,
    DtCadastro datetime default now(),
    ativo boolean default 1,
    primary key(usuarioID),
    foreign key(ocupacaoFK) references ocupacao(ocupacaoID),
    foreign key(acessoFK) references regraacesso(acessoID)
);



create table ambiente(
	ambienteID bigint not null auto_increment,
    nome varchar(70) not null,
    bloco enum("A", "B", "C", "D"),
	quantPessoas int not null,
    primary key(ambienteID)
);



create table checklist(
	checklistID bigint not null auto_increment,
    ambienteFK bigint not null,
    itemFK bigint not null,
    primary key(checklistID),
    foreign key(ambienteFK) references ambiente(ambienteID),
    foreign key(itemFK) references item(itemID)
);


create table evento(
	eventoID bigint not null auto_increment,
    nome varchar(50) not null,
    ambienteFK bigint not null,
    DtInicio date not null,
    DtFinal date not null,
	reservas int not null,
	primary key(eventoID),
    foreign key(ambienteFK) references ambiente(ambienteID)
);

create table check_in(
	check_inID bigint not null auto_increment,
    Dt_checkin date not null,
    eventoFK bigint not null,
    usuarioFK bigint not null,
    primary key(check_inID),
    foreign key(eventoFK) references evento(eventoID),
    foreign key(usuarioFK) references usuario(usuarioID)
);


 insert into ocupacao (nomeOcp) values ("Coordenador"), ("Orientador"), ("Assistente social"), ("Secretária");

insert into regraacesso (acesso) values ("Administrador"), ("Gestor"), ("Usuário"), ("Visitante"), ("Aluno");

insert into item (nome) values ("Projetor"), ("TV Smart"), ("Ar condicionado"), ("WorkStation"), ("Lousa");

insert into ambiente (nome, bloco, quantPessoas) values ("Lab. Informática", "B", 20), ("Oficina", "C", 40), 
("Lab. Elétrica", "A", 20), ("Auditório", "D", 150), ("Refeitório", "C", 300), ('Lab. N10', 'A', 45), ('Lab. N12', 'C', 30), ('Lab. N11', 'D', 50);


insert into usuario (nome, ocupacaoFK, acessoFK, email, DtNasc, senha, ativo) values ("Daniel", 1, 2, "daniel@gmail.com", '2004-09-14', "daniel123", 1), ("Julio", 2, 3, "julio@gmail.com", '2000-10-04', "julio123", 1), 
("Pedro", 3, 4, "pedro@gmail.com", '1999-12-08', "pedro123", 0), ("Heittor", 2, 2, "heittor@gmail.com", '1997-04-28', "heittor123", 1), ("Amanda", 3, 5, "amanda@gmail.com", '2003-07-24', "amanda123", 0),
("Thiago", 4, 3, "thiago@gmail.com", '2002-10-19', "thiago123", 1), ("Gabriel", 4, 2, "gabriel@gmail.com", '1985-11-11', "gabriel123", 1);


insert into checklist (ambienteFK, itemFK) values (3, 5), (3, 3), (3, 1), (2,5), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (4, 3), (4, 1), (4, 2), (4, 4), (5, 3), (5, 2);






insert into evento (nome, ambienteFK, DtInicio, DtFinal, reservas) 
values ("Palestra", 2, '2023-06-20', '2023-06-20', 300), 
("Festa Anual", 3, '2022-12-15', '2022-12-16', 150), 
("Formatura", 5, '2023-03-19', '2023-03-19', 30), 
("Premiação interclasse", 1, '2022-03-15', '2022-03-15', 40), 
("Reunião Escolar", 4, '2023-11-20', '2023-11-20', 40),
("Festa Junina", 5, '2023-06-15', '2023-06-20', 30),
("Aniversário Escolar", 4, '2022-07-23', '2022-07-23', 40),
("Conversa com alunos", 4, '2022-11-15', '2023-11-16', 40);




select * from usuario;
select * from evento;

insert into check_in(Dt_checkin, eventoFK, usuarioFK) values ('2023-06-20', 1, 1), ('2022-12-15', 2, 2), ('2023-03-19', 3, 3), ('2022-03-15', 3, 4),
('2023-11-20', 4, 5), ('2023-06-20', 3, 5);

select * from check_in;

select * from ambiente;






#A)
select * from ambiente;
select * from evento;
select * from check_in;

select a.nome ,count(eventoID) as 'QTD Eventos' from ambiente a 
inner join evento e on e.ambienteFK = a.ambienteID
group by ambienteID;

#B)

select * from ambiente;
select * from evento;
select * from check_in;

select a.nome from ambiente a 
where a.ambienteID not in (select ambienteFK from evento);


#C)
select * from evento;
select e.nome, e.DtInicio, e.DtFinal from evento e
where DtInicio = '2022-12-15' and DtFinal = '2022-12-16';



#D)
select * from usuario;

select u.nome ,count(u.usuarioID) from usuario u 
inner join check_in c on u.usuarioID = c.usuarioFK
group by u.usuarioID;

#E)

#F)

#G)

select * from evento;
select * from check_in;

select e.nome, count(c.check_inID) as 'Qnt. Check_in' from evento e 
inner join check_in c on c.eventoFK = e.eventoID
group by eventoID order by count(c.check_inID) desc;

#H)

select * from ambiente;
select * from evento;
select * from check_in;

-- ? --
select avg(usuarioFK) from check_in c 
inner join evento e on e.eventoID = c.eventoFK
inner join ambiente a on a.ambienteID = e.ambienteFK
group by ambienteID;  

#I)

select * from usuario;
select * from ocupacao;

select u.nome, r.acesso from usuario u 
inner join regraacesso r on r.acessoID = u.acessoFK;

#J)

#K)

#L)

#M)


-- Ocorreu um erro ao importar o banco de dados para realizar as consultas, as tabelas não vieram junto ao banco

-- string conexão mysqldaniel.mysql.database.azure.com
-- login Pinheiro
-- senha daniel123
