-- Początkowe tworzenie bazy danych

CREATE DATABASE PracaDyplomowa
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PracaDyplomowa', 
FILENAME = N'Z:PracaDyplomowa.mdf' , 
SIZE = 100MB , 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 64MB )
 LOG ON 
( NAME = N'PracaDyplomowa_log', 
FILENAME = N'Z:PracaDyplomowa_log.ldf' , 
SIZE = 50MB , 
MAXSIZE = 100MB , 
FILEGROWTH = 20MB )
GO

-- Tworzenie tabel

USE PracaDyplomowa

-- Tabela działy

CREATE TABLE Dzialy(
	ID_Dzial char(3) NOT NULL,
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
	[PESEL/Paszport] char(11) NOT NULL,
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

-- PROCEDURY

-- Awansowanie pracownika

CREATE PROCEDURE p_AwansujPracownika
@Id_Pracownik int,
@Stanowisko varchar(30)
AS
DECLARE @status_zatrudnienia varchar(11)
SET @status_zatrudnienia = (SELECT StatusZatrudnienia FROM Pracownicy WHERE ID_Pracownik = @Id_Pracownik)
IF(@Id_Pracownik IN (SELECT Id_Pracownik FROM Pracownicy) AND @status_zatrudnienia = 'Zatrudniony')
BEGIN
UPDATE Pracownicy
SET Stanowisko = @Stanowisko
WHERE @Id_Pracownik = ID_Pracownik
END
ELSE
BEGIN
RAISERROR ('Nieprawidłowy numer identyfikacyjny pracownika.',16,1)
END
GO

-- Dodawanie gościa do bazy danych

CREATE PROCEDURE p_DodajGoscia
@imie varchar(20),
@nazwisko varchar(20),
@ulica varchar(30),
@miasto varchar(20),
@kodpocztowy varchar(10),
@kraj varchar(20),
@numertelefonu char(12),
@typ int,
@nrdokumentu char(11),
@adresemail varchar(30) = null
AS
IF (@nrdokumentu NOT IN (SELECT [pesel/paszport] FROM Goscie))
BEGIN
INSERT INTO Goscie
(
imie,
nazwisko,
ulica ,
miasto,
kodpocztowy ,
kraj,
numertelefonu,
adresemail,
id_typgoscia,
[PESEL/Paszport]
)
VALUES (
@imie,
@nazwisko,
@ulica,
@miasto,
@kodpocztowy,
@kraj,
@numertelefonu,
@adresemail,
@typ,
@nrdokumentu
)
END
ELSE
BEGIN
RAISERROR ('Gość o tym nr dokumentu już istnieje w bazie!',16,1)
END
GO

-- Dodanie pokoju do rezerwacji

CREATE PROCEDURE p_DodajPokojDoRezerwacji
@id_rezerwacji int,
@id_pokoju int
AS
IF(@id_rezerwacji IN (SELECT ID_Rezerwacja FROM Rezerwacje) AND @id_pokoju IN (SELECT ID_Pokoj FROM Pokoje))
	BEGIN
	IF(@id_pokoju IN (SELECT ID_Pokoj FROM PokojeRezerwacja WHERE ID_Rezerwacja = @id_rezerwacji))
		BEGIN
		RAISERROR ('Numer identyfikacyjny pokoju już jest dodany do tej rezerwacji.',16,1)
		END
		ELSE
		BEGIN
		INSERT INTO PokojeRezerwacja
		(
		ID_Rezerwacja,
		ID_Pokoj
		)
		VALUES
		(
		@id_rezerwacji,
		@id_pokoju
		)
		END
	END
	ELSE
	BEGIN
	RAISERROR ('Nieprawidłowy numer identyfikacyjny rezerwacji/pokoju.',16,1)
	END
GO

-- Dodanie pracownika

CREATE PROCEDURE p_DodajPracownika 
@Id_Pracownik int, 
@Imie varchar(20), 
@Nazwisko varchar(20), 
@Stanowisko varchar(30), 
@Ulica varchar(30), 
@Miasto varchar(20), 
@KodPocztowy varchar(10), 
@Kraj varchar(20),
@NumerTelefonu char(9), 
@PESEL char(11),
@ID_Dzial char(3)
AS
BEGIN
IF(@Id_Pracownik IN (SELECT Id_Pracownik FROM Pracownicy))
BEGIN
RAISERROR ('Podany numer identyfikacyjny pracownika już istnieje w bazie danych.',16,1)
END
ELSE
BEGIN
IF(@PESEL IN (SELECT PESEL FROM Pracownicy))
BEGIN
RAISERROR ('Podany numer PESEL już istnieje w bazie danych.',16,1)
END
ELSE
BEGIN
INSERT INTO Pracownicy
(
Id_Pracownik, 
Imie, 
Nazwisko, 
Stanowisko, 
Ulica, 
Miasto, 
KodPocztowy, 
Kraj,
NumerTelefonu, 
PESEL,
ID_Dzial
)
VALUES (
@Id_Pracownik, 
@Imie, 
@Nazwisko, 
@Stanowisko, 
@Ulica, 
@Miasto, 
@KodPocztowy, 
@Kraj,
@NumerTelefonu, 
@PESEL,
@ID_Dzial
)
END
END
END
GO

-- Dodanie rezerwacji

CREATE PROCEDURE p_DodajRezerwacje
@ID_Gosc int, 
@DataOd smalldatetime, 
@DataDo smalldatetime, 
@LiczbaPokoi int, 
@LiczbaGosci int 
AS

IF(@ID_Gosc IN (SELECT Id_Gosc FROM Goscie))
BEGIN
	IF(@DataOd < @DataDo AND @DataOd != @DataDo)
	BEGIN
	DECLARE @status int = 2
	DECLARE @datarezerwacji smalldatetime = GETDATE()
	INSERT INTO Rezerwacje
	(
	ID_Gosc, 
	DataOd,
	DataDo,
	LiczbaPokoi,
	ID_StatusRezerwacji,
	DataRezerwacji,
	LiczbaGosci
	)
	VALUES (
	@ID_Gosc,
	@DataOd,
	@DataDo,
	@LiczbaPokoi,
	@status,
	@datarezerwacji,
	@LiczbaGosci
	)

	SELECT 
	ID_Rezerwacja,
	G.Imie,
	G.Nazwisko,
	DataOd,
	DataDo,
	LiczbaPokoi,
	LiczbaGosci
	FROM Rezerwacje R
	JOIN Goscie G
	ON R.ID_Gosc = G.ID_Gosc
	WHERE R.ID_Gosc = @ID_Gosc
	END
	ELSE
	BEGIN
	RAISERROR ('Wpisano złą datę!',16,1)
	END
END
ELSE
BEGIN
RAISERROR ('Nie ma takiego gościa.',16,1)
END
GO

-- Generowanie zestawienia usług

CREATE procedure p_GenerujZestawienieUslug
@id_rezerwacja int
AS
BEGIN
	IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
		BEGIN
		SELECT R.ID_Rezerwacja, TP.Typ AS 'Nazwa usługi', R.DataOd AS 'Data rozpoczęcia usługi', 
		R.DataDo AS 'Data zakończenia usługi', 
		DATEDIFF(DAY,R.DataOd,R.DataDo) AS 'Ilość','D' AS 'Jednostka miary',
		TP.Cena AS 'Cena jednostkowa brutto',TP.Cena * (DATEDIFF(DAY,R.DataOd,R.DataDo)) AS 'Kwota brutto'
		INTO #TempZestawieniePobytu
		FROM Rezerwacje R
		JOIN PokojeRezerwacja PR
		ON R.ID_Rezerwacja = PR.ID_Rezerwacja
		JOIN Pokoje P
		ON P.ID_Pokoj = PR.ID_Pokoj
		JOIN TypyPokoi TP
		ON TP.ID_TypPokoju = P.ID_TypPokoju
		SELECT R.ID_Rezerwacja, U.Nazwa AS 'Nazwa usługi', RU.DataRozpoczecia AS 'Data rozpoczęcia usługi', 
		RU.DataZakonczenia AS 'Data zakończenia usługi', 
		CASE
		WHEN U.JednostkaCzasu = 'H' THEN DATEDIFF(HOUR,RU.DataRozpoczecia,RU.DataZakonczenia) 
		WHEN U.JednostkaCzasu = 'D' THEN DATEDIFF(DAY,RU.DataRozpoczecia,RU.DataZakonczenia) 
		END AS 'Ilość',
		U.JednostkaCzasu AS 'Jednostka miary',
		U.Cena AS 'Cena jednostkowa brutto',
		CASE
		WHEN U.JednostkaCzasu = 'H' THEN U.Cena * DATEDIFF(HOUR,RU.DataRozpoczecia,RU.DataZakonczenia) 
		WHEN U.JednostkaCzasu = 'D' THEN U.Cena * DATEDIFF(DAY,RU.DataRozpoczecia,RU.DataZakonczenia) 
		END AS 'Kwota brutto'
		INTO #TempZestawienieUslug
		FROM Rezerwacje R
		JOIN RezerwacjaUslug RU
		ON RU.ID_Rezerwacja = R.ID_Rezerwacja
		JOIN Uslugi U
		ON U.ID_Usluga = RU.ID_Usluga

		CREATE TABLE #KoncoweZestawienie(
		ID_Rezerwacja int,
		[Nazwa usługi/Pokoju] varchar(50),
		[Data rozpoczęcia usługi] smalldatetime,
		[Data zakończenia usługi] smalldatetime,
		[Ilość] INT,
		[Jednostka miary] CHAR(1),
		[Cena jednostkowa brutto] FLOAT,
		[Kwota brutto] FLOAT
		)

		INSERT INTO #KoncoweZestawienie
		SELECT *
		FROM #TempZestawienieUslug
		UNION ALL
		SELECT *
		FROM #TempZestawieniePobytu

		SELECT *
		FROM #KoncoweZestawienie
		WHERE id_rezerwacja = @id_rezerwacja

		DROP TABLE #TempZestawieniePobytu
		DROP TABLE #TempZestawienieUslug
		DROP TABLE #KoncoweZestawienie
		END
	ELSE
	BEGIN
	RAISERROR ('Nieprawidłowy nr rezerwacji.',16,1)
	END
GO
-- Zameldowanie gościa

CREATE PROCEDURE p_MeldujGoscia
@id_rezerwacja int,
@id_pokoj int,
@status int = 2
AS
DECLARE @dataOd date;
DECLARE @dataDo date;
DECLARE @id_pokrez int;

IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
BEGIN
	SET @id_pokrez = (SELECT Id_PokojRezerwacja 
	FROM PokojeRezerwacja 
	WHERE ID_Pokoj = @id_pokoj AND ID_Rezerwacja = @id_rezerwacja)
	IF(@id_pokrez IN (SELECT Id_PokojRezerwacja FROM PokojeRezerwacja))
	BEGIN
		IF(@status = 2 OR @status = 4)
		BEGIN
        SET @dataOd = (
			SELECT DataOd
		FROM Rezerwacje
			WHERE ID_Rezerwacja = @id_rezerwacja
		)
		SET @dataDo = (
			SELECT DataDo
			FROM Rezerwacje
			WHERE ID_Rezerwacja = @id_rezerwacja
			)

		IF (GETDATE() BETWEEN @dataOd AND @dataDo)
				  BEGIN
					UPDATE Pokoje
					SET ID_StatusPokoju = @status
				WHERE ID_Pokoj = @id_pokoj
				 END
				  ELSE
				 BEGIN
				RAISERROR ('Gość przyjechał nie w tym terminie, który rezerwował.',16,1)
			END
			END
			ELSE
			BEGIN
			RAISERROR ('Nieprawidłowy nr statusu.',16,1)
			END
	END
	ELSE
	BEGIN
	RAISERROR ('Nieprawidłowy nr pokoju.',16,1)
	END
END
ELSE
BEGIN
RAISERROR ('Nieprawidłowy nr rezerwacji.',16,1)
END
GO

-- Odbieranie zapłaty

CREATE PROCEDURE p_OdbierzZaplate
@id_rezerwacja int,
@kwota float,
@metoda int
AS
IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
BEGIN
	DECLARE @naleznosc float
	DECLARE @dataplatnosci smalldatetime
	SET @dataplatnosci = (SELECT DataDokonaniaPlatnosci FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
	IF(@dataplatnosci IS NULL)
	BEGIN
		set @naleznosc = (SELECT Calkowitakwotadozaplaty FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
		IF(@kwota = @naleznosc AND @metoda IN (SELECT id_metodaPlatnosci from MetodyPlatnosci))
		BEGIN
			UPDATE Platnosci
			SET DataDokonaniaPlatnosci = GETDATE(), ID_MetodaPlatnosci = @metoda
			WHERE ID_Rezerwacja = @id_rezerwacja
		END
		ELSE
		BEGIN
		RAISERROR ('Pobrano nieprawidłową kwotę./Wybrano nieprawidłową metodę płatności.',16,1)
		END
	END
	ELSE
	BEGIN
	RAISERROR ('Ten gość już dokonał płatności.',16,1)
	END
END
ELSE
BEGIN
	RAISERROR ('Nieprawidłowy nr rezerwacji.',16,1)
END
GO

-- Otwieranie płatności

CREATE PROCEDURE p_OtworzPlatnoscDoRezerwacji
@id_rezerwacja int,
@metoda int = 1
AS
IF(@id_rezerwacja IN (SELECT id_rezerwacja from Rezerwacje))
BEGIN
IF(@id_rezerwacja NOT IN (select id_rezerwacja from Platnosci))
BEGIN
	DECLARE @kwota float
	SET @kwota = (SELECT suma from v_KosztPobytu where id_rezerwacja = @id_rezerwacja)
	DECLARE @termin smalldatetime
	IF(@metoda = 2)
	BEGIN
	SET @termin = (Select DATEADD(DAY,14,DataDo) FROM Rezerwacje WHERE ID_Rezerwacja = @id_rezerwacja)
	END
	ELSE
	BEGIN
	SET @termin = (Select DataDo FROM Rezerwacje WHERE ID_Rezerwacja = @id_rezerwacja)
	END
	INSERT INTO Platnosci
	(
	ID_Rezerwacja,
	CalkowitaKwotaDoZaplaty,
	ID_MetodaPlatnosci,
	TerminPlatnosci
	)
	VALUES (
	@id_rezerwacja,
	@kwota,
	@metoda,
	@termin
	)
END
ELSE
BEGIN
RAISERROR ('Dla tej rezerwacji jest już płatność.',16,1)
END
END
ELSE 
BEGIN
RAISERROR ('Błąd id rezerwacji.',16,1)
END
GO

-- Przyjmowanie zadatku

CREATE PROCEDURE p_PrzyjmijZadatek
@id_rezerwacja int
AS
IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Platnosci) AND 
(SELECT Zadatek From Platnosci WHERE ID_Rezerwacja = @id_rezerwacja) IS NULL)
BEGIN
	DECLARE @poprawna_kwota float
	SET @poprawna_kwota = (SELECT CalkowitaKwotaDoZaplaty * 0.2 
	FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
	BEGIN
	UPDATE Platnosci
	SET Zadatek = @poprawna_kwota, CalkowitaKwotaDoZaplaty = (CalkowitaKwotaDoZaplaty - @poprawna_kwota)
	WHERE ID_Rezerwacja = @id_rezerwacja
	UPDATE Rezerwacje
	SET ID_StatusRezerwacji = 1
	WHERE ID_Rezerwacja = @id_rezerwacja
	END
END
ELSE
BEGIN
	RAISERROR ('Nie ma takiej rezerwacji.',1,1) 
END
GO

-- Rezerwowanie usług

CREATE PROCEDURE p_RezerwujUslugi
@ID_Rezerwacja int,
@ID_Usluga int,
@DataStart smalldatetime,
@DataStop smalldatetime,
@ID_Pracownik int,
@Opis text = NULL
AS 
IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
BEGIN
IF(@DataStart < @DataStop)
BEGIN
INSERT INTO RezerwacjaUslug 
(ID_Rezerwacja,
ID_Usluga,
DataRozpoczecia,
ID_Pracownik,
Opis,
DataZakonczenia
)
VALUES
(
@ID_Rezerwacja,
@ID_Usluga,
@DataStart,
@ID_Pracownik,
@Opis,
@DataStop
)
END
ELSE
BEGIN
RAISERROR ('Wpisano złą datę!',16,1)
END
END
ELSE
BEGIN
RAISERROR ('Nie ma takiej rezerwacji.',16,1)
END
GO

-- Podsumowanie usług dodatkowych

CREATE PROCEDURE p_SumujUslugiDodatkowe
@id_rezerwacja int
AS
IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
BEGIN
	DECLARE @status char(2)
	SET @status = (SELECT UslugiDodatkoweStatus FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
	IF(@status IS NULL)
	BEGIN
		DECLARE @kwota_uslug float
		SET @kwota_uslug = (SELECT SUM(KwotaDoZaplaty) FROM v_KosztUslug
		WHERE ID_Rezerwacja = @id_rezerwacja)
		IF(@kwota_uslug IS NOT NULL)
		BEGIN
			DECLARE @kwota_pobytu float
			SET @kwota_pobytu = (SELECT calkowitakwotadozaplaty FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
			DECLARE @calkowita_suma float
			SET @calkowita_suma = @kwota_pobytu + @kwota_uslug
			UPDATE Platnosci
			SET CalkowitaKwotaDoZaplaty = @calkowita_suma, UslugiDodatkoweStatus = 'OK'
			WHERE ID_Rezerwacja = @id_rezerwacja
		END
		ELSE
		BEGIN
		RAISERROR ('Ten gość nie korzystał z usług dodatkowych.',16,1)
		END
	END
	ELSE
	BEGIN
	RAISERROR ('Dla tej rezerwacji podsumowano już usługi dodatkowe.',16,1)
	END
END
ELSE
BEGIN
RAISERROR ('Nieprawidłowy nr rezerwacji.',16,1)
END
GO

-- Wymeldowanie gościa

CREATE PROCEDURE p_WymeldujGoscia
@id_rezerwacja int, @id_pokoj int
AS
DECLARE @status int = 3;
DECLARE @data_platnosci smalldatetime;
DECLARE @metoda int;
IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
BEGIN
	SET @data_platnosci = (
	SELECT DataDokonaniaPlatnosci
	FROM Platnosci
	WHERE ID_Rezerwacja = @id_rezerwacja
	)

	SET @metoda = (
	SELECT ID_MetodaPlatnosci
	FROM Platnosci
	WHERE ID_Rezerwacja = @id_rezerwacja
	)

	IF(@data_platnosci IS NOT NULL OR @metoda = 2 )
	BEGIN
		IF(@id_pokoj IN (SELECT ID_POKOJ FROM PokojeRezerwacja WHERE ID_Rezerwacja = @id_rezerwacja))
		BEGIN
		UPDATE Pokoje
		SET ID_StatusPokoju = @status
		WHERE ID_Pokoj = @id_pokoj
		END
		ELSE
		BEGIN
		RAISERROR ('Pokój o tym numerze identyfikacyjnym nie był przypisany do tej rezerwacji.',16,1)
		END
	END
	ELSE
	BEGIN
		RAISERROR ('Gość nie zapłacił za pobyt.',16,1)
	END
END
ELSE
BEGIN
RAISERROR ('Nieprawidłowy nr rezerwacji.',16,1)
END
GO

-- Wyszukiwanie wolnych pokoi


CREATE PROCEDURE p_WyszukajWolnePokoje
@dataOd smalldatetime,
@dataDo smalldatetime
AS
BEGIN
DECLARE @databiez date;
SET @databiez = (SELECT CAST(GETDATE() AS date))
	IF(@dataOd >= @databiez AND @dataDo > @databiez)
		BEGIN
		IF(@dataOd > @dataDo OR @dataOd = @dataDo)
			BEGIN
			RAISERROR('Nieprawidłowy zakres dat.',16,1)
			END
			ELSE
			BEGIN
			SELECT DISTINCT p.ID_Pokoj,P.Pietro,P.NrPokoju,tp.Typ
			FROM Pokoje AS P
			LEFT JOIN PokojeRezerwacja pr
			ON P.ID_Pokoj = pr.ID_Pokoj
			Join TypyPokoi AS tp
			ON tp.ID_TypPokoju = P.ID_TypPokoju
			LEFT Join Rezerwacje as R
			on R.ID_Rezerwacja = pr.ID_Rezerwacja
			WHERE P.ID_Pokoj NOT IN (
			SELECT p.ID_Pokoj
			FROM Pokoje AS P
			JOIN PokojeRezerwacja pr
			ON P.ID_Pokoj = pr.ID_Pokoj
			Join Rezerwacje as R
			on R.ID_Rezerwacja = pr.ID_Rezerwacja
			where
			R.DataOd BETWEEN @dataOd AND @dataDo 
			OR
			R.DataDo BETWEEN @dataOd AND @dataDo 
			OR
			@dataOd BETWEEN R.DataOd AND R.DataDo
			OR
			@dataDo  BETWEEN R.DataOd AND R.DataDo
			)
			END
		END
ELSE
BEGIN
RAISERROR('Nieprawidłowy zakres dat.',16,1)
END
END
GO


-- Zmiana daty przyjazdu gościa


CREATE PROCEDURE p_ZmienPrzyjazd
@id_rezerwacja int,
@data_przed_zmiana smalldatetime,
@data_po_zmianie smalldatetime
AS

DECLARE @rzeczywista_data_przed smalldatetime

IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
BEGIN
	
	SET @rzeczywista_data_przed = (
	SELECT DataOd
	FROM Rezerwacje
	WHERE ID_Rezerwacja = @id_rezerwacja
	)

	IF(@data_przed_zmiana = @rzeczywista_data_przed)
	BEGIN
		UPDATE Rezerwacje
		SET DataOd = @data_po_zmianie
		WHERE ID_Rezerwacja = @id_rezerwacja
		
		DECLARE @nowakwota float;
		SET @nowakwota = (SELECT suma FROM v_KosztPobytu WHERE id_rezerwacja = @id_rezerwacja)
		DECLARE @czyzadatek float;
		SET @czyzadatek = (SELECT Zadatek FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
		
		IF(@czyzadatek IS NOT NULL)
		BEGIN
		DECLARE @suma float;
		SET @suma = @nowakwota - @czyzadatek
		UPDATE Platnosci
		SET CalkowitaKwotaDoZaplaty = @suma
		WHERE ID_Rezerwacja = @id_rezerwacja
		END
		ELSE
		BEGIN
		UPDATE Platnosci
		SET CalkowitaKwotaDoZaplaty = @nowakwota
		WHERE ID_Rezerwacja = @id_rezerwacja
		END
	END
	ELSE
	BEGIN
		RAISERROR ('Pierwsza data pobytu gościa jest inna od wpisanej.',1,1)
	END
END
ELSE
BEGIN
RAISERROR ('Nieprawidłowy nr rezerwacji.',1,1)
END
GO

-- Zmiana daty wyjazdu gościa


CREATE PROCEDURE [dbo].[p_ZmienWyjazd]
@id_rezerwacja int,
@data_przed_zmiana smalldatetime,
@data_po_zmianie smalldatetime
AS

DECLARE @rzeczywista_data_przed smalldatetime

IF(@id_rezerwacja IN (SELECT id_rezerwacja FROM Rezerwacje))
BEGIN
	
	SET @rzeczywista_data_przed = (
	SELECT DataDo
	FROM Rezerwacje
	WHERE ID_Rezerwacja = @id_rezerwacja
	)

	IF(@data_przed_zmiana = @rzeczywista_data_przed)
	BEGIN
	 
		UPDATE Rezerwacje
		SET DataDo = @data_po_zmianie
		WHERE ID_Rezerwacja = @id_rezerwacja
		
		DECLARE @nowakwota float;
		SET @nowakwota = (SELECT suma FROM v_KosztPobytu WHERE id_rezerwacja = @id_rezerwacja)
		DECLARE @czyzadatek float;
		SET @czyzadatek = (SELECT Zadatek FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
		DECLARE @termin smalldatetime;
		DECLARE @metoda int;
		SET @metoda = (SELECT ID_MetodaPlatnosci FROM Platnosci WHERE ID_Rezerwacja = @id_rezerwacja)
		
		IF(@czyzadatek IS NOT NULL)
		BEGIN
		DECLARE @suma float;
		SET @suma = @nowakwota - @czyzadatek
		UPDATE Platnosci
		SET CalkowitaKwotaDoZaplaty = @suma
		WHERE ID_Rezerwacja = @id_rezerwacja
		END
		ELSE
		BEGIN
		UPDATE Platnosci
		SET CalkowitaKwotaDoZaplaty = @nowakwota
		WHERE ID_Rezerwacja = @id_rezerwacja
		END
		
		IF(@metoda = 2)
		BEGIN
		SET @termin = (Select DATEADD(DAY,14,DataDo) From Rezerwacje where ID_Rezerwacja = @id_rezerwacja)
		UPDATE Platnosci
		SET TerminPlatnosci = @termin
		WHERE ID_Rezerwacja = @id_rezerwacja
		END
		ELSE
		BEGIN
		set @termin = (Select DataDo From Rezerwacje where ID_Rezerwacja = @id_rezerwacja)
		UPDATE Platnosci
		SET TerminPlatnosci = @termin
		WHERE ID_Rezerwacja = @id_rezerwacja
		END
	END
	ELSE
	BEGIN
		RAISERROR ('Pierwsza data pobytu gościa jest inna od wpisanej.',1,1)
	END
END
ELSE
BEGIN
RAISERROR ('Nieprawidłowy nr rezerwacji.',1,1)
END
GO

-- Zwolnienie pracownika

CREATE PROCEDURE p_ZwolnijPracownika
@Id_Pracownik int
AS
DECLARE @status_zatrudnienia varchar(11)
SET @status_zatrudnienia = (SELECT StatusZatrudnienia FROM Pracownicy WHERE ID_Pracownik = @Id_Pracownik)
IF(@Id_Pracownik IN (SELECT Id_Pracownik FROM Pracownicy) AND @status_zatrudnienia = 'Zatrudniony')
BEGIN
UPDATE Pracownicy
SET StatusZatrudnienia = 'Zwolniony'
WHERE ID_Pracownik = @Id_Pracownik
END
ELSE
BEGIN
	RAISERROR ('Nieprawidłowy numer identyfikacyjny pracownika.',16,1)
END
GO

-- Wygenerowanie raportu USALI (Pokoje)

CREATE PROCEDURE sp_GenerujRaportPokoje
AS
BEGIN
DECLARE @liczba_pokoi int
SET @liczba_pokoi = (Select COUNT(*) from Pokoje)
DECLARE @rok INT = YEAR(GETDATE());
DECLARE @LiczbaDni INT
SET @liczbadni = (SELECT DATEDIFF(DAY, DATEFROMPARTS(YEAR(@rok),1,1), DATEFROMPARTS(YEAR(@rok) + 1,1,1)))
DECLARE @sprzedane_pokoje INT;
SET @sprzedane_pokoje = (
SELECT SUM(DATEDIFF(DAY,DataOd,DataDo)) AS 'DniZarezerwowanychPokoi'
FROM PokojeRezerwacja AS PR
JOIN Rezerwacje AS R
ON PR.ID_Rezerwacja = R.ID_Rezerwacja
WHERE YEAR(DataOd) = YEAR(GETDATE()))

-- FP
DECLARE @FP float
SET @FP = (SELECT CAST(@sprzedane_pokoje AS decimal(7,2)) / CAST((@LiczbaDni * @liczba_pokoi) AS decimal(7,2)) * 100.0)

-- AVERAGE RATE
DECLARE @suma_sprzedaz float;
SET @suma_sprzedaz = (
SELECT SUM(SUMA) 
FROM v_KosztPobytu
JOIN Rezerwacje r
ON r.ID_Rezerwacja = v_KosztPobytu.ID_Rezerwacja
WHERE YEAR(DataOd) = YEAR(GETDATE()))
DECLARE @ADR float;
SET @ADR = @suma_sprzedaz / @sprzedane_pokoje ;
DECLARE @RevPar float;
SET @RevPar = @ADR * @FP
DECLARE @cs float;
SET @cs = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'CS' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'SP1'
)
DECLARE @l float;
SET @l = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'L' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'SP1'
)
DECLARE @ladc float;
SET @ladc = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'LADC' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'SP1'
)

DECLARE @sag float;
SET @sag = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'SAG' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'SP1'
)

DECLARE @totalexpenses float;
SET @totalexpenses = (
SELECT SUM(KWOTA) FROM Wydatki WHERE YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'SP1'
)
DECLARE @zysk float;
SET @zysk = @suma_sprzedaz - @totalexpenses

DECLARE @dokument xml
SET @dokument = (
SELECT CAST(@FP AS decimal(7,2)) AS 'WskaznikWykorzystaniaPokoi',
@liczba_pokoi AS 'LiczbaPokoi',
CAST(@ADR AS decimal(7,2)) AS 'SredniaCenaPokoju', 
CAST(@RevPar AS decimal(7,2)) AS 'RevPar', 
CAST(@suma_sprzedaz AS decimal(7,2)) AS 'CalkowityDochod', 
CAST(@cs AS decimal(7,2)) AS 'Wydatki/SrodkiCzystosci', 
CAST(@l AS decimal(7,2)) AS 'Wydatki/PoscielReczniki', 
CAST(@ladc AS decimal(7,2)) AS 'Wydatki/PralniaSuszarnia',
CAST(@sag AS decimal(7,2)) AS 'Wydatki/UslugiKomplementarne', 
CAST(@totalexpenses AS decimal(7,2)) AS 'Wydatki/SumaWydatkow',  
CAST(@zysk AS decimal(7,2)) AS 'Zysk'
FOR XML PATH ('Pokoje'), ELEMENTS
)
INSERT INTO RaportyUSALI
VALUES ('U1',@dokument,GETDATE())

-- Wygenerowanie raportu USALI (Spa&Wellness)

CREATE PROCEDURE sp_GenerujSpaWellness
AS
BEGIN
DECLARE @basen float;
SET @basen = (SELECT SUM(SumaUslug)
FROM v_SumaUslugNaRezerwacje AS SU
JOIN Rezerwacje AS R
ON R.ID_Rezerwacja = SU.ID_Rezerwacja
WHERE SU.ID_Usluga = 2 AND YEAR(R.DataOD) = YEAR(GETDATE())
)

IF (@basen IS NULL) SET @basen = 0.0

DECLARE @pielegnacjaskory float;
SET @pielegnacjaskory = (
SELECT SUM(SumaUslug)
FROM v_SumaUslugNaRezerwacje AS SU
JOIN Rezerwacje AS R
ON R.ID_Rezerwacja = SU.ID_Rezerwacja
WHERE SU.ID_Usluga = 11 AND YEAR(R.DataOD) = YEAR(GETDATE())
)

IF (@pielegnacjaskory IS NULL) SET @pielegnacjaskory= 0.0

DECLARE @zabieginacialo float;
SET @zabieginacialo = (
SELECT SUM(SumaUslug)
FROM v_SumaUslugNaRezerwacje AS SU
JOIN Rezerwacje AS R
ON R.ID_Rezerwacja = SU.ID_Rezerwacja
WHERE SU.ID_Usluga IN (1,3,7,8,9,10) AND YEAR(R.DataOD) = YEAR(GETDATE())
)

IF (@zabieginacialo IS NULL) SET @zabieginacialo = 0.0

DECLARE @suma_sprzedaz float;
SET @suma_sprzedaz = @basen + @pielegnacjaskory + @zabieginacialo;

DECLARE @cs float;
SET @cs = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'CS' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'UD1'
)
DECLARE @l float;
SET @l = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'L' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'UD1'
)
DECLARE @ladc float;
SET @ladc = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'LADC' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'UD1'
)

DECLARE @sag float;
SET @sag = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'SAG' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'UD1'
)
DECLARE @sp float;
SET @sp = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'SP' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'UD1'
)

DECLARE @habp float;
SET @habp = (
SELECT SUM(KWOTA) FROM Wydatki WHERE ID_KodWydatku = 'HABP' AND YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'UD1'
)

DECLARE @totalexpenses float;
SET @totalexpenses = (
SELECT SUM(KWOTA) FROM Wydatki WHERE YEAR(DataZakupu) = YEAR(GETDATE()) AND ID_Dzial = 'UD1'
)

DECLARE @zysk float;
SET @zysk = @suma_sprzedaz - @totalexpenses

DECLARE @dokument xml
SET @dokument = (
SELECT CAST(@basen AS decimal(7,2)) AS 'Dochod/Basen', 
CAST(@pielegnacjaskory AS decimal(7,2)) AS 'Dochod/PielegnacjaSkory', 
CAST(@zabieginacialo AS decimal(7,2)) AS 'Dochod/ZabiegiNaCialo',
CAST(@suma_sprzedaz AS decimal(7,2)) AS 'Dochod/CalkowityDochod', 
CAST(@cs AS decimal(7,2)) AS 'Wydatki/SrodkiCzystosci', 
CAST(@l AS decimal(7,2)) AS 'Wydatki/PoscielReczniki', 
CAST(@ladc AS decimal(7,2)) AS 'Wydatki/PralniaSuszarnia',
CAST(@sag AS decimal(7,2)) AS 'Wydatki/UslugiKomplementarne', 
CAST(@SP AS decimal(7,2)) AS 'Wydatki/UtrzymanieBasenu', 
CAST(@habp AS decimal(7,2)) AS 'Wydatki/Kosmetyki', 
CAST(@totalexpenses AS decimal(7,2)) AS 'Wydatki/SumaWydatkow',  
CAST(@zysk AS decimal(7,2)) AS 'Zysk'
FOR XML PATH ('SpaIWellness'), ELEMENTS
)
INSERT INTO RaportyUSALI
VALUES ('U2',@dokument,GETDATE())

END
GO

-- Użytkownicy (Login, użytkownicy i uprawnienia)

CREATE LOGIN ADMIN 
WITH PASSWORD=N'uzfYJA8xzkFbSJ9Nu8An6sooE9muP8ldcF7jy4CL2Kk=',
DEFAULT_DATABASE=[PracaDyplomowa]
GO
CREATE LOGIN RECEPCJA 
WITH PASSWORD=N'3K2rA/SSrK/t3vudWMJtxB2jBRluEqVTKXiha4QBybQ=',
DEFAULT_DATABASE=[PracaDyplomowa]
GO
CREATE LOGIN PERSONEL WITH PASSWORD=N'vAXiDswg/BuOedq7+JaJD2DKn878EhXj4s0DKHSLUjY=',
DEFAULT_DATABASE=[PracaDyplomowa]
GO
CREATE LOGIN KLIENT WITH PASSWORD=N'bN9dOH59tUVJhNfezTmtCnftJYvVINyvKDjFMmGvryI=',
DEFAULT_DATABASE=[PracaDyplomowa]
GO
CREATE LOGIN [KADRY] WITH PASSWORD=N'G4OIQzRpUS5giAmC/AP+X6m47aGJVONlyRM4Ez6Lys8=',
DEFAULT_DATABASE=[PracaDyplomowa]
GO
CREATE USER [RECEPCJA] FOR LOGIN [RECEPCJA] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [PERSONEL] FOR LOGIN [PERSONEL] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [KLIENT] FOR LOGIN [KLIENT] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [KADRY] FOR LOGIN [KADRY] WITH DEFAULT_SCHEMA=[dbo]
GO










