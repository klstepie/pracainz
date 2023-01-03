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

-- Tabela statusy rezerwacji

CREATE TABLE StatusyRezerwacji(
	ID_StatusRezerwacji int NOT NULL,
	StatusRezerwacji varchar(15) NOT NULL,
	Opis text NULL,
 CONSTRAINT PK_StatusyRezerwacji PRIMARY KEY (ID_StatusRezerwacji) 
)
GO

-- Tabela rezerwacje

CREATE TABLE Rezerwacje(
	ID_Rezerwacja int IDENTITY(1,1) NOT NULL,
	ID_Gosc int NOT NULL,
	DataOd smalldatetime NOT NULL,
	DataDo smalldatetime NOT NULL,
	LiczbaPokoi int NOT NULL,
	ID_StatusRezerwacji int NOT NULL,
	DataRezerwacji smalldatetime NOT NULL,
	LiczbaGosci int NOT NULL,
 CONSTRAINT PK_Rezerwacje PRIMARY KEY (ID_Rezerwacja)
)
GO

ALTER TABLE Rezerwacje 
ADD  CONSTRAINT FK_Rezerwacje_Goscie FOREIGN KEY(ID_Gosc)
REFERENCES Goscie (ID_Gosc)
GO

ALTER TABLE Rezerwacje 
ADD  CONSTRAINT FK_Rezerwacje_StatusyRezerwacji FOREIGN KEY(ID_StatusRezerwacji)
REFERENCES StatusyRezerwacji (ID_StatusRezerwacji)
GO

ALTER TABLE Rezerwacje 
ADD CHECK ((DataOd<DataDo))
GO

-- Tabela pokoje - rezerwacja

CREATE TABLE PokojeRezerwacja(
	ID_Rezerwacja int NOT NULL,
	ID_Pokoj int NOT NULL,
	Id_PokojRezerwacja int IDENTITY(1,1) NOT NULL,
	CONSTRAINT PK_PokojeRezerwacja PRIMARY KEY (Id_PokojRezerwacja)
)
GO

ALTER TABLE PokojeRezerwacja 
ADD  CONSTRAINT FK_PokojeRezerwacja_Pokoje FOREIGN KEY(ID_Pokoj)
REFERENCES Pokoje (ID_Pokoj)
GO

ALTER TABLE PokojeRezerwacja 
ADD  CONSTRAINT FK_PokojeRezerwacja_Rezerwacje FOREIGN KEY(ID_Rezerwacja)
REFERENCES Rezerwacje (ID_Rezerwacja)
GO

-- Tabela metody płatności

CREATE TABLE MetodyPlatnosci(
	ID_MetodaPlatnosci int NOT NULL,
	Metoda varchar(20) NOT NULL,
 CONSTRAINT PK_MetodyPlatnosci PRIMARY KEY (ID_MetodaPlatnosci)
)
GO

-- Tabela płatności

CREATE TABLE Platnosci(
	ID_Platnosc int IDENTITY(1,1) NOT NULL,
	ID_Rezerwacja int NOT NULL,
	CalkowitaKwotaDoZaplaty float NOT NULL,
	ID_MetodaPlatnosci int NOT NULL,
	TerminPlatnosci smalldatetime NOT NULL,
	DataDokonaniaPlatnosci smalldatetime NULL,
	Zadatek float NULL,
	UslugiDodatkoweStatus char(2) NULL,
 CONSTRAINT PK_Platnosci PRIMARY KEY (ID_Platnosc) 
)
GO

ALTER TABLE Platnosci
ADD  CONSTRAINT FK_Platnosci_MetodyPlatnosci FOREIGN KEY(ID_MetodaPlatnosci)
REFERENCES MetodyPlatnosci (ID_MetodaPlatnosci)
GO

ALTER TABLE Platnosci 
ADD  CONSTRAINT FK_Platnosci_Rezerwacje FOREIGN KEY(ID_Rezerwacja)
REFERENCES Rezerwacje (ID_Rezerwacja)
GO

ALTER TABLE Platnosci 
ADD CONSTRAINT UNQ_ST_ID_Rezerwacja UNIQUE (ID_Rezerwacja)
GO

-- Tabela usługi 

CREATE TABLE Uslugi(
	ID_Usluga int NOT NULL,
	Nazwa varchar(50) NOT NULL,
	Cena float NOT NULL,
	JednostkaCzasu char(1) NOT NULL,
	Opis text NULL,
	InformacjeDodatkowe xml NULL,
 CONSTRAINT PK_Uslugi PRIMARY KEY (ID_Usluga)
)
GO

ALTER TABLE Uslugi 
ADD CHECK  ((Cena>(0)))
GO

-- Tabela rezerwacja usług

CREATE TABLE RezerwacjaUslug(
	ID_Rezerwacja int NOT NULL,
	ID_Usluga int NOT NULL,
	DataRozpoczecia smalldatetime NOT NULL,
	ID_Pracownik int NOT NULL,
	Opis text NULL,
	DataZakonczenia smalldatetime NOT NULL,
	ID_RezerwacjaUslugi int IDENTITY(1,1) NOT NULL,
CONSTRAINT PK_RezerwacjaUslug PRIMARY KEY (ID_RezerwacjaUslugi)
)

ALTER TABLE RezerwacjaUslug 
ADD  CONSTRAINT FK_RezerwacjaUslug_Pracownicy FOREIGN KEY(ID_Pracownik)
REFERENCES Pracownicy (ID_Pracownik)
GO

ALTER TABLE RezerwacjaUslug  
ADD  CONSTRAINT FK_RezerwacjaUslug_Rezerwacje FOREIGN KEY(ID_Rezerwacja)
REFERENCES Rezerwacje (ID_Rezerwacja)
GO

ALTER TABLE RezerwacjaUslug  
ADD  CONSTRAINT FK_RezerwacjaUslug_Uslugi FOREIGN KEY(ID_Usluga)
REFERENCES Uslugi (ID_Usluga)
GO

ALTER TABLE RezerwacjaUslug
ADD CHECK  ((DataRozpoczecia<DataZakonczenia))
GO

-- Tabela typy wydatków

CREATE TABLE TypyWydatkow(
	ID_KodWydatku char(4) NOT NULL,
	Nazwa varchar(30) NOT NULL,
	Opis text NULL,
 CONSTRAINT PK_ID_KodWydatku PRIMARY KEY (ID_KodWydatku)
)
GO

-- Tabela wydatki

CREATE TABLE Wydatki(
	ID_Wydatek int IDENTITY(1,1) NOT NULL,
	ID_Dzial char(3) NOT NULL,
	ID_KodWydatku char(4) NOT NULL,
	Kwota float NOT NULL,
	DataZakupu smalldatetime NOT NULL,
	InformacjeDodatkowe text NULL,
 CONSTRAINT PK_Wydatek PRIMARY KEY (ID_Wydatek)
)
GO

ALTER TABLE Wydatki
ADD  CONSTRAINT FK_Wydatki_Dzial FOREIGN KEY(ID_Dzial)
REFERENCES Dzialy (ID_Dzial)
GO

ALTER TABLE Wydatki
ADD  CONSTRAINT FK_Wydatki_TypyWydatkow FOREIGN KEY(ID_KodWydatku)
REFERENCES TypyWydatkow (ID_KodWydatku)
GO

-- Tabela typy raportów

CREATE TABLE TypyRaportow(
	ID_TypRaportu char(2) NOT NULL,
	Nazwa varchar(20) NOT NULL,
	Opis text NULL,
 CONSTRAINT PK_TypyRaportow PRIMARY KEY (ID_TypRaportu) 
)
GO

-- Tabela raporty USALI

CREATE TABLE RaportyUSALI(
	ID_Raport int IDENTITY(1,1) NOT NULL,
	ID_TypRaportu char(2) NOT NULL,
	Raport xml NOT NULL,
	DataRaportu smalldatetime NOT NULL,
 CONSTRAINT PK_RaportyUsali PRIMARY KEY (ID_Raport)
)
GO

ALTER TABLE RaportyUSALI 
ADD  CONSTRAINT FK_RaportyUsali_TypyRaportow FOREIGN KEY(ID_TypRaportu)
REFERENCES TypyRaportow (ID_TypRaportu)
GO


-- WIDOKI

-- Wolne pokoje

CREATE VIEW v_WolnePokoje AS
SELECT P.ID_Pokoj, P.Pietro,tp.Typ,P.NrPokoju,sp.StatusPokoju
FROM Pokoje AS P
JOIN TypyPokoi AS tp
ON tp.ID_TypPokoju = P.ID_TypPokoju
JOIN StatusyPokoju AS sp
ON sp.ID_StatusPokoju = P.ID_StatusPokoju
WHERE sp.ID_StatusPokoju = 1 OR sp.ID_StatusPokoju = 3
GO

-- Statusy pokoi

CREATE VIEW v_StatusyPokoi
AS
SELECT P.ID_Pokoj, P.Pietro,tp.Typ,P.NrPokoju,sp.StatusPokoju
FROM Pokoje AS P
JOIN TypyPokoi AS tp
ON tp.ID_TypPokoju = P.ID_TypPokoju
JOIN StatusyPokoju AS sp
ON sp.ID_StatusPokoju = P.ID_StatusPokoju

-- Rezerwacje opłacone

CREATE VIEW V_RezerwacjeOplacone AS 
SELECT p.ID_Rezerwacja, g.Imie, g.Nazwisko,g.Ulica + ' ' + g.KodPocztowy + ' ' + g.Miasto AS Adres, 
Po.NrPokoju, CONVERT(varchar,R.DataOd,105) AS 'Przyjazd', CONVERT(varchar,R.DataDo,105) AS 'Wyjazd',
p.CalkowitaKwotaDoZaplaty, p.TerminPlatnosci, p.DataDokonaniaPlatnosci, m.Metoda
FROM Platnosci AS p
JOIN Rezerwacje AS r
ON r.ID_Rezerwacja = p.ID_Rezerwacja
JOIN Goscie AS G
ON g.id_gosc = r.id_gosc
JOIN PokojeRezerwacja AS PR
ON PR.ID_Rezerwacja = r.ID_Rezerwacja
JOIN Pokoje AS Po
ON po.ID_Pokoj = PR.ID_Pokoj
JOIN MetodyPlatnosci AS m
ON m.ID_MetodaPlatnosci = p.ID_MetodaPlatnosci
WHERE p.DataDokonaniaPlatnosci IS NOT NULL


-- Rezerwacje niezapłacone

CREATE VIEW v_RezerwacjeNiezaplacone AS
SELECT p.ID_Rezerwacja, g.Imie, g.Nazwisko,g.Ulica + ' ' + g.KodPocztowy + ' ' + g.Miasto AS Adres, 
Po.NrPokoju, CONVERT(varchar,R.DataOd,105) AS 'Przyjazd', CONVERT(varchar,R.DataDo,105) AS 'Wyjazd',
p.CalkowitaKwotaDoZaplaty, p.TerminPlatnosci, p.DataDokonaniaPlatnosci
FROM Platnosci AS p
JOIN Rezerwacje AS r
ON r.ID_Rezerwacja = p.ID_Rezerwacja
JOIN Goscie AS G
ON g.id_gosc = r.id_gosc
JOIN PokojeRezerwacja AS PR
ON PR.ID_Rezerwacja = r.ID_Rezerwacja
JOIN Pokoje AS Po
ON po.ID_Pokoj = PR.ID_Pokoj
WHERE p.DataDokonaniaPlatnosci IS NULL
GO

-- Pracownicy i ich stanowiska

CREATE VIEW 
v_PracownicyStanowiska
AS
SELECT ID_Pracownik,Imie,Nazwisko,Stanowisko
FROM Pracownicy
GO

-- Pracownicy i usługi, do których są przypisani

CREATE VIEW v_PracownicyRezerwacjaUslug
AS
SELECT P.ID_Pracownik, P.Imie + ' ' + P.Nazwisko AS 'Imie i nazwisko pracownika', 
P.Stanowisko, U.Nazwa AS 'Nazwa wykonywanej uslugi', 
CONVERT(varchar,RU.DataRozpoczecia,105) AS 'Data rozpoczecia', 
CONVERT(varchar,RU.DataRozpoczecia,8) AS 'Godzina rozpoczecia',
CONVERT(varchar,RU.DataZakonczenia,105) AS 'Data zakonczenia',
CONVERT(varchar,RU.DataZakonczenia,8) AS 'Godzina zakonczenia',
G.ID_Gosc,
G.Imie + ' ' + G.Nazwisko AS 'Imie i nazwisko goscia'
FROM Pracownicy AS P
JOIN RezerwacjaUslug AS RU
ON P.ID_Pracownik = RU.ID_Pracownik
JOIN Uslugi AS U
ON RU.ID_Usluga = U.ID_Usluga
JOIN Rezerwacje AS R
ON RU.ID_Rezerwacja = R.ID_Rezerwacja
JOIN Goscie AS G
ON G.ID_Gosc = R.ID_Rezerwacja
GO

-- Pokoje, które trzeba posprzątać

CREATE VIEW v_PokojeDoSprzatania AS
SELECT P.ID_Pokoj, P.Pietro,tp.Typ,P.NrPokoju,sp.StatusPokoju
FROM Pokoje AS P
JOIN TypyPokoi AS tp
ON tp.ID_TypPokoju = P.ID_TypPokoju
JOIN StatusyPokoju AS sp
ON sp.ID_StatusPokoju = P.ID_StatusPokoju
WHERE sp.ID_StatusPokoju = 4 OR sp.ID_StatusPokoju = 3
GO

-- Lista przyjazdów i wyjazdów

CREATE VIEW v_ListaPrzyjazdowiWyjazdow
AS
SELECT R.ID_Rezerwacja,G.Imie, G.Nazwisko, P.Pietro, P.NrPokoju,
CONVERT(varchar,R.DataOd,105) as 'Przyjazd', 
CONVERT(varchar,R.DataDo,105) as 'Wyjazd'
FROM Pokoje AS P
JOIN TypyPokoi AS TP
ON P.ID_TypPokoju = TP.ID_TypPokoju
JOIN PokojeRezerwacja AS PR
ON PR.ID_Pokoj = P.ID_Pokoj
JOIN Rezerwacje AS R
ON R.ID_Rezerwacja = PR.ID_Rezerwacja
JOIN Goscie AS G
ON G.ID_Gosc = R.ID_Gosc
WHERE R.DataOd >= CAST(GETDATE() AS date)
GO

-- Koszt pobytu (widok pomocniczy)

CREATE VIEW v_KosztPobytu
AS
SELECT R.ID_Rezerwacja,SUM(TP.Cena * CONVERT(int,DATEDIFF(DAY,R.DataOD,R.DataDo))) AS SUMA
FROM Pokoje AS P
JOIN TypyPokoi AS TP
ON TP.ID_TypPokoju = P.ID_TypPokoju
JOIN PokojeRezerwacja AS PR
ON PR.ID_Pokoj = P.ID_Pokoj
JOIN Rezerwacje AS R
ON R.ID_Rezerwacja = PR.ID_Rezerwacja
GROUP BY R.ID_Rezerwacja
GO

-- Koszt usług (widok pomocniczy)

CREATE VIEW v_KosztUslug AS
SELECT
RU.ID_Rezerwacja,RU.ID_Usluga,
CASE
WHEN U.JednostkaCzasu = 'D' THEN DATEDIFF(DAY,RU.DataRozpoczecia,RU.DataZakonczenia) * U.Cena
WHEN U.JednostkaCzasu = 'H' THEN DATEDIFF(HOUR,RU.DataRozpoczecia,RU.DataZakonczenia) * U.Cena
END AS KwotaDoZaplaty
FROM RezerwacjaUslug RU
JOIN Uslugi U
ON U.Id_Usluga = RU.Id_Usluga
GO

-- Obliczanie wartości usług na rezerwacje (widok pomocniczy)

CREATE VIEW v_SumaUslugNaRezerwacje
AS
SELECT ID_Rezerwacja, ID_Usluga, SUM(KwotaDoZaplaty) AS SumaUslug 
FROM v_KosztUslug
GROUP BY ID_Rezerwacja, ID_Usluga










