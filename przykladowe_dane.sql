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

-- Tabela typy pokoi

INSERT TypyPokoi 
VALUES (1, N'Jedynka', 359, N'Pokój jednoosobowy (single room) z pojedynczym łóżkiem.'),
(2, N'Dwójka', 449, N'Pokój dwuosobowy (double room) z jednym podwójnym łóżkiem.'),
(3, N'Podwójny', 449, N'Pokój dwuosobowy (twin room) z dwoma osobnymi łóżkami.'),
(4, N'Trójka', 569, N'Pokój trzyosobowy (triple room) z trzema osobnymi łóżkami.'),
(5, N'Rodzinny', 650, N'Pokój dla co najmniej 2 osób dorosłych i 2 dzieci.'),
(6, N'Deluxe Single', 459, N'Pokój jednoosobowy o podwyższonym standardzie.'),
(7, N'Deluxe Double', 519, N'Pokój dwuosobowy o podwyższonym standardzie.'),
(8, N'Apartament', 858, N'Apartament dwupokojowy z łóżkiem małżeńskim.')

-- Tabela pokoje

INSERT Pokoje
VALUES (1, N'1', 1, N'1', 2),
(2, N'2', 1, N'9', 3),
(3, N'1', 2, N'2', 1),
(4, N'2', 2, N'10', 1),
(5, N'1', 3, N'3', 3),
(6, N'2', 3, N'11', 3),
(7, N'1', 4, N'4', 1),
(8, N'2', 4, N'12', 1),
(9, N'1', 5, N'5', 1),
(10, N'2', 5, N'13', 1),
(11, N'1', 6, N'6', 1),
(12, N'2', 6, N'14', 1),
(13, N'1', 7, N'7', 1),
(14, N'2', 7, N'15', 1),
(15, N'1', 8, N'8', 3),
(16, N'2', 8, N'16', 1)

-- Tabela pokoje - rezerwacja

SET IDENTITY_INSERT [dbo].[PokojeRezerwacja] ON 
INSERT [dbo].[PokojeRezerwacja] ([ID_Rezerwacja], [ID_Pokoj], [Id_PokojRezerwacja]) 
VALUES (1, 1, 1),
(2, 3, 2),
(3, 9, 3),
(4, 15, 4),
(5, 12, 5),
(6, 13, 6),
(7, 2, 7),
(4, 4, 8),
(8, 11, 9),
(9, 11, 10),
(10, 1, 11),
(12, 1, 14),
(14, 2, 16),
(15, 16, 17),
(16, 5, 18),
(16, 6, 19),
(17, 1, 20)
SET IDENTITY_INSERT [dbo].[PokojeRezerwacja] OFF

-- Tabela działy

INSERT Dzialy
VALUES (N'PS1', N'Sluzba parterowa', N'Dział zajmujący się obsługą gości, dbający o bezpieczeństwo i opiekę nad gościem.'),
(N'R1 ', N'Recepcja', N'Dział zajmujący się obsługą gościa w recepcji.'),
(N'SP1', N'Sluzba pieter', N'Dział zajmujący się utrzymaniem czystości w pokojach i przygotowaniem ich na przyjazd gości.'),
(N'UD1', N'Uslugi Dodatkowe', N'Dział świadczenia usług sportowo-rekreacyjnych.')

-- Tabela pracownicy 

INSERT Pracownicy 
VALUES (1, N'Jan', N'Kowalski', N'Parkingowa/y', N'ul. Motylkowa 2', N'Wrocław', N'00-000', N'Polska', N'876321123', N'11111111111', N'Zatrudniony', N'PS1'),
 (2, N'Maria', N'Nowak', N'Pokojowa/y', N'ul. Różana 2', N'Rzeszów', N'00-001', N'Polska', N'876321111', N'22222222222', N'Zatrudniony', N'SP1'),
(3, N'Monika', N'Wichura', N'Pokojowa/y', N'ul. Bratkowa 2', N'Kraków', N'00-002', N'Polska', N'876321122', N'33333333333', N'Zatrudniony', N'SP1'),
(4, N'Łukasz', N'Biegun', N'Ratownik', N'ul. Irysowa 2', N'Hel', N'00-003', N'Polska', N'876321133', N'44444444444', N'Zatrudniony', N'UD1'),
(5, N'Józef', N'Stachowski', N'Masażysta/ka', N'ul. Rzepakowa 2', N'Wrocław', N'00-004', N'Polska', N'876321144', N'55555555555', N'Zatrudniony', N'UD1'),
(6, N'Anna', N'Woźniak', N'Kierownik recepcji', N'ul. Ziemniaczana 2', N'Wrocław', N'00-005', N'Polska', N'876321155', N'66666666666', N'Zatrudniony', N'R1 '),
(7, N'Krzysztof', N'Pąk', N'Recepcjonista/ka', N'ul. Marchewkowa 2', N'Wrocław', N'00-006', N'Polska', N'876321166', N'77777777777', N'Zatrudniony', N'R1 '),
(8, N'Marian', N'Oleksy', N'Recepcjonista/ka', N'ul. Kościuszki 21', N'Nowy Targ', N'11-111', N'Polska', N'982664123', N'76312312312', N'Zatrudniony', N'R1 ')

-- Tabela usługi

INSERT Uslugi
VALUES (1, N'Bio Sauna', 30, N'H', N'Biosauna to sauna o niższej niż w większości saun temperaturze i suchej wilgotności. W tej saunie wody nie polewa się bezpośrednio na kamienie, a mieszanki zapachowe odparowują z parownika znajdującego się na piecu.', NULL),
(2, N'Basen', 50, N'H', N'Zewnętrzny, całoroczny basen rekreacyjny o wymiarach 5 x 10 m.', NULL),
(3, N'VIP Jacuzzi', 299, N'H', N'Romantyczne chwile spedzone w jacuzzi – wynajem na wyłączność (godz. 21:00-22:00) wraz z owocowym poczęstunkiem', NULL),
(4, N'Wynajem samochodu', 90, N'D', N'Wypożyczenie samochodu', N'<Informacje><NazwaUslugi>Wynajem samochodu</NazwaUslugi><NazwaFirmy>Wynajmowalnia S.A.</NazwaFirmy><Oferta><Samochod id="1"><NazwaSamochodu>Skoda Superb</NazwaSamochodu><Rocznik>2020</Rocznik><Opis>Automatyczna skrzynia biegów, liczba miejsc: 5, kolor: czarny, rodzaj paliwa: Diesel</Opis><CenaZaDobe>70</CenaZaDobe></Samochod><Samochod id="2"><NazwaSamochodu>Opel Corsa</NazwaSamochodu><Rocznik>2021</Rocznik><Opis>Manualna skrzynia biegów, liczba miejsc: 5, kolor: biały, rodzaj paliwa: Benzyna</Opis><CenaZaDobe>50</CenaZaDobe></Samochod><Samochod id="3"><NazwaSamochodu>Kia Rio</NazwaSamochodu><Rocznik>2015</Rocznik><Opis>Manualna skrzynia biegów, liczba miejsc: 5, kolor: srebrny, rodzaj paliwa: Benzyna + LPG</Opis><CenaZaDobe>40</CenaZaDobe></Samochod><DodatkoweWarunki>
Bezpłatne odwołanie do 48 godzin;
Ubezpieczenie od kradzieży;
Ubezpieczenie od uszkodzeń;
Ubezpieczenie OC;
</DodatkoweWarunki></Oferta></Informacje>'),
(5, N'Wynajem sali konferencyjnej', 150, N'H', N'Sala składająca się z dwóch modułów, przedzielonych ścianą rozsuwną, z bezpośrednim wyjściem do ogrodu z grillem.', NULL),
(6, N'Parking strzeżony', 20, N'D', N'Parking strzeżony', NULL),
(7, N'Masaż relaksujący', 289, N'H', N'Jest to bardzo delikatny zabieg, prowadzony w spokojnej, wyciszającej atmosferze, która pozwala pacjentowi oderwać się od problemów i rozluźnić się w pełni.', NULL),
(8, N'Masaż kamieniami', 289, N'H', N'Masaż gorącymi kamieniami działa fizjoterapeutycznie. Przywraca sprawność uszkodzonym narządom, a jednocześnie sprzyja wypoczynkowi i regeneracji. Tym samym zwiększa zdolność wysiłkową organizmu.', NULL),
(9, N'Masaż bańką chińską', 159, N'H', N'Masaż bańką chińską działa niczym drenaż limfatyczny. Poprawia krążenie krwi, przyspiesza metabolizm i usuwa nadmiar toksycznych substancji', NULL),
(10, N'Kąpiel błotna', 120, N'H', N'Kąpiel błotna to doskonały zabieg SPA, regenerujący ciało, a także korzystnie wpływający na zdrowie. Wykorzystuje się do nich borowinę.', NULL),
(11, N'Zabieg Odmładzająco-Liftingujący', 300, N'H', N'Intensywnie nawilżający zabieg przeznaczony do skór odwodnionych.', NULL)

-- Tabela rezerwacji usług

SET IDENTITY_INSERT [dbo].[RezerwacjaUslug] ON 
INSERT [dbo].[RezerwacjaUslug] ([ID_Rezerwacja], [ID_Usluga], [DataRozpoczecia], [ID_Pracownik], [Opis], [DataZakonczenia], [ID_RezerwacjaUslugi]) 
VALUES (5, 7, CAST(N'2023-05-04T13:30:00' AS SmallDateTime), 5, NULL, CAST(N'2023-05-04T14:30:00' AS SmallDateTime), 1),
(5, 6, CAST(N'2023-05-02T00:00:00' AS SmallDateTime), 1, NULL, CAST(N'2023-05-10T00:00:00' AS SmallDateTime), 2),
(3, 9, CAST(N'2023-05-05T14:30:00' AS SmallDateTime), 5, NULL, CAST(N'2023-05-05T15:30:00' AS SmallDateTime), 3),
(6, 2, CAST(N'2023-05-07T12:00:00' AS SmallDateTime), 4, NULL, CAST(N'2023-05-07T14:00:00' AS SmallDateTime), 4),
(10, 8, CAST(N'2023-05-08T14:00:00' AS SmallDateTime), 5, NULL, CAST(N'2023-05-08T15:00:00' AS SmallDateTime), 5),
(12, 8, CAST(N'2022-08-17T14:00:00' AS SmallDateTime), 5, NULL, CAST(N'2022-08-17T15:00:00' AS SmallDateTime), 7),
(14, 8, CAST(N'2022-08-16T14:00:00' AS SmallDateTime), 5, NULL, CAST(N'2022-08-16T15:00:00' AS SmallDateTime), 9),
(17, 7, CAST(N'2022-10-05T10:00:00' AS SmallDateTime), 5, NULL, CAST(N'2022-10-05T12:00:00' AS SmallDateTime), 10),
(17, 7, CAST(N'2022-10-06T10:00:00' AS SmallDateTime), 5, NULL, CAST(N'2022-10-06T12:00:00' AS SmallDateTime), 11),
(17, 7, CAST(N'2022-10-07T10:00:00' AS SmallDateTime), 5, NULL, CAST(N'2022-10-07T12:00:00' AS SmallDateTime), 12),
(17, 7, CAST(N'2022-10-08T10:00:00' AS SmallDateTime), 5, NULL, CAST(N'2022-10-08T12:00:00' AS SmallDateTime), 13),
(17, 7, CAST(N'2022-10-09T10:00:00' AS SmallDateTime), 5, NULL, CAST(N'2022-10-09T12:00:00' AS SmallDateTime), 14),
(17, 6, CAST(N'2022-10-04T00:00:00' AS SmallDateTime), 1, NULL, CAST(N'2022-10-10T00:00:00' AS SmallDateTime), 15),
(17, 2, CAST(N'2022-10-05T18:00:00' AS SmallDateTime), 4, NULL, CAST(N'2022-10-05T21:00:00' AS SmallDateTime), 16),
(17, 2, CAST(N'2022-10-06T18:00:00' AS SmallDateTime), 4, NULL, CAST(N'2022-10-06T21:00:00' AS SmallDateTime), 17),
(17, 2, CAST(N'2022-10-07T18:00:00' AS SmallDateTime), 4, NULL, CAST(N'2022-10-07T21:00:00' AS SmallDateTime), 18),
(17, 2, CAST(N'2022-10-08T18:00:00' AS SmallDateTime), 4, NULL, CAST(N'2022-10-08T21:00:00' AS SmallDateTime), 19),
(17, 2, CAST(N'2022-10-09T18:00:00' AS SmallDateTime), 4, NULL, CAST(N'2022-10-09T21:00:00' AS SmallDateTime), 20)
SET IDENTITY_INSERT [dbo].[RezerwacjaUslug] OFF

-- Tabela typy raportów

INSERT TypyRaportow
VALUES (N'U1', N'Pokoje', N'Schemat ma na celu odzwierciedlenie minimalnego standardu raportowania.'),
(N'U2', N'Spa&Wellnes', N'Schemat ma na celu odzwierciedlenie minimalnego standardu raportowania.')

-- Tabela raportów USALI

SET IDENTITY_INSERT [dbo].[RaportyUSALI] ON 
INSERT [dbo].[RaportyUSALI] ([ID_Raport], [ID_TypRaportu], [Raport], [DataRaportu]) 
VALUES (1, N'U1', N'<Pokoje><WskaznikWykorzystaniaPokoi>0.27</WskaznikWykorzystaniaPokoi><LiczbaPokoi>16</LiczbaPokoi><SredniaCenaPokoju>552.44</SredniaCenaPokoju><RevPar>151.35</RevPar><CalkowityDochod>8839.00</CalkowityDochod><Wydatki><SrodkiCzystosci>600.00</SrodkiCzystosci><PoscielReczniki>1200.00</PoscielReczniki><PralniaSuszarnia>400.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><SumaWydatkow>2700.00</SumaWydatkow></Wydatki><Zysk>6139.00</Zysk></Pokoje>', CAST(N'2022-09-15T19:00:00' AS SmallDateTime)),
(2, N'U1', N'<Pokoje><WskaznikWykorzystaniaPokoi>0.27</WskaznikWykorzystaniaPokoi><LiczbaPokoi>16</LiczbaPokoi><SredniaCenaPokoju>552.44</SredniaCenaPokoju><RevPar>151.35</RevPar><CalkowityDochod>8839.00</CalkowityDochod><Wydatki><SrodkiCzystosci>600.00</SrodkiCzystosci><PoscielReczniki>1200.00</PoscielReczniki><PralniaSuszarnia>400.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><SumaWydatkow>2700.00</SumaWydatkow></Wydatki><Zysk>6139.00</Zysk></Pokoje>', CAST(N'2022-09-17T18:04:00' AS SmallDateTime)),
(3, N'U2', N'<SpaIWellness><Dochod><Basen>0.00</Basen><PielegnacjaSkory>0.00</PielegnacjaSkory><ZabiegiNaCialo>1734.00</ZabiegiNaCialo><CalkowityDochod>1734.00</CalkowityDochod></Dochod><Wydatki><SrodkiCzystosci>1100.00</SrodkiCzystosci><PoscielReczniki>890.00</PoscielReczniki><PralniaSuszarnia>600.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><UtrzymanieBasenu>2000.00</UtrzymanieBasenu><Kosmetyki>800.00</Kosmetyki><SumaWydatkow>5890.00</SumaWydatkow></Wydatki><Zysk>-4156.00</Zysk></SpaIWellness>', CAST(N'2022-09-18T18:17:00' AS SmallDateTime)),
(4, N'U1', N'<Pokoje><WskaznikWykorzystaniaPokoi>0.31</WskaznikWykorzystaniaPokoi><LiczbaPokoi>16</LiczbaPokoi><SredniaCenaPokoju>540.94</SredniaCenaPokoju><RevPar>166.73</RevPar><CalkowityDochod>9737.00</CalkowityDochod><Wydatki><SrodkiCzystosci>600.00</SrodkiCzystosci><PoscielReczniki>1200.00</PoscielReczniki><PralniaSuszarnia>400.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><SumaWydatkow>2700.00</SumaWydatkow></Wydatki><Zysk>7037.00</Zysk></Pokoje>', CAST(N'2022-10-04T13:30:00' AS SmallDateTime)),
(5, N'U1', N'<Pokoje><WskaznikWykorzystaniaPokoi>0.31</WskaznikWykorzystaniaPokoi><LiczbaPokoi>16</LiczbaPokoi><SredniaCenaPokoju>540.94</SredniaCenaPokoju><RevPar>166.73</RevPar><CalkowityDochod>9737.00</CalkowityDochod><Wydatki><SrodkiCzystosci>900.00</SrodkiCzystosci><PoscielReczniki>1200.00</PoscielReczniki><PralniaSuszarnia>400.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><SumaWydatkow>3000.00</SumaWydatkow></Wydatki><Zysk>6737.00</Zysk></Pokoje>', CAST(N'2022-10-04T13:42:00' AS SmallDateTime)),
(6, N'U2', N'<SpaIWellness><Dochod><Basen>4250.00</Basen><PielegnacjaSkory>0.00</PielegnacjaSkory><ZabiegiNaCialo>17629.00</ZabiegiNaCialo><CalkowityDochod>21879.00</CalkowityDochod></Dochod><Wydatki><SrodkiCzystosci>1100.00</SrodkiCzystosci><PoscielReczniki>890.00</PoscielReczniki><PralniaSuszarnia>600.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><UtrzymanieBasenu>2000.00</UtrzymanieBasenu><Kosmetyki>800.00</Kosmetyki><SumaWydatkow>5890.00</SumaWydatkow></Wydatki><Zysk>15989.00</Zysk></SpaIWellness>', CAST(N'2022-10-04T15:42:00' AS SmallDateTime)),
(7, N'U2', N'<SpaIWellness><Dochod><Basen>750.00</Basen><PielegnacjaSkory>0.00</PielegnacjaSkory><ZabiegiNaCialo>3468.00</ZabiegiNaCialo><CalkowityDochod>4218.00</CalkowityDochod></Dochod><Wydatki><SrodkiCzystosci>1100.00</SrodkiCzystosci><PoscielReczniki>890.00</PoscielReczniki><PralniaSuszarnia>600.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><UtrzymanieBasenu>2000.00</UtrzymanieBasenu><Kosmetyki>800.00</Kosmetyki><SumaWydatkow>5890.00</SumaWydatkow></Wydatki><Zysk>-1672.00</Zysk></SpaIWellness>', CAST(N'2022-10-04T17:52:00' AS SmallDateTime)),
(8, N'U1', N'<Pokoje><WskaznikWykorzystaniaPokoi>0.41</WskaznikWykorzystaniaPokoi><LiczbaPokoi>16</LiczbaPokoi><SredniaCenaPokoju>495.46</SredniaCenaPokoju><RevPar>203.61</RevPar><CalkowityDochod>11891.00</CalkowityDochod><Wydatki><SrodkiCzystosci>900.00</SrodkiCzystosci><PoscielReczniki>1200.00</PoscielReczniki><PralniaSuszarnia>400.00</PralniaSuszarnia><UslugiKomplementarne>500.00</UslugiKomplementarne><SumaWydatkow>3000.00</SumaWydatkow></Wydatki><Zysk>8891.00</Zysk></Pokoje>', CAST(N'2022-10-04T21:11:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[RaportyUSALI] OFF
GO

-- Tabela typy wydatków

INSERT TypyWydatkow
VALUES (N'CS  ', N'Srodki czystosci', N'Srodki sluzace do sprzatania pomieszczen.'),
(N'HABP', N'Produkty zdrowie/uroda', N'Produkty potrzebne do strefy SPA.'),
(N'L   ', N'Posciel/Reczniki', N'Zakup pościeli i ręczników.'),
(N'LADC', N'Pralnia/Suszarnia', N'Pranie recznikow i poscieli.'),
(N'SAG ', N'Uslugi komplementarne/Prezenty', N'Wydatki na uslugi komplementarne.'),
(N'SP  ', N'Basen', N'Utrzymanie oraz zaopatrzenie basenu.')

-- Tabela wydatków 

SET IDENTITY_INSERT [dbo].[Wydatki] ON 
INSERT [dbo].[Wydatki] ([ID_Wydatek], [ID_Dzial], [ID_KodWydatku], [Kwota], [DataZakupu], [InformacjeDodatkowe]) 
VALUES (1, N'SP1', N'CS  ', 600, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(2, N'SP1', N'L   ', 1200, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(3, N'SP1', N'LADC', 400, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(4, N'SP1', N'SAG ', 500, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(5, N'UD1', N'CS  ', 1100, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(6, N'UD1', N'L   ', 890, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(7, N'UD1', N'LADC', 600, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(8, N'UD1', N'SAG ', 500, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(9, N'UD1', N'SP  ', 2000, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(10, N'UD1', N'HABP', 800, CAST(N'2022-08-01T00:00:00' AS SmallDateTime), NULL),
(11, N'SP1', N'CS  ', 300, CAST(N'2022-09-01T00:00:00' AS SmallDateTime), N'Zakup środków do czyszczenia dywanów.')
SET IDENTITY_INSERT [dbo].[Wydatki] OFF







