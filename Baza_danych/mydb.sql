-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 22 Maj 2014, 07:41
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
  `Nazwa_zespolu` varchar(45) DEFAULT NULL,
  `Imie` varchar(45) DEFAULT NULL,
  `Nazwisko` varchar(45) DEFAULT NULL,
  `id_ranga` varchar(45) DEFAULT NULL,
  `id_zespol_typ` varchar(45) DEFAULT NULL,
  `id_zespol_podtyp` varchar(45) DEFAULT NULL,
  `menedzer` varchar(45) DEFAULT NULL,
  `dane_kontaktowe` varchar(45) DEFAULT NULL,
  `opis` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idArtysty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta_podtyp`
--

CREATE TABLE IF NOT EXISTS `artysta_podtyp` (
  `idArtysta_podtyp` int(11) NOT NULL AUTO_INCREMENT,
  `podtyp` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idArtysta_podtyp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta_ranga`
--

CREATE TABLE IF NOT EXISTS `artysta_ranga` (
  `idArtysta_wielkosc` int(11) NOT NULL AUTO_INCREMENT,
  `cena_do` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idArtysta_wielkosc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `artysta_typ`
--

CREATE TABLE IF NOT EXISTS `artysta_typ` (
  `idArtysta_typ` int(11) NOT NULL AUTO_INCREMENT,
  `typ` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idArtysta_typ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilety`
--

CREATE TABLE IF NOT EXISTS `bilety` (
  `idBilet` int(11) NOT NULL AUTO_INCREMENT,
  `id_klient` varchar(45) NOT NULL,
  `id_wydarzenia` varchar(45) NOT NULL,
  `id_cena` varchar(45) NOT NULL,
  `data_zakupu` varchar(45) DEFAULT NULL,
  `nr_miejsca` varchar(45) NOT NULL,
  `typ_miesca` varchar(45) DEFAULT NULL,
  `kod_kreskowy` varchar(45) NOT NULL,
  `czy_oplacony` varchar(45) NOT NULL DEFAULT '0',
  `pdf` varchar(45) DEFAULT NULL,
  `Bilety_idBilet` int(11) NOT NULL,
  `Wydarzenia_idWydarzenia` int(11) NOT NULL,
  PRIMARY KEY (`idBilet`),
  KEY `fk_Bilety_Wydarzenia_idx` (`Wydarzenia_idWydarzenia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilety_cena`
--

CREATE TABLE IF NOT EXISTS `bilety_cena` (
  `idBilety_cena` int(11) NOT NULL AUTO_INCREMENT,
  `id_zlecenia` varchar(45) DEFAULT NULL,
  `id_bilety_kategorie` varchar(45) DEFAULT NULL,
  `cena` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idBilety_cena`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilety_kategorie`
--

CREATE TABLE IF NOT EXISTS `bilety_kategorie` (
  `idBilety_kategorie` int(10) unsigned zerofill NOT NULL,
  `kategoria_cenowa` varchar(45) NOT NULL,
  PRIMARY KEY (`idBilety_kategorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `telefon` varchar(45) DEFAULT NULL,
  `miejscowosc` varchar(45) NOT NULL,
  `ulica` varchar(45) DEFAULT NULL,
  `nr_domu` varchar(45) NOT NULL,
  `nr_mieszkania` varchar(45) DEFAULT NULL,
  `kod_pocztowy` varchar(45) NOT NULL,
  PRIMARY KEY (`idKlient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klient_uzytkownik`
--

CREATE TABLE IF NOT EXISTS `klient_uzytkownik` (
  `id_pom_uzytkownik` int(11) NOT NULL AUTO_INCREMENT,
  `uzytkownik` varchar(45) NOT NULL,
  `haslo` varchar(45) NOT NULL,
  `id_klienta` int(11) NOT NULL,
  `bledne_logowania` int(11) NOT NULL DEFAULT '0',
  `czy_zablokowane` int(11) NOT NULL DEFAULT '0',
  `ostatnie_logowanie` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `email` varchar(45) NOT NULL,
  `data_utworzenia` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_pom_uzytkownik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `miejsce_wydarzenia`
--

CREATE TABLE IF NOT EXISTS `miejsce_wydarzenia` (
  `idMiejsce_wydarzenia` int(11) NOT NULL AUTO_INCREMENT,
  `Nazwa` int(11) DEFAULT NULL,
  `id_miejscowosc` varchar(45) DEFAULT NULL,
  `Ulica` varchar(45) DEFAULT NULL,
  `nr_domu` varchar(45) DEFAULT NULL,
  `id_wojewodztwo` varchar(45) DEFAULT NULL,
  `nr_lokalu` varchar(45) DEFAULT NULL,
  `kod_pocztowy` varchar(45) DEFAULT NULL,
  `pojemnosc` varchar(45) DEFAULT NULL,
  `M_zwykle` varchar(45) DEFAULT NULL,
  `M_VIP` varchar(45) DEFAULT NULL,
  `dane_kontaktowe` varchar(45) DEFAULT NULL,
  `opis` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMiejsce_wydarzenia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `miejscowosci`
--

CREATE TABLE IF NOT EXISTS `miejscowosci` (
  `idMiejscowosci` int(11) NOT NULL AUTO_INCREMENT,
  `id_wojewodztwo` varchar(45) DEFAULT NULL,
  `miejscowosc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMiejscowosci`)
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
  `nazwa_woj` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idWojewodztwa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wydarzenia`
--

CREATE TABLE IF NOT EXISTS `wydarzenia` (
  `idWydarzenia` int(11) NOT NULL AUTO_INCREMENT,
  `id_zleceniodawcy` varchar(45) DEFAULT NULL,
  `id_pracownika` varchar(45) DEFAULT NULL,
  `czy_oplacone w calosci` varchar(45) DEFAULT NULL,
  `miejsce_wydarzenia` varchar(45) DEFAULT NULL,
  `data_wydarzenia` varchar(45) DEFAULT NULL,
  `id_miejscowosc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idWydarzenia`)
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
-- Ograniczenia dla tabeli `bilety`
--
ALTER TABLE `bilety`
  ADD CONSTRAINT `fk_Bilety_Wydarzenia` FOREIGN KEY (`Wydarzenia_idWydarzenia`) REFERENCES `wydarzenia` (`idWydarzenia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
