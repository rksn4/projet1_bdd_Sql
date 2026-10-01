-- Script projet 1 par RMJ

-- notre base de donnée
use BDB56Projet1RMJ
go

-- si la table existe, il va le supprimer
drop table if exists reservationChambre
drop table if exists chambre
drop table if exists typeChambre
drop table if exists assistant
drop table if exists plannificationSoin
drop table if exists assistantSoin
drop table if exists soin
drop table if exists typeSoins
drop table if exists utilisateur
drop table if exists typeUtilisateur
drop table if exists invite
drop table if exists client 


-- ========== CRÉATION DES TABLES ==========

-- Table client
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
	noTelephone	varchar(20) not null,
	dateInscription datetime not null
)
go

-- Table invite
create table invite (
	noInv			int not null constraint pk_noInv primary key,
					-- Le numéro de l'invité ne doit pas être divisible par 10
					constraint ck_noInvNoDiv10 check (noInv % 10 <> 0),
	nomPrenomInv	varchar(100) not null,
	noCli			int not null constraint fk_noCli foreign key references client (noCli)
					
)
go

-- Table typeUtilisateur
create table typeUtilisateur (
	noTypeUtilisateur	int not null constraint pk_noTypeUtilisateur primary key,
	identification		varchar(50) not null
)
go

-- Table utilisateur
create table utilisateur (
	noUtilisateur		int not null constraint pk_noUtilisateur primary key,
	nomUtilisateur		varchar(50) not null constraint u_nomUtilisateur unique,
	motDePasse			varchar(50) not null,
	noTypeUtilisateur	int not null constraint fk_noTypeUtilisateur foreign key references typeUtilisateur (noTypeUtilisateur)
)
go

-- Table typeSoin
create table typeSoins(
	noTypeSoin int  not null constraint pk_noTypeSoin primary key,
	descriptionTypeSoin varchar(10) not null

)
go

-- Table soin
create table soin(
	noSoin int not null constraint pk_noSoin primary key,
	descriptionSoin varchar(50) not null ,
	prixSoin numeric(10,2) not null,
	dureeSoin int not null default 60 constraint ck_dureeSoin check(dureeSoin = 60),
	noTypeSoin int not null constraint fk_noTypeSoin foreign key  references typeSoins(noTypeSoin)
)
go

-- table assistant
create table assistant(
	noAssistant int not null constraint pk_noAssistant primary key,
	prenom nvarchar(50) not null,
	nom nvarchar(50) not null,
	specialities nvarchar(50) not null,
	remarques nvarchar(50) null
	)
go

-- Table assistantSoin
create table assistantSoin(
	noAssistant int not null constraint fk_noAssistant foreign key references assistant(noAssistant),
	noSoin int not null constraint fk_noSoin foreign key references soin (noSoin) ,
	constraint pk_noAssistantEtSoin primary key (noAssistant,noSoin)
)
go

-- table plannificationSoin
create table plannificationSoin(
	noPlanification int not null constraint pk_noPlanification primary key  ,
	noPersonne int not null,
	noAssistant int not null constraint fk_planificationAssistant foreign key references assistant(noAssistant) ,
	noSoin int not null constraint fk_planifSoin_Soin foreign key  references soin (noSoin), 
	datePlanifSoin datetime not null,
	heurePlanifSoin time not null)
go

-- table typeChambre
create table typeChambre(
	noTypeChambre int not null constraint pk_typeChambre primary key,
	descriptionTypeChambre varchar(50) not null constraint u_descriptionTypeChambre unique,
	prixSaisonHaute numeric(10,2) null,
	prixSaisonBasse numeric(10,2) null,
	prixSaisonMoyenne numeric(10,2) null
	)
go
-- table chambre
create table chambre(
	noChambre int not null constraint pk_Chambre primary key,
	emplacementChambre varchar(50) not null,
	decorationChambre varchar(50) not null,
	noTypeChambre int not null constraint fk_chambre_typeChambre foreign key references typeChambre(noTypeChambre)
	)
go
-- table reservationChambre
create table reservationChambre(
	noCli int not null constraint fk_noClient foreign key references client(noCli),
	noChambre int not null constraint fk_noChambre foreign key references chambre(noChambre),
	dateFinReservation datetime not null, 
	dateDebutReservation datetime not null,
	nbPersonnesReservation int not null,
	constraint pk_reservationChambre primary key (noCli,noChambre, dateFinReservation)
	)
go

-- ========== INSERTION DES DONNÉES ==========

-- Insertion des clients
insert into client values
(10, 'Appiah', 'Jenifer', 'Pierrefonds', 'Canada', '123 rue Converse', 'H1A 1A1', '514-225-4389', getdate()),
(20, 'Abbasi', 'Roksana', 'Kirkland', 'Canada', '579 rue Hike', 'H2Z 3R4', '514-256-9831', getdate()),
(30, 'Abdi Omar', 'Mariam', 'Vaudreuil', 'Canada', '48 rue Interruption', 'G4V 5Z1', '438-483-4225', getdate()),
(11, 'aa','bb','test','canada','6 rue test','H9J 2H7','438-345-9087',getdate())

-- Insertion des invités
delete from invite
insert into invite values
(20, 'test', 10), 
(11, 'Poulet Rouge', 30),
(21, 'Tres Amigos', 20),
(31, 'Iman Abdi El Omar', 30)

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
--(3, 'Aa', 'Password4', 3)		-- test : type utilisateur n'existe pas

-- Insertion des type de soin
insert into typeSoins values 
	(1, 'Beauté'), 
	(2, 'Santé')

-- Insertion des soin
delete from soin
insert into soin values
	(1,'Rendre les gens beau', 100.00,60,1), 
	(2, 'Prendre soin de leur peau',150.00, 60,2)
	--(3, 'test',50.00,60,3) test

-- Insertion d'assistant
insert into assistant values 
	(1, 'Marie', 'Boulette','Esthétique', 'Disponible les matins'),
	(2, 'Michelle', 'Paul','Soins de la peau', null)

-- Insertion des assistantSoin
insert into assistantSoin values
	(1,1), 
	(2,2)

-- Insertion des plannifications de soin
insert into plannificationSoin values
	(1,11,1,1,'2026-11-12', '14:30:00'),
	(2,20,2,2,'2026-12-07', '12:30:00')

-- Insertion de type de chambres
insert into typeChambre values
	(1,'Standard', 150.00, 100.00, 125.00),
	(2,'Deluxe',250.00,180.00,210.00)

-- Insertion des chambres
insert into chambre values 
	(101,'1er étage','Moderne',1),
	(102,'1er étage','Classique',1),
	(201,'2e étage','Luxueuse',2)
	--(202, '2e étage', 'Moderne', 4) -- erreur

-- Insertation des réservations de chambres
delete from reservationChambre
insert into reservationChambre values 
	(10,101,'2026-10-15','2026-10-10',2)
	-- (11,203,'2026-10-12','2026-10-10',2) --erreur



-- Select des tables 
select * from typeUtilisateur
select * from typeSoins
select * from utilisateur
select * from typeChambre
select * from chambre
select * from assistant
select * from reservationChambre

