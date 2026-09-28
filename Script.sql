use BDB56Projet1RMJ

--Script projet 1 

-- CRÉATION DES TABLES 

-- client
create table client (
	noCli		int constraint pk_noCli primary key,
		constraint ck_noCliDiv10 check (noCli % 10 = 0),
	cliNom		varchar(50),
	cliPrenom	varchar(50),
	ville		varchar(50),
	pays		varchar(50),
	adresse		varchar(50),
	codePostal	varchar(50),
	noTelephone	varchar(50),
	dateInscription datetime
)

-- invite
create table invite (
	noInv			int constraint pk_noInv primary key,
		constraint ck_noInvNoDiv10 check (noInv % 10 <> 0),
	nomPrenomInv	varchar(100),
	noCli			int constraint fk_noCli foreign key references client (noCli)
)

-- typeUtilisateur
create table typeUtilisateur (
	noTypeUtilisateur	int constraint pk_noTypeUtilisateur primary key,
	identification		varchar(50)
)

-- utilisateur
create table utilisateur (
	noUtilisateur		int constraint pk_noUtilisateur primary key,
	nomUtilisateur		varchar(50) not null constraint u_nomUtilisateur unique,
	motDePasse			varchar(50),
	noTypeUtilisateur	int constraint fk_noTypeUtilisateur foreign key references typeUtilisateur (noTypeUtilisateur)
)


