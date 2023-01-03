-- Początkowe tworzenie bazy danych

CREATE DATABASE PracaDyplomowa
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PracaDyplomowa', 
FILENAME = N'Z:PracaDyplomowa.mdf' , 
SIZE = 100MB , 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 20MB )
 LOG ON 
( NAME = N'PracaDyplomowa_log', 
FILENAME = N'Z:PracaDyplomowa_log.ldf' , 
SIZE = 50MB , 
MAXSIZE = 100MB , 
FILEGROWTH = 10MB )
GO

-- Tworzenie tabel

USE PracaDyplomowa

-- Tabela działy

CREATE TABLE Dzialy(
	ID_Dzial char(3) NOT NULL PRIMARY KEY,
	Nazwa varchar(30) NOT NULL,
	Opis text NULL,
CONSTRAINT PK_ID_Dzial PRIMARY KEY (ID_Dzial)
)
GO

-- Tabela pracownicy

CREATE TABLE Pracownicy(
	ID_Pracownik int NOT NULL,
	Imie varchar(20) NOT NULL,
	Nazwisko varchar(20) NOT NULL,
	Stanowisko varchar(30) NOT NULL,
	Ulica varchar(30) NOT NULL,
	Miasto varchar(20) NOT NULL,
	KodPocztowy varchar(10) NOT NULL,
	Kraj varchar(20) NOT NULL,
	NumerTelefonu char(9) NULL,
	PESEL char(11) NOT NULL,
	StatusZatrudnienia varchar(11) NOT NULL,
	ID_Dzial char(3) NOT NULL,
CONSTRAINT PK_Pracownicy PRIMARY KEY (ID_Pracownik),
CONSTRAINT FK_Pracownicy_Dzialy FOREIGN KEY (ID_Dzial)
REFERENCES Dzialy (ID_Dzial)
)
GO

ALTER TABLE Pracownicy 
ADD  CONSTRAINT df_zatrudniony  DEFAULT ('Zatrudniony') FOR [StatusZatrudnienia]
GO

ALTER TABLE Pracownicy
ADD CONSTRAINT chk_status CHECK  ((StatusZatrudnienia='Zatrudniony' OR StatusZatrudnienia='Zwolniony'))
GO

ALTER TABLE Pracownicy  
ADD CHECK  ((NumerTelefonu LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

ALTER TABLE Pracownicy 
ADD CHECK  ((PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

-- Tabela typy gości

CREATE TABLE TypyGosci(
	ID_TypGoscia int NOT NULL,
	Typ varchar(40) NOT NULL,
 CONSTRAINT PK_TypyGosci PRIMARY KEY (ID_TypGoscia)
)
GO

-- Tabela typy pokoi

CREATE TABLE TypyPokoi(
	ID_TypPokoju int NOT NULL,
	Typ varchar(30) NOT NULL,
	Cena float NOT NULL,
	Opis text NULL,
 CONSTRAINT PK_TypyPokoi PRIMARY KEY (ID_TypPokoju)
)
GO

ALTER TABLE TypyPokoi 
ADD CHECK ((Cena>(0)))
GO

-- Tabela statusy pokoju

CREATE TABLE StatusyPokoju(
	ID_StatusPokoju int NOT NULL,
	StatusPokoju varchar(30) NOT NULL,
	Opis text NULL,
 CONSTRAINT PK_StatusyPokoju PRIMARY KEY (ID_StatusPokoju)
)
GO

-- Tabela pokoje

CREATE TABLE Pokoje(
	ID_Pokoj int NOT NULL,
	Pietro varchar(2) NOT NULL,
	ID_TypPokoju int NOT NULL,
	NrPokoju varchar(2) NOT NULL,
	ID_StatusPokoju int NOT NULL,
 CONSTRAINT PK_Pokoje PRIMARY KEY (ID_Pokoj)
)
GO

ALTER TABLE Pokoje
ADD CONSTRAINT FK_Pokoje_Typ FOREIGN KEY (ID_TypPokoju)
REFERENCES TypyPokoi (ID_TypPokoju)
GO

ALTER TABLE Pokoje
ADD CONSTRAINT FK_Pokoje_StatusyPokoju FOREIGN KEY (ID_StatusPokoju)
REFERENCES StatusyPokoju (ID_StatusPokoju)
GO

-- Tabela goście

CREATE TABLE Goscie(
	ID_Gosc int IDENTITY(1,1) NOT NULL,
	Imie varchar(20) NOT NULL,
	Nazwisko varchar(20) NOT NULL,
	Ulica varchar(30) NOT NULL,
	Miasto varchar(20) NOT NULL,
	KodPocztowy varchar(10) NOT NULL,
	Kraj varchar(20) NOT NULL,
	NumerTelefonu char(12) NOT NULL,
	AdresEmail varchar(30) NULL,
	ID_TypGoscia int NOT NULL,
	PESEL/Paszport char(11) NOT NULL,
	DodatkoweInformacje xml NULL,
 CONSTRAINT PK_Goscie PRIMARY KEY (ID_Gosc)
)
GO

ALTER TABLE Goscie 
ADD CONSTRAINT FK_Goscie_TypyGosci FOREIGN KEY(ID_TypGoscia)
REFERENCES TypyGosci (ID_TypGoscia)
GO









