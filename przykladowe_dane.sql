-- Dane używane podczas testowania

-- Tabela typy gości
INSERT TypyGosci 
VALUES (1, N'Turysta rodzinny'),
(2, N'Gość biznesowy'),
(3, N'Gość z zagranicy'),
(4, N'Stały klient/VIP'),
(5, N'Gość indywidualny')

-- Tabela goście

SET IDENTITY_INSERT [dbo].[Goscie] ON 
INSERT Goscie ([ID_Gosc], [Imie], [Nazwisko], [Ulica], [Miasto], [KodPocztowy], [Kraj], [NumerTelefonu], [AdresEmail], [ID_TypGoscia], [PESEL/Paszport], [DodatkoweInformacje]) 
VALUES (1, N'Marzena', N'Piach', N'ul. Kwiatowa 124', N'Gdynia', N'00-123', N'Polska', N'987654321   ', N'marzp@guest.com', 5, N'12312312312', NULL),
(2, N'Jerzy', N'Krak', N'ul. Basztowa 12', N'Gdańsk', N'00-123', N'Polska', N'983526421   ', N'jekr@guest.com', 5, N'32132132132', NULL),
(3, N'Danuta', N'Oliwka', N'ul. Różana 124', N'Kraków', N'00-123', N'Polska', N'432134514   ', N'daol@guest.com', 1, N'23423423423', NULL),
(4, N'Kamil', N'Dudek', N'ul. Makowa 124', N'Białystok', N'00-123', N'Polska', N'911133333   ', N'kadu@guest.com', 1, N'45645645645', NULL),
(5, N'John', N'Taylor', N'ul. 68 Reegans Road', N'Barkes Vale', N'NSW 2474', N'Australia', N'346234235   ', N'jota@guest.com', 3, N'AU 1562351 ', NULL),
(6, N'Jadwiga', N'Oleszko', N'ul. Zielona 32', N'Przemyśl', N'00-123', N'Polska', N'123332211   ', N'jaol@guest.com', 4, N'90409437323', N'<Ankieta><Gosc><Imie>Jadwiga</Imie><Nazwisko>Oleszko</Nazwisko></Gosc><Informacje><Ocena><Wyżywienie>4</Wyżywienie><Rozrywki>4</Rozrywki><Rekreacja>5</Rekreacja><Czystość>5</Czystość><PotrzebyKlienta>4</PotrzebyKlienta><PracownicyObiektu>5</PracownicyObiektu><Cena>3</Cena></Ocena><Opis><Cel>Wypoczynek</Cel><Pochwała>Na pochwałę zasługuje pokój nr 16. To mój ulubiony pokój. Widok z okna jest fenomenalny. </Pochwała><Poprawa>Możecie pomyśleć o dodaniu opcji dań wegańskich w menu restauracji.</Poprawa></Opis></Informacje></Ankieta>'),
(7, N'Jan', N'Sikora', N'ul. Morska 4', N'Zielona Góra', N'00-123', N'Polska', N'999888777   ', N'jasi@guest.com', 2, N'77351221365', NULL),
(8, N'Jolanta', N'Zych', N'ul. Nagietkowa 14', N'Wrocław', N'12-432', N'Polska', N'652123123   ', NULL, 5, N'12376317643', NULL),
(10, N'Marian', N'Oleksy', N'ul. Kościuszki 21', N'Nowy Targ', N'11-111', N'Polska', N'982664123   ', N'maol@guest.com', 5, N'76312312312', NULL),
(11, N'Julian', N'Prawąs', N'ul. Zielonki 27', N'Lublin', N'19-121', N'Polska', N'185167167   ', N'jupraw@guest.com', 5, N'90121212931', NULL)
SET IDENTITY_INSERT [dbo].[Goscie] OFF

-- Tabela statusy rezerwacji

INSERT [dbo].[StatusyRezerwacji] ([ID_StatusRezerwacji], [StatusRezerwacji], [Opis]) 
VALUES (1, N'Potwierdzona', N'Rezerwacja, która jest potwierdzona wpłaconym zadatkiem.'),
(2, N'Niepotwierdzona', N'Rezerwacja, która jest niepotwierdzona.'),
(3, N'Oczekująca', N'Stan rezerwacji w przypadku braku wolnych pokoi.')

-- Tabela rezerwacje

SET IDENTITY_INSERT [dbo].[Rezerwacje] ON 
INSERT [dbo].[Rezerwacje] ([ID_Rezerwacja], [ID_Gosc], [DataOd], [DataDo], [LiczbaPokoi], [ID_StatusRezerwacji], [DataRezerwacji], [LiczbaGosci]) 
VALUES (1, 2, CAST(N'2023-05-01T00:00:00' AS SmallDateTime), CAST(N'2023-05-04T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-03-02T00:00:00' AS SmallDateTime), 1),
(2, 3, CAST(N'2023-05-03T00:00:00' AS SmallDateTime), CAST(N'2023-05-08T00:00:00' AS SmallDateTime), 1, 1, CAST(N'2022-03-10T00:00:00' AS SmallDateTime), 2),
(3, 4, CAST(N'2023-05-05T00:00:00' AS SmallDateTime), CAST(N'2023-05-10T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-03-05T00:00:00' AS SmallDateTime), 3),
(4, 5, CAST(N'2023-05-04T00:00:00' AS SmallDateTime), CAST(N'2023-05-06T00:00:00' AS SmallDateTime), 2, 2, CAST(N'2022-03-11T00:00:00' AS SmallDateTime), 4),
(5, 6, CAST(N'2023-05-02T00:00:00' AS SmallDateTime), CAST(N'2023-05-10T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-03-16T00:00:00' AS SmallDateTime), 1),
(6, 7, CAST(N'2023-05-06T00:00:00' AS SmallDateTime), CAST(N'2023-05-10T00:00:00' AS SmallDateTime), 1, 1, CAST(N'2022-03-18T00:00:00' AS SmallDateTime), 2),
(7, 1, CAST(N'2023-05-11T00:00:00' AS SmallDateTime), CAST(N'2023-05-12T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-03-11T00:00:00' AS SmallDateTime), 1),
(8, 6, CAST(N'2023-01-01T00:00:00' AS SmallDateTime), CAST(N'2023-01-04T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-05-22T10:21:00' AS SmallDateTime), 1),
(9, 3, CAST(N'2022-06-12T00:00:00' AS SmallDateTime), CAST(N'2022-06-18T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-06-12T08:22:00' AS SmallDateTime), 1),
(10, 10, CAST(N'2023-05-06T00:00:00' AS SmallDateTime), CAST(N'2023-05-10T00:00:00' AS SmallDateTime), 1, 1, CAST(N'2022-08-15T14:28:00' AS SmallDateTime), 1),
(12, 4, CAST(N'2022-08-16T00:00:00' AS SmallDateTime), CAST(N'2022-08-20T00:00:00' AS SmallDateTime), 1, 1, CAST(N'2022-08-16T20:43:00' AS SmallDateTime), 1),
(14, 6, CAST(N'2022-08-16T00:00:00' AS SmallDateTime), CAST(N'2022-08-17T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-08-16T21:13:00' AS SmallDateTime), 1),
(15, 2, CAST(N'2022-08-15T00:00:00' AS SmallDateTime), CAST(N'2022-08-20T00:00:00' AS SmallDateTime), 1, 1, CAST(N'2022-08-16T21:27:00' AS SmallDateTime), 1),
(16, 11, CAST(N'2022-09-21T00:00:00' AS SmallDateTime), CAST(N'2022-09-22T00:00:00' AS SmallDateTime), 2, 2, CAST(N'2022-09-21T20:22:00' AS SmallDateTime), 4),
(17, 2, CAST(N'2022-10-04T00:00:00' AS SmallDateTime), CAST(N'2022-10-10T00:00:00' AS SmallDateTime), 1, 2, CAST(N'2022-10-04T15:30:00' AS SmallDateTime), 1)
SET IDENTITY_INSERT [dbo].[Rezerwacje] OFF

-- Tabela metody płatności

INSERT MetodyPlatnosci
VALUES (1, N'Gotówka'),
(2, N'Przelew'),
(3, N'Karta płatnicza'),
(4, N'Karta + gotówka')

-- Tabela płatności

SET IDENTITY_INSERT [dbo].[Platnosci] ON 
INSERT [dbo].[Platnosci] ([ID_Platnosc], [ID_Rezerwacja], [CalkowitaKwotaDoZaplaty], [ID_MetodaPlatnosci], [TerminPlatnosci], [DataDokonaniaPlatnosci], [Zadatek], [UslugiDodatkoweStatus]) 
VALUES (1, 1, 1077, 1, CAST(N'2023-05-18T00:00:00' AS SmallDateTime), NULL, NULL, NULL),
(2, 2, 1796, 1, CAST(N'2023-05-22T00:00:00' AS SmallDateTime), NULL, 449, NULL),
(3, 3, 3250, 1, CAST(N'2023-05-24T00:00:00' AS SmallDateTime), NULL, NULL, NULL),
(4, 4, 1716, 1, CAST(N'2023-05-20T00:00:00' AS SmallDateTime), NULL, NULL, NULL),
(5, 5, 3672, 1, CAST(N'2023-05-24T00:00:00' AS SmallDateTime), NULL, NULL, NULL),
(6, 6, 1660.8, 1, CAST(N'2023-05-24T00:00:00' AS SmallDateTime), CAST(N'2022-05-22T11:32:00' AS SmallDateTime), 415.20000000000005, NULL),
(7, 7, 359, 3, CAST(N'2023-05-26T00:00:00' AS SmallDateTime), CAST(N'2022-05-21T09:32:00' AS SmallDateTime), NULL, NULL),
(9, 8, 1377, 1, CAST(N'2023-01-04T00:00:00' AS SmallDateTime), NULL, NULL, NULL),
(10, 10, 1148.8, 1, CAST(N'2023-05-10T00:00:00' AS SmallDateTime), NULL, 287.2, NULL),
(12, 12, 1437.8, 1, CAST(N'2022-08-20T00:00:00' AS SmallDateTime), NULL, 287.2, N'OK'),
(14, 14, 648, 3, CAST(N'2022-08-17T00:00:00' AS SmallDateTime), CAST(N'2022-08-17T19:44:00' AS SmallDateTime), NULL, N'OK'),
(15, 15, 3775.2, 1, CAST(N'2022-08-20T00:00:00' AS SmallDateTime), NULL, 514.80000000000007, NULL),
(16, 16, 898, 3, CAST(N'2022-09-22T00:00:00' AS SmallDateTime), CAST(N'2022-09-22T18:52:00' AS SmallDateTime), NULL, NULL),
(17, 17, 2154, 1, CAST(N'2022-10-10T00:00:00' AS SmallDateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Platnosci] OFF

-- Tabela statusy pokoju

INSERT StatusyPokoju 
VALUES (1, N'Wolny', N'Pokój jest posprzątany i gotowy na przyjęcie gościa.'),
(2, N'Zajęty', N'Pokój nie jest sprzątany w trakcie pobytu gościa.'),
(3, N'Wolny - Na czysto', N'Wymaga sprzątania po zwolnieniu pokoju przez gościa.'),
(4, N'Zajęty - Przy gościu', N'Pokój jest sprzątany w trakcie pobytu gościa.')




