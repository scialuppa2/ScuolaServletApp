-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 26, 2024 alle 10:38
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scuola_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `allievo`
--

CREATE TABLE `allievo` (
  `ID` int(11) NOT NULL,
  `Cod_fiscale` varchar(16) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `data_di_nascita` date NOT NULL,
  `luogo_di_nascita` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `allievo`
--

INSERT INTO `allievo` (`ID`, `Cod_fiscale`, `nome`, `cognome`, `data_di_nascita`, `luogo_di_nascita`, `email`) VALUES
(1, 'ABCDEF01G2345678', 'Mario', 'Rossi', '1995-05-10', 'Roma', 'mario.rossi@example.com'),
(9, 'BCDEFG09G0123456', 'Laura', 'Violante', '1998-12-20', 'Catania', 'laura.violante@example.com'),
(5, 'CDEFGH05C6789012', 'Marco', 'Galli', '1999-04-30', 'Firenze', 'marco.galli@example.com'),
(11, 'DLSFRZ87R13H501A', 'Fabrizio', 'Rossi', '2006-10-13', 'roma', 'fabri.rossi@gmail.com'),
(13, 'FRGTOP32F45H679D', 'Fulvio', 'Priori', '2005-11-11', 'Roma', 'fulvio.priori@gmail.com'),
(2, 'HIJKLM02N3456789', 'Luigi', 'Verdi', '1998-08-15', 'Milano', 'luigi.verdi@example.com'),
(10, 'HIJKLM10H1234567', 'Sara', 'Moroni', '1997-06-25', 'Venezia', 'sara.moroni@example.com'),
(6, 'JKLMNO06D7890123', 'Alessia', 'Rosa', '1996-07-05', 'Bologna', 'alessia.rosa@example.com'),
(12, 'LFSDRP23L12H501P', 'Flavia', 'Gucci', '2006-12-12', 'Roma', 'flavia.gucci@gmail.com'),
(3, 'OPQRST03U4567890', 'Anna', 'Bianchi', '2000-02-20', 'Napoli', 'anna.bianchi@example.com'),
(7, 'PQRSTU07E8901234', 'Simone', 'Belli', '1994-10-01', 'Palermo', 'simone.belli@example.com'),
(4, 'VWXYZA04B5678901', 'Giulia', 'Neri', '1997-11-25', 'Torino', 'giulia.neri@example.com'),
(8, 'VWXYZA08F9012345', 'Giorgio', 'Russo', '2001-03-15', 'Genova', 'giorgio.russo@example.com');

-- --------------------------------------------------------

--
-- Struttura della tabella `allievo_classe`
--

CREATE TABLE `allievo_classe` (
  `ID` int(11) NOT NULL,
  `anno_scolastico` varchar(9) NOT NULL,
  `cod_fiscale_allievo` varchar(16) NOT NULL,
  `livello_classe` int(11) NOT NULL,
  `sezione_classe` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `allievo_classe`
--

INSERT INTO `allievo_classe` (`ID`, `anno_scolastico`, `cod_fiscale_allievo`, `livello_classe`, `sezione_classe`) VALUES
(1, '2019-2020', 'ABCDEF01G2345678', 1, 'A'),
(11, '2020-2021', 'ABCDEF01G2345678', 2, 'A'),
(12, '2021-2022', 'ABCDEF01G2345678', 3, 'A'),
(13, '2022-2023', 'ABCDEF01G2345678', 4, 'A'),
(14, '2023-2024', 'ABCDEF01G2345678', 5, 'A'),
(9, '2019-2020', 'BCDEFG09G0123456', 1, 'A'),
(15, '2020-2021', 'BCDEFG09G0123456', 2, 'A'),
(16, '2021-2022', 'BCDEFG09G0123456', 3, 'A'),
(17, '2022-2023', 'BCDEFG09G0123456', 4, 'A'),
(18, '2023-2024', 'BCDEFG09G0123456', 5, 'A'),
(5, '2019-2020', 'CDEFGH05C6789012', 1, 'A'),
(19, '2020-2021', 'CDEFGH05C6789012', 2, 'A'),
(20, '2021-2022', 'CDEFGH05C6789012', 3, 'A'),
(21, '2022-2023', 'CDEFGH05C6789012', 4, 'B'),
(22, '2023-2024', 'CDEFGH05C6789012', 5, 'B'),
(2, '2023-2024', 'HIJKLM02N3456789', 1, 'A'),
(10, '2023-2024', 'HIJKLM10H1234567', 1, 'A'),
(6, '2023-2024', 'JKLMNO06D7890123', 1, 'A'),
(3, '2023-2024', 'OPQRST03U4567890', 1, 'A'),
(7, '2023-2024', 'PQRSTU07E8901234', 1, 'A'),
(4, '2023-2024', 'VWXYZA04B5678901', 1, 'A'),
(8, '2023-2024', 'VWXYZA08F9012345', 1, 'A');

-- --------------------------------------------------------

--
-- Struttura della tabella `amministrativo`
--

CREATE TABLE `amministrativo` (
  `ID` int(11) NOT NULL,
  `Cod_fiscale` varchar(16) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `data_di_nascita` date NOT NULL,
  `luogo_di_nascita` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `ufficio_di_competenza` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `amministrativo`
--

INSERT INTO `amministrativo` (`ID`, `Cod_fiscale`, `nome`, `cognome`, `data_di_nascita`, `luogo_di_nascita`, `email`, `ufficio_di_competenza`) VALUES
(1, 'ABCDEF21G2345678', 'Lara', 'Felici', '1980-05-10', 'Roma', 'lara.felici@example.com', 'Segreteria Generale'),
(4, 'DLSFRZ87R13H501A', 'Fabrizio', 'D\'Alessandro', '1987-10-13', 'Roma', 'scialuppa2@gmail.com', 'Segreteria Generale'),
(2, 'HIJKLM22N3456789', 'Franco', 'Milotti', '1975-08-15', 'Viterbo', 'franco.milotti@example.com', 'Segreteria Didattica'),
(3, 'OPQRST23U4567890', 'Gaia', 'Crespi', '1983-02-20', 'Latina', 'gaia.crespi@example.com', 'Segreteria Amministrativa');

-- --------------------------------------------------------

--
-- Struttura della tabella `classe`
--

CREATE TABLE `classe` (
  `livello` int(11) NOT NULL,
  `sezione` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `classe`
--

INSERT INTO `classe` (`livello`, `sezione`) VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(1, 'D'),
(2, 'A'),
(2, 'B'),
(2, 'C'),
(2, 'D'),
(3, 'A'),
(3, 'B'),
(3, 'C'),
(3, 'D'),
(4, 'A'),
(4, 'B'),
(4, 'C'),
(4, 'D'),
(5, 'A'),
(5, 'B'),
(5, 'C'),
(5, 'D');

-- --------------------------------------------------------

--
-- Struttura della tabella `docente`
--

CREATE TABLE `docente` (
  `ID` int(11) NOT NULL,
  `Cod_fiscale` varchar(16) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `data_di_nascita` date NOT NULL,
  `luogo_di_nascita` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docente`
--

INSERT INTO `docente` (`ID`, `Cod_fiscale`, `nome`, `cognome`, `data_di_nascita`, `luogo_di_nascita`, `email`) VALUES
(1, 'ABCDEF11G2345678', 'Paolo', 'Bianchetti', '1978-09-15', 'Roma', 'paolo.bianchetti@example.com'),
(5, 'CDEFGH15C6789012', 'Giorgio', 'Gallo', '1988-02-05', 'Firenze', 'giorgio.giallo@example.com'),
(6, 'FGTJKN34F56H678T', 'Mirella', 'Dario', '1978-01-30', 'Ancona', 'mirella.dario@gmail.com'),
(2, 'HIJKLM12N3456789', 'Anna', 'Rossini', '1985-04-20', 'Milano', 'anna.rossini@example.com'),
(3, 'OPQRST13U4567890', 'Luca', 'Verdini', '1980-12-10', 'Napoli', 'luca.verdini@example.com'),
(4, 'VWXYZA14B5678901', 'Maria', 'Neri', '1975-07-25', 'Torino', 'maria.neri@example.com');

-- --------------------------------------------------------

--
-- Struttura della tabella `docente_classe`
--

CREATE TABLE `docente_classe` (
  `ID` int(11) NOT NULL,
  `anno_scolastico` varchar(9) NOT NULL,
  `cod_fiscale_docente` varchar(16) NOT NULL,
  `livello_classe` int(11) NOT NULL,
  `sezione_classe` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docente_classe`
--

INSERT INTO `docente_classe` (`ID`, `anno_scolastico`, `cod_fiscale_docente`, `livello_classe`, `sezione_classe`) VALUES
(1, '2023-2024', 'ABCDEF11G2345678', 1, 'A'),
(5, '2023-2024', 'CDEFGH15C6789012', 1, 'A'),
(2, '2023-2024', 'HIJKLM12N3456789', 1, 'A'),
(3, '2023-2024', 'OPQRST13U4567890', 1, 'A'),
(4, '2023-2024', 'VWXYZA14B5678901', 1, 'A');

-- --------------------------------------------------------

--
-- Struttura della tabella `docente_materia`
--

CREATE TABLE `docente_materia` (
  `ID` int(11) NOT NULL,
  `anno_scolastico` varchar(9) NOT NULL,
  `cod_fiscale_docente` varchar(16) NOT NULL,
  `nome_materia` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `docente_materia`
--

INSERT INTO `docente_materia` (`ID`, `anno_scolastico`, `cod_fiscale_docente`, `nome_materia`) VALUES
(1, '2023-2024', 'VWXYZA14B5678901', 'Arte'),
(2, '2023-2024', 'ABCDEF11G2345678', 'Storia'),
(3, '2023-2024', 'HIJKLM12N3456789', 'Informatica'),
(4, '2023-2024', 'VWXYZA14B5678901', 'Storia'),
(5, '2023-2024', 'VWXYZA14B5678901', 'Religione');

-- --------------------------------------------------------

--
-- Struttura della tabella `materia`
--

CREATE TABLE `materia` (
  `ID` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `materia`
--

INSERT INTO `materia` (`ID`, `nome`) VALUES
(1, 'Matematica'),
(2, 'Italiano'),
(3, 'Storia'),
(4, 'Scienze'),
(5, 'Inglese'),
(6, 'Filosofia'),
(7, 'Educazione Fisica'),
(8, 'Geografia'),
(9, 'Arte'),
(10, 'Musica'),
(11, 'Religione'),
(12, 'Informatica');

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

CREATE TABLE `utente` (
  `id` int(11) NOT NULL,
  `nome_utente` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `connesso` tinyint(1) NOT NULL,
  `ruolo` varchar(50) NOT NULL,
  `Codice_Fiscale` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utente`
--

INSERT INTO `utente` (`id`, `nome_utente`, `password`, `connesso`, `ruolo`, `Codice_Fiscale`) VALUES
(1, 'Mario', 'mario123', 0, 'allievo', 'ABCDEF01G2345678'),
(2, 'Fabrizio', 'fabri.87', 0, 'amministratore', 'DLSFRZ87R13H501A'),
(3, 'Paolo', 'paolo123', 1, 'docente', 'ABCDEF11G2345678');

-- --------------------------------------------------------

--
-- Struttura della tabella `verifica`
--

CREATE TABLE `verifica` (
  `ID` int(11) NOT NULL,
  `data_verifica` datetime NOT NULL,
  `cod_fiscale_allievo` varchar(16) NOT NULL,
  `materia` varchar(100) NOT NULL,
  `cod_fiscale_docente` varchar(16) NOT NULL,
  `voto` decimal(2,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `verifica`
--

INSERT INTO `verifica` (`ID`, `data_verifica`, `cod_fiscale_allievo`, `materia`, `cod_fiscale_docente`, `voto`) VALUES
(3, '2024-05-10 10:00:00', 'ABCDEF01G2345678', 'Informatica', 'HIJKLM12N3456789', 8.5),
(4, '2024-05-11 11:00:00', 'OPQRST03U4567890', 'Informatica', 'HIJKLM12N3456789', 7.0),
(6, '2024-05-17 00:00:00', 'FRGTOP32F45H679D', 'Filosofia', 'OPQRST13U4567890', 6.0),
(5, '2024-05-23 00:00:00', 'JKLMNO06D7890123', 'Informatica', 'VWXYZA14B5678901', 5.5),
(7, '2024-05-23 10:00:00', 'VWXYZA04B5678901', 'Italiano', 'ABCDEF11G2345678', 7.5);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `allievo`
--
ALTER TABLE `allievo`
  ADD PRIMARY KEY (`Cod_fiscale`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indici per le tabelle `allievo_classe`
--
ALTER TABLE `allievo_classe`
  ADD PRIMARY KEY (`cod_fiscale_allievo`,`anno_scolastico`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `livello_classe` (`livello_classe`,`sezione_classe`);

--
-- Indici per le tabelle `amministrativo`
--
ALTER TABLE `amministrativo`
  ADD PRIMARY KEY (`Cod_fiscale`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indici per le tabelle `classe`
--
ALTER TABLE `classe`
  ADD PRIMARY KEY (`livello`,`sezione`);

--
-- Indici per le tabelle `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`Cod_fiscale`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indici per le tabelle `docente_classe`
--
ALTER TABLE `docente_classe`
  ADD PRIMARY KEY (`cod_fiscale_docente`,`anno_scolastico`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `livello_classe` (`livello_classe`,`sezione_classe`);

--
-- Indici per le tabelle `docente_materia`
--
ALTER TABLE `docente_materia`
  ADD PRIMARY KEY (`anno_scolastico`,`cod_fiscale_docente`,`nome_materia`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `cod_fiscale_docente` (`cod_fiscale_docente`),
  ADD KEY `nome_materia` (`nome_materia`);

--
-- Indici per le tabelle `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`nome`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indici per le tabelle `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `verifica`
--
ALTER TABLE `verifica`
  ADD PRIMARY KEY (`data_verifica`,`cod_fiscale_allievo`,`materia`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `cod_fiscale_allievo` (`cod_fiscale_allievo`),
  ADD KEY `materia` (`materia`),
  ADD KEY `cod_fiscale_docente` (`cod_fiscale_docente`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `allievo`
--
ALTER TABLE `allievo`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT per la tabella `allievo_classe`
--
ALTER TABLE `allievo_classe`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT per la tabella `amministrativo`
--
ALTER TABLE `amministrativo`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `docente`
--
ALTER TABLE `docente`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `docente_classe`
--
ALTER TABLE `docente_classe`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `docente_materia`
--
ALTER TABLE `docente_materia`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `materia`
--
ALTER TABLE `materia`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `utente`
--
ALTER TABLE `utente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `verifica`
--
ALTER TABLE `verifica`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `allievo_classe`
--
ALTER TABLE `allievo_classe`
  ADD CONSTRAINT `allievo_classe_ibfk_1` FOREIGN KEY (`cod_fiscale_allievo`) REFERENCES `allievo` (`Cod_fiscale`),
  ADD CONSTRAINT `allievo_classe_ibfk_2` FOREIGN KEY (`livello_classe`,`sezione_classe`) REFERENCES `classe` (`livello`, `sezione`);

--
-- Limiti per la tabella `docente_classe`
--
ALTER TABLE `docente_classe`
  ADD CONSTRAINT `docente_classe_ibfk_1` FOREIGN KEY (`cod_fiscale_docente`) REFERENCES `docente` (`Cod_fiscale`),
  ADD CONSTRAINT `docente_classe_ibfk_2` FOREIGN KEY (`livello_classe`,`sezione_classe`) REFERENCES `classe` (`livello`, `sezione`);

--
-- Limiti per la tabella `docente_materia`
--
ALTER TABLE `docente_materia`
  ADD CONSTRAINT `docente_materia_ibfk_1` FOREIGN KEY (`cod_fiscale_docente`) REFERENCES `docente` (`Cod_fiscale`),
  ADD CONSTRAINT `docente_materia_ibfk_2` FOREIGN KEY (`nome_materia`) REFERENCES `materia` (`nome`);

--
-- Limiti per la tabella `verifica`
--
ALTER TABLE `verifica`
  ADD CONSTRAINT `verifica_ibfk_1` FOREIGN KEY (`cod_fiscale_allievo`) REFERENCES `allievo` (`Cod_fiscale`),
  ADD CONSTRAINT `verifica_ibfk_2` FOREIGN KEY (`materia`) REFERENCES `materia` (`nome`),
  ADD CONSTRAINT `verifica_ibfk_3` FOREIGN KEY (`cod_fiscale_docente`) REFERENCES `docente` (`Cod_fiscale`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
