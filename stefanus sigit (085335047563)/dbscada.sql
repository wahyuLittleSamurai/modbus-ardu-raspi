-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 09 Okt 2018 pada 05.28
-- Versi server: 10.1.32-MariaDB
-- Versi PHP: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbscada`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblmonitor`
--

CREATE TABLE `tblmonitor` (
  `id` int(11) NOT NULL,
  `idUser` varchar(50) NOT NULL,
  `suhu` varchar(50) NOT NULL,
  `kelembapan` varchar(50) NOT NULL,
  `spSuhu` varchar(50) NOT NULL,
  `spKelembapan` varchar(50) NOT NULL,
  `lamp` varchar(50) NOT NULL,
  `fan` varchar(50) NOT NULL,
  `pump` varchar(50) NOT NULL,
  `mode` varchar(10) NOT NULL,
  `waktu` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Dumping data untuk tabel `tblmonitor`
--

INSERT INTO `tblmonitor` (`id`, `idUser`, `suhu`, `kelembapan`, `spSuhu`, `spKelembapan`, `lamp`, `fan`, `pump`, `mode`, `waktu`) VALUES
(5, '1', '29', '42', '26', '90', 'true', 'false', 'true', 'true', '2018-10-08 03:15:50'),
(6, '2', '23', '24', '26', '90', 'true', 'false', 'false', 'true', '2018-10-08 03:14:05');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tblmonitor`
--
ALTER TABLE `tblmonitor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tblmonitor`
--
ALTER TABLE `tblmonitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
