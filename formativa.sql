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

create table evento(
	eventoID bigint not null auto_increment,
    nome varchar(50) not null,
    primary key(eventoID)
);

create table checklist(
	checklistID bigint not null auto_increment,
    ambienteFK bigint not null,
    itemFK bigint not null,
    primary key(checklistID),
    foreign key(ambienteFK) references ambiente(ambienteID),
    foreign key(itemFK) references item(itemID)
);


create table check_in(
	check_inID bigint not null auto_increment,
    check_S_N boolean not null,
    eventoFK bigint not null,
    ambienteFK bigint not null,
    DtInicio date not null,
    DtFinal date not null,
	reservas int not null,
	primary key(check_inID),
	foreign key(eventoFK) references evento(eventoID),
    foreign key(ambienteFK) references ambiente(ambienteID)
);

insert into ocupacao (nomeOcp) values ("Coordenador"), ("Orientador"), ("Assistente social"), ("Secretária");

insert into regraacesso (acesso) values ("Administrador"), ("Gestor"), ("Usuário"), ("Visitante"), ("Aluno");

insert into item (nome) values ("Projetor"), ("TV Smart"), ("Ar condicionado"), ("WorkStation"), ("Lousa");

insert into ambiente (nome, bloco, quantPessoas) values ("Lab. Informática", "B", 20), ("Oficina", "C", 40), ("Lab. Elétrica", "A", 20), ("Auditório", "D", 150), ("Refeitório", "C", 300);

insert into usuario (nome, ocupacaoFK, acessoFK, email, DtNasc, senha, ativo) values ("Daniel", 1, 2, "daniel@gmail.com", '2004-09-14', "daniel123", 1), ("Julio", 2, 3, "julio@gmail.com", '2000-10-04', "julio123", 1), 
("Pedro", 3, 4, "pedro@gmail.com", '1999-12-08', "pedro123", 0), ("Heittor", 2, 2, "heittor@gmail.com", '1997-04-28', "heittor123", 1), ("Amanda", 3, 5, "amanda@gmail.com", '2003-07-24', "amanda123", 0),
("Thiago", 4, 3, "thiago@gmail.com", '2002-10-19', "thiago123", 1), ("Gabriel", 4, 2, "gabriel@gmail.com", '1985-11-11', "gabriel123", 1);

insert into checklist (ambienteFK, itemFK) values (3, 5), (3, 3), (3, 1), (2,5), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (4, 3), (4, 1), (4, 2), (4, 4), (5, 3), (5, 2);

insert into evento (nome) values ("Palestra"), ("Festa Anual"), ("Formatura"), ("Premiação interclasse"), ("Reunião Escolar");

insert into check_in (check_S_N, eventoFK, ambienteFK, DtInicio, DtFinal, reservas) values (1, 1, 4, '2023-05-18', '2023-05-20', 150), (1, 2, 5, '2023-06-20', '2023-06-20', 300), (1,3, 4, '2022-12-15', '2022-12-16', 150),
(1, 5, 1, '2023-03-19', '2023-03-19', 30), (0, 1, 2, '2022-03-15', '2022-03-15', 40), (1, 4, 2, '2023-11-20', '2023-11-20', 40); 

select * from check_in;


 
