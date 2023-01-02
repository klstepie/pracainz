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
  )

-- Tabela pracownicy


