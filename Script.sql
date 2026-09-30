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

