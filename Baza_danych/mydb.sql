-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 22 Maj 2014, 23:33
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mydb`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta`
--

CREATE TABLE IF NOT EXISTS `artysta` (
  `idArtysty` int(11) NOT NULL,
  `Nazwa` varchar(45) NOT NULL,
  `Imie` varchar(45) DEFAULT NULL,
  `Nazwisko` varchar(45) DEFAULT NULL,
  `id_ranga` int(11) NOT NULL,
  `id_zespol_typ` int(11) NOT NULL,
  `id_zespol_podtyp` int(11) NOT NULL,
  `menedzer` varchar(45) DEFAULT NULL,
  `telefon` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `opis` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`idArtysty`),
  UNIQUE KEY `Nazwa_UNIQUE` (`Nazwa`),
  UNIQUE KEY `idArtysty_UNIQUE` (`idArtysty`),
  KEY `fk_Artysta_Artysta_typ1_idx` (`id_zespol_typ`),
  KEY `fk_Artysta_Artysta_podtyp1_idx` (`id_zespol_podtyp`),
  KEY `fk_Artysta_Artysta_ranga1_idx` (`id_ranga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta_has_wydarzenia`
--

CREATE TABLE IF NOT EXISTS `artysta_has_wydarzenia` (
  `Artysta_idArtysty` int(11) NOT NULL,
  `Wydarzenia_idWydarzenia` int(11) NOT NULL,
  PRIMARY KEY (`Artysta_idArtysty`,`Wydarzenia_idWydarzenia`),
  KEY `fk_Artysta_has_Wydarzenia_Wydarzenia1_idx` (`Wydarzenia_idWydarzenia`),
  KEY `fk_Artysta_has_Wydarzenia_Artysta1_idx` (`Artysta_idArtysty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta_podtyp`
--

CREATE TABLE IF NOT EXISTS `artysta_podtyp` (
  `idArtysta_podtyp` int(11) NOT NULL AUTO_INCREMENT,
  `podtyp` varchar(45) NOT NULL,
  PRIMARY KEY (`idArtysta_podtyp`),
  UNIQUE KEY `podtyp_UNIQUE` (`podtyp`),
  UNIQUE KEY `idArtysta_podtyp_UNIQUE` (`idArtysta_podtyp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta_ranga`
--

CREATE TABLE IF NOT EXISTS `artysta_ranga` (
  `idArtysta_wielkosc` int(11) NOT NULL AUTO_INCREMENT,
  `cena_do` varchar(45) NOT NULL,
  PRIMARY KEY (`idArtysta_wielkosc`),
  UNIQUE KEY `cena_do_UNIQUE` (`cena_do`),
  UNIQUE KEY `idArtysta_wielkosc_UNIQUE` (`idArtysta_wielkosc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta_typ`
--

CREATE TABLE IF NOT EXISTS `artysta_typ` (
  `idArtysta_typ` int(11) NOT NULL AUTO_INCREMENT,
  `typ` varchar(45) NOT NULL,
  PRIMARY KEY (`idArtysta_typ`),
  UNIQUE KEY `typ_UNIQUE` (`typ`),
  UNIQUE KEY `idArtysta_typ_UNIQUE` (`idArtysta_typ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilety`
--

CREATE TABLE IF NOT EXISTS `bilety` (
  `idBilet` int(11) NOT NULL AUTO_INCREMENT,
  `id_klient` int(11) NOT NULL,
  `id_wydarzenia` int(11) NOT NULL,
  `id_cena` int(11) NOT NULL,
  `data_zakupu` timestamp NULL DEFAULT NULL,
  `nr_miejsca` int(11) NOT NULL,
  `id_typ_biletu` varchar(45) DEFAULT NULL,
  `kod_kreskowy` varchar(45) NOT NULL,
  `czy_oplacony` tinyint(1) NOT NULL DEFAULT '0',
  `pdf` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idBilet`),
  UNIQUE KEY `idBilet_UNIQUE` (`idBilet`),
  KEY `fk_Bilety_Wydarzenia_idx` (`id_wydarzenia`),
  KEY `fk_Bilety_Bilety_cena1_idx` (`id_cena`),
  KEY `fk_Bilety_Klient1_idx` (`id_klient`),
  KEY `fk_Bilety_Bilety_typ1_idx` (`id_typ_biletu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilety_cena`
--

CREATE TABLE IF NOT EXISTS `bilety_cena` (
  `idBilety_cena` int(11) NOT NULL AUTO_INCREMENT,
  `id_wydarzenia` int(11) NOT NULL,
  `id_bilety_kategoria` int(11) NOT NULL,
  `id_bilety_typ` int(11) NOT NULL,
  `cena` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idBilety_cena`),
  UNIQUE KEY `idBilety_cena_UNIQUE` (`idBilety_cena`),
  KEY `fk_Bilety_cena_Wydarzenia1_idx` (`id_wydarzenia`),
  KEY `fk_Bilety_cena_Bilety_kategorie1_idx` (`id_bilety_kategoria`),
  KEY `fk_Bilety_cena_Bilety_typ1_idx` (`id_bilety_typ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilety_kategorie`
--

CREATE TABLE IF NOT EXISTS `bilety_kategorie` (
  `idBilety_kategorie` int(11) NOT NULL AUTO_INCREMENT,
  `kategoria_cenowa` varchar(45) NOT NULL,
  PRIMARY KEY (`idBilety_kategorie`),
  UNIQUE KEY `kategoria_cenowa_UNIQUE` (`kategoria_cenowa`),
  UNIQUE KEY `idBilety_kategorie_UNIQUE` (`idBilety_kategorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilety_typ`
--

CREATE TABLE IF NOT EXISTS `bilety_typ` (
  `idBilety_typ` int(11) NOT NULL AUTO_INCREMENT,
  `typ_biletu` varchar(45) NOT NULL,
  PRIMARY KEY (`idBilety_typ`),
  UNIQUE KEY `idBilety_typ_UNIQUE` (`idBilety_typ`),
  UNIQUE KEY `typ_biletu_UNIQUE` (`typ_biletu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dziennik`
--

CREATE TABLE IF NOT EXISTS `dziennik` (
  `idDziennik` int(11) NOT NULL AUTO_INCREMENT,
  `rodzaj_akcji_id` int(11) DEFAULT NULL,
  `pacownik_id` int(11) DEFAULT NULL,
  `zmieniana_tabela` varchar(45) DEFAULT NULL,
  `id_w_tabeli` int(11) DEFAULT NULL,
  `czas` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idDziennik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `elemety_faktur`
--

CREATE TABLE IF NOT EXISTS `elemety_faktur` (
  `idElemety_fatur` int(11) NOT NULL AUTO_INCREMENT,
  `id_faktura_otrzymana` varchar(45) DEFAULT NULL,
  `marza` varchar(45) DEFAULT NULL,
  `opis` varchar(45) NOT NULL,
  `cena_netto` varchar(45) NOT NULL,
  `id_vat` varchar(45) NOT NULL,
  `cena_brutto` varchar(45) NOT NULL,
  `ilosc` varchar(45) NOT NULL DEFAULT '1',
  `cena_sumaryczna` varchar(45) NOT NULL,
  `id_faktury` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idElemety_fatur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `faktury_otrzymane`
--

CREATE TABLE IF NOT EXISTS `faktury_otrzymane` (
  `idFaktury_otrzymane` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idFaktury_otrzymane`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `faktury_wystawione`
--

CREATE TABLE IF NOT EXISTS `faktury_wystawione` (
  `idFaktury_wystawione` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idFaktury_wystawione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klient`
--

CREATE TABLE IF NOT EXISTS `klient` (
  `idKlient` int(11) NOT NULL AUTO_INCREMENT,
  `id_uzytkownika` int(11) NOT NULL,
  `Imie` varchar(45) DEFAULT NULL,
  `Nazwisko` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `telefon` decimal(10,0) DEFAULT NULL,
  `miejscowosc` varchar(45) NOT NULL,
  `ulica` varchar(45) DEFAULT NULL,
  `nr_domu` varchar(45) NOT NULL,
  `nr_mieszkania` varchar(45) DEFAULT NULL,
  `kod_pocztowy` decimal(5,0) NOT NULL,
  PRIMARY KEY (`idKlient`),
  UNIQUE KEY `idKlient_UNIQUE` (`idKlient`),
  KEY `fk_Klient_Klient_uzytkownik1_idx` (`id_uzytkownika`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klient_uzytkownik`
--

CREATE TABLE IF NOT EXISTS `klient_uzytkownik` (
  `id_uzytkownik` int(11) NOT NULL AUTO_INCREMENT,
  `uzytkownik` varchar(45) NOT NULL,
  `haslo` varchar(45) NOT NULL,
  `id_klienta` int(11) NOT NULL,
  `bledne_logowania` int(11) NOT NULL DEFAULT '0',
  `czy_zablokowane` int(11) NOT NULL DEFAULT '0',
  `ostatnie_logowanie` timestamp NULL DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `data_utworzenia` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_uzytkownik`),
  UNIQUE KEY `uzytkownik_UNIQUE` (`uzytkownik`),
  UNIQUE KEY `id_uzytkownik_UNIQUE` (`id_uzytkownik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `miejsce_wydarzenia`
--

CREATE TABLE IF NOT EXISTS `miejsce_wydarzenia` (
  `idMiejsce_wydarzenia` int(11) NOT NULL AUTO_INCREMENT,
  `Nazwa` varchar(45) NOT NULL,
  `id_miejscowosc` int(11) NOT NULL,
  `nr_domu` varchar(45) DEFAULT NULL,
  `id_wojewodztwo` int(11) NOT NULL,
  `nr_lokalu` varchar(45) DEFAULT NULL,
  `kod_pocztowy` decimal(5,0) DEFAULT NULL,
  `pojemnosc` decimal(6,0) NOT NULL,
  `Ulica` varchar(45) DEFAULT NULL,
  `M_zwykle` decimal(5,0) DEFAULT NULL,
  `M_VIP` decimal(5,0) DEFAULT NULL,
  `telefon` decimal(10,0) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `opis` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`idMiejsce_wydarzenia`),
  UNIQUE KEY `idMiejsce_wydarzenia_UNIQUE` (`idMiejsce_wydarzenia`),
  KEY `fk_Miejsce_wydarzenia_Wojewodztwa1_idx` (`id_wojewodztwo`),
  KEY `fk_Miejsce_wydarzenia_Miejscowosci1_idx` (`id_miejscowosc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `miejscowosci`
--

CREATE TABLE IF NOT EXISTS `miejscowosci` (
  `idMiejscowosci` int(11) NOT NULL AUTO_INCREMENT,
  `id_wojewodztwo` int(11) NOT NULL,
  `miejscowosc` varchar(45) NOT NULL,
  PRIMARY KEY (`idMiejscowosci`),
  UNIQUE KEY `idMiejscowosci_UNIQUE` (`idMiejscowosci`),
  KEY `fk_Miejscowosci_Wojewodztwa1_idx` (`id_wojewodztwo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `podwykonawcy`
--

CREATE TABLE IF NOT EXISTS `podwykonawcy` (
  `idPodwykonawcy` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idPodwykonawcy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownik`
--

CREATE TABLE IF NOT EXISTS `pracownik` (
  `idPracownik` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(45) NOT NULL,
  `Imie` varchar(45) DEFAULT NULL,
  `Nazwisko` varchar(45) DEFAULT NULL,
  `data_zatrudnienia` varchar(45) NOT NULL,
  `stanowisko` varchar(45) DEFAULT NULL,
  `uprawnienia_id` varchar(45) NOT NULL DEFAULT '7',
  `data_utworzenia` timestamp NULL DEFAULT NULL,
  `haslo` varchar(45) NOT NULL,
  `bledne_logowania` int(11) NOT NULL DEFAULT '0',
  `czy_zablokowane` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPracownik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownik_uprawnienia`
--

CREATE TABLE IF NOT EXISTS `pracownik_uprawnienia` (
  `idpom_uprawnienia` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(45) NOT NULL,
  PRIMARY KEY (`idpom_uprawnienia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sprzet`
--

CREATE TABLE IF NOT EXISTS `sprzet` (
  `idSprzet` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idSprzet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vat`
--

CREATE TABLE IF NOT EXISTS `vat` (
  `idVat` int(11) NOT NULL AUTO_INCREMENT,
  `typ_vat` varchar(45) DEFAULT NULL,
  `procent_vat` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idVat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wojewodztwa`
--

CREATE TABLE IF NOT EXISTS `wojewodztwa` (
  `idWojewodztwa` int(11) NOT NULL,
  `nazwa_woj` varchar(45) NOT NULL,
  PRIMARY KEY (`idWojewodztwa`),
  UNIQUE KEY `nazwa_woj_UNIQUE` (`nazwa_woj`),
  UNIQUE KEY `idWojewodztwa_UNIQUE` (`idWojewodztwa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wydarzenia`
--

CREATE TABLE IF NOT EXISTS `wydarzenia` (
  `idWydarzenia` int(11) NOT NULL AUTO_INCREMENT,
  `id_zleceniodawcy` int(11) NOT NULL,
  `id_pracownika` int(11) DEFAULT NULL,
  `czy_oplacone w calosci` tinyint(1) NOT NULL DEFAULT '0',
  `id_miejsce_wydarzenia` int(11) DEFAULT NULL,
  `data_wydarzenia` datetime DEFAULT NULL,
  `id_miejscowosc` int(11) NOT NULL,
  PRIMARY KEY (`idWydarzenia`),
  UNIQUE KEY `idWydarzenia_UNIQUE` (`idWydarzenia`),
  KEY `fk_Wydarzenia_Zleceniodawca1_idx` (`id_zleceniodawcy`),
  KEY `fk_Wydarzenia_Pracownik1_idx` (`id_pracownika`),
  KEY `fk_Wydarzenia_Miejsce_wydarzenia1_idx` (`id_miejsce_wydarzenia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zleceniodawca`
--

CREATE TABLE IF NOT EXISTS `zleceniodawca` (
  `idZleceniodawca` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idZleceniodawca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `artysta`
--
ALTER TABLE `artysta`
  ADD CONSTRAINT `fk_Artysta_Artysta_typ1` FOREIGN KEY (`id_zespol_typ`) REFERENCES `artysta_typ` (`idArtysta_typ`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Artysta_Artysta_podtyp1` FOREIGN KEY (`id_zespol_podtyp`) REFERENCES `artysta_podtyp` (`idArtysta_podtyp`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Artysta_Artysta_ranga1` FOREIGN KEY (`id_ranga`) REFERENCES `artysta_ranga` (`idArtysta_wielkosc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `artysta_has_wydarzenia`
--
ALTER TABLE `artysta_has_wydarzenia`
  ADD CONSTRAINT `fk_Artysta_has_Wydarzenia_Artysta1` FOREIGN KEY (`Artysta_idArtysty`) REFERENCES `artysta` (`idArtysty`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Artysta_has_Wydarzenia_Wydarzenia1` FOREIGN KEY (`Wydarzenia_idWydarzenia`) REFERENCES `wydarzenia` (`idWydarzenia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `bilety`
--
ALTER TABLE `bilety`
  ADD CONSTRAINT `fk_Bilety_Wydarzenia` FOREIGN KEY (`id_wydarzenia`) REFERENCES `wydarzenia` (`idWydarzenia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Bilety_Bilety_cena1` FOREIGN KEY (`id_cena`) REFERENCES `bilety_cena` (`idBilety_cena`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Bilety_Klient1` FOREIGN KEY (`id_klient`) REFERENCES `klient` (`idKlient`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Bilety_Bilety_typ1` FOREIGN KEY (`id_typ_biletu`) REFERENCES `bilety_typ` (`typ_biletu`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `bilety_cena`
--
ALTER TABLE `bilety_cena`
  ADD CONSTRAINT `fk_Bilety_cena_Wydarzenia1` FOREIGN KEY (`id_wydarzenia`) REFERENCES `wydarzenia` (`idWydarzenia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Bilety_cena_Bilety_kategorie1` FOREIGN KEY (`id_bilety_kategoria`) REFERENCES `bilety_kategorie` (`idBilety_kategorie`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Bilety_cena_Bilety_typ1` FOREIGN KEY (`id_bilety_typ`) REFERENCES `bilety_typ` (`idBilety_typ`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `klient`
--
ALTER TABLE `klient`
  ADD CONSTRAINT `fk_Klient_Klient_uzytkownik1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `klient_uzytkownik` (`id_uzytkownik`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `miejsce_wydarzenia`
--
ALTER TABLE `miejsce_wydarzenia`
  ADD CONSTRAINT `fk_Miejsce_wydarzenia_Wojewodztwa1` FOREIGN KEY (`id_wojewodztwo`) REFERENCES `wojewodztwa` (`idWojewodztwa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Miejsce_wydarzenia_Miejscowosci1` FOREIGN KEY (`id_miejscowosc`) REFERENCES `miejscowosci` (`idMiejscowosci`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `miejscowosci`
--
ALTER TABLE `miejscowosci`
  ADD CONSTRAINT `fk_Miejscowosci_Wojewodztwa1` FOREIGN KEY (`id_wojewodztwo`) REFERENCES `wojewodztwa` (`idWojewodztwa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `wydarzenia`
--
ALTER TABLE `wydarzenia`
  ADD CONSTRAINT `fk_Wydarzenia_Zleceniodawca1` FOREIGN KEY (`id_zleceniodawcy`) REFERENCES `zleceniodawca` (`idZleceniodawca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Wydarzenia_Pracownik1` FOREIGN KEY (`id_pracownika`) REFERENCES `pracownik` (`idPracownik`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Wydarzenia_Miejsce_wydarzenia1` FOREIGN KEY (`id_miejsce_wydarzenia`) REFERENCES `miejsce_wydarzenia` (`idMiejsce_wydarzenia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
