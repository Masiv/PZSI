SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema u409462969_bilet
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `u409462969_bilet` ;
CREATE SCHEMA IF NOT EXISTS `u409462969_bilet` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `u409462969_bilet` ;

-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Zleceniodawca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Zleceniodawca` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Zleceniodawca` (
  `idZleceniodawca` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idZleceniodawca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Pracownik_uprawnienia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Pracownik_uprawnienia` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Pracownik_uprawnienia` (
  `idpom_uprawnienia` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpom_uprawnienia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Pracownik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Pracownik` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Pracownik` (
  `idPracownik` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `Imie` VARCHAR(45) NULL,
  `Nazwisko` VARCHAR(45) NULL,
  `data_zatrudnienia` DATETIME NOT NULL,
  `stanowisko` VARCHAR(45) NULL,
  `uprawnienia_id` INT NOT NULL DEFAULT 3,
  `data_utworzenia` TIMESTAMP NULL,
  `haslo` VARCHAR(45) NOT NULL,
  `bledne_logowania` INT NOT NULL DEFAULT 0,
  `czy_zablokowane` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPracownik`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  INDEX `uprawnienia_id_idx` (`uprawnienia_id` ASC),
  CONSTRAINT `uprawnienia_id`
    FOREIGN KEY (`uprawnienia_id`)
    REFERENCES `u409462969_bilet`.`Pracownik_uprawnienia` (`idpom_uprawnienia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Wojewodztwa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Wojewodztwa` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Wojewodztwa` (
  `idWojewodztwa` INT NOT NULL,
  `nazwa_woj` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idWojewodztwa`),
  UNIQUE INDEX `nazwa_woj_UNIQUE` (`nazwa_woj` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Miejscowosci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Miejscowosci` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Miejscowosci` (
  `idMiejscowosci` INT NOT NULL AUTO_INCREMENT,
  `id_wojewodztwo` INT NOT NULL,
  `miejscowosc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMiejscowosci`),
  INDEX `fk_Miejscowosci_Wojewodztwa1_idx` (`id_wojewodztwo` ASC),
  CONSTRAINT `fk_Miejscowosci_Wojewodztwa1`
    FOREIGN KEY (`id_wojewodztwo`)
    REFERENCES `u409462969_bilet`.`Wojewodztwa` (`idWojewodztwa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Miejsce_wydarzenia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Miejsce_wydarzenia` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Miejsce_wydarzenia` (
  `idMiejsce_wydarzenia` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(45) NOT NULL,
  `id_miejscowosc` INT NOT NULL,
  `nr_domu` VARCHAR(45) NULL,
  `id_wojewodztwo` INT NOT NULL,
  `nr_lokalu` VARCHAR(45) NULL,
  `kod_pocztowy` DECIMAL(5) NULL,
  `pojemnosc` DECIMAL(6) NOT NULL,
  `Ulica` VARCHAR(45) NULL,
  `M_zwykle` DECIMAL(5) NULL,
  `M_VIP` DECIMAL(5) NULL,
  `telefon` DECIMAL(10) NULL,
  `email` VARCHAR(45) NULL,
  `opis` VARCHAR(256) NULL,
  PRIMARY KEY (`idMiejsce_wydarzenia`),
  INDEX `fk_Miejsce_wydarzenia_Wojewodztwa1_idx` (`id_wojewodztwo` ASC),
  INDEX `fk_Miejsce_wydarzenia_Miejscowosci1_idx` (`id_miejscowosc` ASC),
  CONSTRAINT `fk_Miejsce_wydarzenia_Wojewodztwa1`
    FOREIGN KEY (`id_wojewodztwo`)
    REFERENCES `u409462969_bilet`.`Wojewodztwa` (`idWojewodztwa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Miejsce_wydarzenia_Miejscowosci1`
    FOREIGN KEY (`id_miejscowosc`)
    REFERENCES `u409462969_bilet`.`Miejscowosci` (`idMiejscowosci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Wydarzenia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Wydarzenia` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Wydarzenia` (
  `idWydarzenia` INT NOT NULL AUTO_INCREMENT,
  `id_zleceniodawcy` INT NOT NULL,
  `id_pracownika` INT NULL,
  `czy_oplacone w calosci` TINYINT(1) NOT NULL DEFAULT 0,
  `id_miejsce_wydarzenia` INT NULL,
  `data_wydarzenia` DATETIME NULL,
  `id_miejscowosc` INT NOT NULL,
  PRIMARY KEY (`idWydarzenia`),
  INDEX `fk_Wydarzenia_Zleceniodawca1_idx` (`id_zleceniodawcy` ASC),
  INDEX `fk_Wydarzenia_Pracownik1_idx` (`id_pracownika` ASC),
  INDEX `fk_Wydarzenia_Miejsce_wydarzenia1_idx` (`id_miejsce_wydarzenia` ASC),
  CONSTRAINT `fk_Wydarzenia_Zleceniodawca1`
    FOREIGN KEY (`id_zleceniodawcy`)
    REFERENCES `u409462969_bilet`.`Zleceniodawca` (`idZleceniodawca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Wydarzenia_Pracownik1`
    FOREIGN KEY (`id_pracownika`)
    REFERENCES `u409462969_bilet`.`Pracownik` (`idPracownik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Wydarzenia_Miejsce_wydarzenia1`
    FOREIGN KEY (`id_miejsce_wydarzenia`)
    REFERENCES `u409462969_bilet`.`Miejsce_wydarzenia` (`idMiejsce_wydarzenia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Klient_uzytkownik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Klient_uzytkownik` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Klient_uzytkownik` (
  `id_uzytkownik` INT NOT NULL AUTO_INCREMENT,
  `uzytkownik` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(45) NOT NULL,
  `id_klienta` INT NOT NULL,
  `bledne_logowania` INT NOT NULL DEFAULT 0,
  `czy_zablokowane` INT NOT NULL DEFAULT 0,
  `ostatnie_logowanie` TIMESTAMP NULL,
  `email` VARCHAR(45) NOT NULL,
  `data_utworzenia` TIMESTAMP NULL,
  PRIMARY KEY (`id_uzytkownik`),
  UNIQUE INDEX `uzytkownik_UNIQUE` (`uzytkownik` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Klient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Klient` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Klient` (
  `idKlient` INT NOT NULL AUTO_INCREMENT,
  `id_uzytkownika` INT NOT NULL,
  `Imie` VARCHAR(45) NULL,
  `Nazwisko` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefon` DECIMAL(10) NULL,
  `miejscowosc` VARCHAR(45) NOT NULL,
  `ulica` VARCHAR(45) NULL,
  `nr_domu` VARCHAR(45) NOT NULL,
  `nr_mieszkania` VARCHAR(45) NULL,
  `kod_pocztowy` DECIMAL(5) NOT NULL,
  PRIMARY KEY (`idKlient`),
  INDEX `fk_Klient_Klient_uzytkownik1_idx` (`id_uzytkownika` ASC),
  CONSTRAINT `fk_Klient_Klient_uzytkownik1`
    FOREIGN KEY (`id_uzytkownika`)
    REFERENCES `u409462969_bilet`.`Klient_uzytkownik` (`id_uzytkownik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Bilety_kategorie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Bilety_kategorie` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Bilety_kategorie` (
  `idBilety_kategorie` INT NOT NULL AUTO_INCREMENT,
  `kategoria_cenowa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBilety_kategorie`),
  UNIQUE INDEX `kategoria_cenowa_UNIQUE` (`kategoria_cenowa` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Bilety_cena`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Bilety_cena` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Bilety_cena` (
  `idBilety_cena` INT NOT NULL AUTO_INCREMENT,
  `id_wydarzenia` INT NOT NULL,
  `id_bilety_kategoria` INT NOT NULL,
  `cena` VARCHAR(45) NULL,
  PRIMARY KEY (`idBilety_cena`),
  INDEX `fk_Bilety_cena_Wydarzenia1_idx` (`id_wydarzenia` ASC),
  INDEX `fk_Bilety_cena_Bilety_kategorie1_idx` (`id_bilety_kategoria` ASC),
  CONSTRAINT `fk_Bilety_cena_Wydarzenia1`
    FOREIGN KEY (`id_wydarzenia`)
    REFERENCES `u409462969_bilet`.`Wydarzenia` (`idWydarzenia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilety_cena_Bilety_kategorie1`
    FOREIGN KEY (`id_bilety_kategoria`)
    REFERENCES `u409462969_bilet`.`Bilety_kategorie` (`idBilety_kategorie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Bilety`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Bilety` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Bilety` (
  `idBilet` INT NOT NULL AUTO_INCREMENT,
  `id_klient` INT NOT NULL,
  `id_wydarzenia` INT NOT NULL,
  `id_cena` INT NOT NULL,
  `data_zakupu` TIMESTAMP NULL,
  `nr_miejsca` INT NOT NULL,
  `typ_miesca` VARCHAR(45) NULL,
  `kod_kreskowy` VARCHAR(45) NOT NULL,
  `czy_oplacony` TINYINT(1) NOT NULL DEFAULT 0,
  `pdf` VARCHAR(45) NULL,
  PRIMARY KEY (`idBilet`),
  INDEX `fk_Bilety_Wydarzenia_idx` (`id_wydarzenia` ASC),
  INDEX `fk_Bilety_Bilety_cena1_idx` (`id_cena` ASC),
  INDEX `fk_Bilety_Klient1_idx` (`id_klient` ASC),
  CONSTRAINT `fk_Bilety_Wydarzenia`
    FOREIGN KEY (`id_wydarzenia`)
    REFERENCES `u409462969_bilet`.`Wydarzenia` (`idWydarzenia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilety_Bilety_cena1`
    FOREIGN KEY (`id_cena`)
    REFERENCES `u409462969_bilet`.`Bilety_cena` (`idBilety_cena`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilety_Klient1`
    FOREIGN KEY (`id_klient`)
    REFERENCES `u409462969_bilet`.`Klient` (`idKlient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Artysta_typ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Artysta_typ` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Artysta_typ` (
  `idArtysta_typ` INT NOT NULL AUTO_INCREMENT,
  `typ` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idArtysta_typ`),
  UNIQUE INDEX `typ_UNIQUE` (`typ` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Artysta_podtyp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Artysta_podtyp` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Artysta_podtyp` (
  `idArtysta_podtyp` INT NOT NULL AUTO_INCREMENT,
  `podtyp` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idArtysta_podtyp`),
  UNIQUE INDEX `podtyp_UNIQUE` (`podtyp` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Artysta_ranga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Artysta_ranga` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Artysta_ranga` (
  `idArtysta_wielkosc` INT NOT NULL AUTO_INCREMENT,
  `cena_do` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idArtysta_wielkosc`),
  UNIQUE INDEX `cena_do_UNIQUE` (`cena_do` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Artysta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Artysta` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Artysta` (
  `idArtysty` INT NOT NULL,
  `Nazwa` VARCHAR(45) NOT NULL,
  `Imie` VARCHAR(45) NULL,
  `Nazwisko` VARCHAR(45) NULL,
  `id_ranga` INT NOT NULL,
  `id_zespol_typ` INT NOT NULL,
  `id_zespol_podtyp` INT NOT NULL,
  `menedzer` VARCHAR(45) NULL,
  `telefon` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `opis` VARCHAR(256) NULL,
  PRIMARY KEY (`idArtysty`),
  INDEX `fk_Artysta_Artysta_typ1_idx` (`id_zespol_typ` ASC),
  INDEX `fk_Artysta_Artysta_podtyp1_idx` (`id_zespol_podtyp` ASC),
  INDEX `fk_Artysta_Artysta_ranga1_idx` (`id_ranga` ASC),
  UNIQUE INDEX `Nazwa_UNIQUE` (`Nazwa` ASC),
  CONSTRAINT `fk_Artysta_Artysta_typ1`
    FOREIGN KEY (`id_zespol_typ`)
    REFERENCES `u409462969_bilet`.`Artysta_typ` (`idArtysta_typ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artysta_Artysta_podtyp1`
    FOREIGN KEY (`id_zespol_podtyp`)
    REFERENCES `u409462969_bilet`.`Artysta_podtyp` (`idArtysta_podtyp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artysta_Artysta_ranga1`
    FOREIGN KEY (`id_ranga`)
    REFERENCES `u409462969_bilet`.`Artysta_ranga` (`idArtysta_wielkosc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Faktury_otrzymane`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Faktury_otrzymane` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Faktury_otrzymane` (
  `idFaktury_otrzymane` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idFaktury_otrzymane`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Faktury_wystawione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Faktury_wystawione` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Faktury_wystawione` (
  `idFaktury_wystawione` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idFaktury_wystawione`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Podwykonawcy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Podwykonawcy` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Podwykonawcy` (
  `idPodwykonawcy` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idPodwykonawcy`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Sprzet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Sprzet` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Sprzet` (
  `idSprzet` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idSprzet`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Elemety_faktur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Elemety_faktur` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Elemety_faktur` (
  `idElemety_fatur` INT NOT NULL AUTO_INCREMENT,
  `id_faktura_otrzymana` VARCHAR(45) NULL,
  `marza` VARCHAR(45) NULL,
  `opis` VARCHAR(45) NOT NULL,
  `cena_netto` VARCHAR(45) NOT NULL,
  `id_vat` VARCHAR(45) NOT NULL,
  `cena_brutto` VARCHAR(45) NOT NULL,
  `ilosc` VARCHAR(45) NOT NULL DEFAULT '1',
  `cena_sumaryczna` VARCHAR(45) NOT NULL,
  `id_faktury` VARCHAR(45) NULL,
  PRIMARY KEY (`idElemety_fatur`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Dziennik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Dziennik` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Dziennik` (
  `idDziennik` INT NOT NULL AUTO_INCREMENT,
  `rodzaj_akcji` INT NULL,
  `pacownik_id` INT NULL,
  `zmieniana_tabela` VARCHAR(45) NULL,
  `id_w_tabeli` INT NULL,
  `czas` TIMESTAMP NULL,
  PRIMARY KEY (`idDziennik`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Vat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Vat` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Vat` (
  `idVat` INT NOT NULL AUTO_INCREMENT,
  `typ_vat` VARCHAR(45) NULL,
  `procent_vat` VARCHAR(45) NULL,
  PRIMARY KEY (`idVat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `u409462969_bilet`.`Artysta_has_Wydarzenia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `u409462969_bilet`.`Artysta_has_Wydarzenia` ;

CREATE TABLE IF NOT EXISTS `u409462969_bilet`.`Artysta_has_Wydarzenia` (
  `Artysta_idArtysty` INT NOT NULL,
  `Wydarzenia_idWydarzenia` INT NOT NULL,
  PRIMARY KEY (`Artysta_idArtysty`, `Wydarzenia_idWydarzenia`),
  INDEX `fk_Artysta_has_Wydarzenia_Wydarzenia1_idx` (`Wydarzenia_idWydarzenia` ASC),
  INDEX `fk_Artysta_has_Wydarzenia_Artysta1_idx` (`Artysta_idArtysty` ASC),
  CONSTRAINT `fk_Artysta_has_Wydarzenia_Artysta1`
    FOREIGN KEY (`Artysta_idArtysty`)
    REFERENCES `u409462969_bilet`.`Artysta` (`idArtysty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artysta_has_Wydarzenia_Wydarzenia1`
    FOREIGN KEY (`Wydarzenia_idWydarzenia`)
    REFERENCES `u409462969_bilet`.`Wydarzenia` (`idWydarzenia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
