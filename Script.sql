use BDB56Projet1RMJ

--Script projet 1 

-- ========== CRÉATION DES TABLES ==========

-- Table CLIENT
create table client (
	noCli		int not null constraint pk_noCli primary key,
				-- Le numéro du client doit être divisible par 10
				constraint ck_noCliDiv10 check (noCli % 10 = 0),
	cliNom		varchar(50) not null,
	cliPrenom	varchar(50) not null,
	ville		varchar(50) not null,
	pays		varchar(50) not null,
	adresse		varchar(50) not null,
	codePostal	varchar(50) not null,
	noTelephone	varchar(50) not null,
	dateInscription datetime not null
)

-- Table INVITE
create table invite (
	noInv			int not null constraint pk_noInv primary key,
					-- Le numéro de l'invité ne doit pas être divisible par 10
					constraint ck_noInvNoDiv10 check (noInv % 10 <> 0),
	nomPrenomInv	varchar(100) not null,
	noCli			int not null constraint fk_noCli foreign key references client (noCli),
					-- un invité doit avoir un numéro compris entre 
					-- le numéro de son client + 1 et + 9.
					-- ex : client 10 peut avoir invités 11 à 19
					constraint ck_noInvNoCli check (noInv > noCli and noInv <= noCli + 9)
)

-- Table TYPEUTILISATEUR
create table typeUtilisateur (
	noTypeUtilisateur	int not null constraint pk_noTypeUtilisateur primary key,
	identification		varchar(50) not null
)

-- Table UTILISATEUR
create table utilisateur (
	noUtilisateur		int not null constraint pk_noUtilisateur primary key,
	nomUtilisateur		varchar(50) not null constraint u_nomUtilisateur unique,
	motDePasse			varchar(50) not null,
	noTypeUtilisateur	int not null constraint fk_noTypeUtilisateur foreign key references typeUtilisateur (noTypeUtilisateur)
)

--Table typeSoin
create table typeSoins(
noTypeSoin int constraint pk_noTypeSoin primary key,
descriptionTypeSoin varchar(10)

)

--Table Soin
create table Soin(
noSoin int constraint pk_noSoin primary key,
descriptionSoin varchar(50) ,
prixSoin numeric(10,2) ,
dureeSoin int not null,
noTypeSoin int constraint fk_noTypeSoin foreign key  references typeSoins(noTypeSoin)
)

--Table assistantSoin
create table assistantSoin(
noAssistant int constraint fk_noAssistant foreign key references assisant(noAssistant),
noSoin int constraint fk_noSoin foreign key references soin (noSoin) ,
constraint pk_noAssistantEtSoin primary key (noAssistant,noSoin)
)

--table plannificationSoin
create table plannificationSoin(
noPlanification int constraint pk_noPlanification primary key  ,
noPersonne int not null,

noAssistant int constraint fk_noAssistant foreign key references assistant (noAssistant) ,
noSoin int constraint fk_planifSoin_Soin foreign key  references Soin (noSoin), 
dateReservation datetime not null,
heureReservation time not null)


-- ========== INSERTION DES DONNÉES ==========

-- Insertion des clients
insert into client values
(10, 'Appiah', 'Jenifer', 'Pierrefonds', 'Canada', '123 rue Converse', 'H1A 1A1', '514-225-4389', getdate()),
(20, 'Abbasi', 'Roksana', 'Kirkland', 'Canada', '579 rue Hike', 'H2Z 3R4', '514-256-9831', getdate()),
(30, 'Abdi Omar', 'Mariam', 'Vaudreuil', 'Canada', '48 rue Interruption', 'G4V 5Z1', '438-483-4225', getdate())

-- Insertion des invités
insert into invite values
(11, 'Poulet Rouge', 10),
(12, 'Tres Amigos', 20),
(13, 'Iman Abdi El Omar', 30)

-- Insertion des types d'utilisateurs
insert into typeUtilisateur values
(1, 'Admin'),
(2, 'Préposé')

-- Insertion des utilisateurs
insert into utilisateur values
(1001, 'AliciA', 'Password1', 1),		-- Admin
(1002, 'GabrielleP', 'Password2', 2),	-- Préposé
(1003, 'RominaA', 'Password3', 1),		-- Admin
(1004, 'AhashP', 'Password4', 2)		-- Préposé


--Insertion des type de soin
insert into typeSoins values (1, 'Beaute')
insert into typeSoins values (2, 'Soin')


--Insertion des soins
insert into Soin values(1,'Rendre les gens beau', 100,90+ ' min',1)
insert into Soin values(2, 'Prendre soin de leur peau',150, 120 + ' min',2)

--Insertion des assistantSoin
insert into assistantSoin values(1,1)
insert into assistantSoin values(2,2)

--Insertion des plannification de soin
insert into plannificationSoin values(1,1,1,1,'2026-09-10', '14:30:00:00')
insert into plannificationSoin values(2,2,2,2,'2026-09-5', '12:30:00:00')



