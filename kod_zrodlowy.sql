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

CREATE TABLE [dbo].[RezerwacjaUslug](
	[ID_Rezerwacja] [int] NOT NULL,
	[ID_Usluga] [int] NOT NULL,
	[DataRozpoczecia] [smalldatetime] NOT NULL,
	[ID_Pracownik] [int] NOT NULL,
	[Opis] [text] NULL,
	[DataZakonczenia] [smalldatetime] NOT NULL,
	[ID_RezerwacjaUslugi] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_RezerwacjaUslugi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[RezerwacjaUslug]  WITH CHECK ADD  CONSTRAINT [FK_RezerwacjaUslug_Pracownicy] FOREIGN KEY([ID_Pracownik])
REFERENCES [dbo].[Pracownicy] ([ID_Pracownik])
GO

ALTER TABLE [dbo].[RezerwacjaUslug] CHECK CONSTRAINT [FK_RezerwacjaUslug_Pracownicy]
GO

ALTER TABLE [dbo].[RezerwacjaUslug]  WITH CHECK ADD  CONSTRAINT [FK_RezerwacjaUslug_Rezerwacje] FOREIGN KEY([ID_Rezerwacja])
REFERENCES [dbo].[Rezerwacje] ([ID_Rezerwacja])
GO

ALTER TABLE [dbo].[RezerwacjaUslug] CHECK CONSTRAINT [FK_RezerwacjaUslug_Rezerwacje]
GO

ALTER TABLE [dbo].[RezerwacjaUslug]  WITH CHECK ADD  CONSTRAINT [FK_RezerwacjaUslug_Uslugi] FOREIGN KEY([ID_Usluga])
REFERENCES [dbo].[Uslugi] ([ID_Usluga])
GO

ALTER TABLE [dbo].[RezerwacjaUslug] CHECK CONSTRAINT [FK_RezerwacjaUslug_Uslugi]
GO

ALTER TABLE [dbo].[RezerwacjaUslug]  WITH CHECK ADD CHECK  (([DataRozpoczecia]<[DataZakonczenia]))
GO

-- Typy wydatków

CREATE TABLE [dbo].[TypyWydatkow](
	[ID_KodWydatku] [char](4) NOT NULL,
	[Nazwa] [varchar](30) NOT NULL,
	[Opis] [text] NULL,
 CONSTRAINT [PK_ID_KodWydatku] PRIMARY KEY CLUSTERED 
(
	[ID_KodWydatku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Wydatki

CREATE TABLE [dbo].[Wydatki](
	[ID_Wydatek] [int] IDENTITY(1,1) NOT NULL,
	[ID_Dzial] [char](3) NOT NULL,
	[ID_KodWydatku] [char](4) NOT NULL,
	[Kwota] [float] NOT NULL,
	[DataZakupu] [smalldatetime] NOT NULL,
	[InformacjeDodatkowe] [text] NULL,
 CONSTRAINT [PK_Wydatek] PRIMARY KEY CLUSTERED 
(
	[ID_Wydatek] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Wydatki]  WITH CHECK ADD  CONSTRAINT [FK_Wydatki_Dzial] FOREIGN KEY([ID_Dzial])
REFERENCES [dbo].[Dzialy] ([ID_Dzial])
GO

ALTER TABLE [dbo].[Wydatki] CHECK CONSTRAINT [FK_Wydatki_Dzial]
GO

ALTER TABLE [dbo].[Wydatki]  WITH CHECK ADD  CONSTRAINT [FK_Wydatki_TypyWydatkow] FOREIGN KEY([ID_KodWydatku])
REFERENCES [dbo].[TypyWydatkow] ([ID_KodWydatku])
GO

ALTER TABLE [dbo].[Wydatki] CHECK CONSTRAINT [FK_Wydatki_TypyWydatkow]

-- Typy raportów

CREATE TABLE [dbo].[TypyRaportow](
	[ID_TypRaportu] [char](2) NOT NULL,
	[Nazwa] [varchar](20) NOT NULL,
	[Opis] [text] NULL,
 CONSTRAINT [PK_TypyRaportow] PRIMARY KEY CLUSTERED 
(
	[ID_TypRaportu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Raporty USALI

CREATE TABLE [dbo].[RaportyUSALI](
	[ID_Raport] [int] IDENTITY(1,1) NOT NULL,
	[ID_TypRaportu] [char](2) NOT NULL,
	[Raport] [xml] NOT NULL,
	[DataRaportu] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_RaportyUsali] PRIMARY KEY CLUSTERED 
(
	[ID_Raport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[RaportyUSALI]  WITH CHECK ADD  CONSTRAINT [FK_RaportyUsali_TypyRaportow] FOREIGN KEY([ID_TypRaportu])
REFERENCES [dbo].[TypyRaportow] ([ID_TypRaportu])
GO

ALTER TABLE [dbo].[RaportyUSALI] CHECK CONSTRAINT [FK_RaportyUsali_TypyRaportow]
GO










