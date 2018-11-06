-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 10 Okt 2018 pada 11.20
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
-- Database: `dbgate`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbladmin`
--

CREATE TABLE `tbladmin` (
  `id` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tbladmin`
--

INSERT INTO `tbladmin` (`id`, `user`, `password`) VALUES
(1, 'embek', 'littlesamurai'),
(2, 'jamil', 'wahyu'),
(3, 'wahyu', 'jamil');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblregistrasirfid`
--

CREATE TABLE `tblregistrasirfid` (
  `id` int(11) NOT NULL,
  `rfid` varchar(25) NOT NULL,
  `waktu` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblrfid`
--

CREATE TABLE `tblrfid` (
  `id` int(11) NOT NULL,
  `rfid` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `posisi` varchar(10) NOT NULL,
  `keterangan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tblrfid`
--

INSERT INTO `tblrfid` (`id`, `rfid`, `type`, `posisi`, `keterangan`) VALUES
(8, '6430165230', 'car', 'in', '2018/08/30 - 10:41 am'),
(13, '7412110169144', 'motorcycle', '', '2018/09/08 - 09:46 am'),
(14, '372421243194', 'car', '', '2018/09/14 - 08:58 am');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblrfidardu`
--

CREATE TABLE `tblrfidardu` (
  `id` int(11) NOT NULL,
  `rfid` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL,
  `time` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tblrfidardu`
--

INSERT INTO `tblrfidardu` (`id`, `rfid`, `type`, `time`) VALUES
(232, '7412110169144', 'motorcycle', '2018/09/07 - 02:55 pm'),
(233, '7412110169144', 'motorcycle', '2018/09/07 - 02:56 pm'),
(234, '7412110169144', 'motorcycle', '2018/09/07 - 02:58 pm'),
(235, '7412110169144', 'motorcycle', '2018/09/07 - 02:59 pm'),
(236, '7412110169144', 'motorcycle', '2018/09/07 - 03:02 pm'),
(237, '7412110169144', 'motorcycle', '2018/09/07 - 03:04 pm'),
(238, '7412110169144', 'motorcycle', '2018/09/07 - 03:06 pm'),
(239, '6430165230', 'car', '2018/09/07 - 04:03 pm'),
(240, '6430165230', 'car', '2018/09/07 - 04:05 pm'),
(241, '6430165230', 'car', '2018/09/07 - 04:13 pm'),
(242, '6430165230', 'car', '2018/09/08 - 01:14 pm'),
(243, '7412110169144', 'car', '2018/09/08 - 01:14 pm'),
(244, '7412110169144', 'car', '2018/09/08 - 01:14 pm'),
(245, '7412110169144', 'car', '2018/09/08 - 01:14 pm'),
(246, '7412110169144', 'car', '2018/09/08 - 01:14 pm'),
(247, '7412110169144', 'car', '2018/09/08 - 01:14 pm'),
(248, '6430165230', 'car', '2018/09/08 - 01:14 pm'),
(249, '6430165230', 'car', '2018/09/08 - 01:14 pm'),
(250, '6430165230', 'car', '2018/09/08 - 01:14 pm'),
(251, '7412110169144', 'car', '2018/09/08 - 01:14 pm'),
(252, '6430165230', 'car', '2018/09/08 - 01:15 pm'),
(253, '7412110169144', 'car', '2018/09/08 - 01:15 pm'),
(254, '6430165230', 'car', '2018/09/08 - 01:15 pm'),
(255, '7412110169144', 'car', '2018/09/08 - 01:15 pm'),
(256, '6430165230', 'car', '2018/09/08 - 01:16 pm'),
(257, '7412110169144', 'car', '2018/09/08 - 01:16 pm'),
(258, '6430165230', 'car', '2018/09/08 - 01:16 pm'),
(259, '7412110169144', 'motorcycle', '2018/09/08 - 01:18 pm'),
(260, '7412110169144', 'motorcycle', '2018/09/08 - 01:18 pm'),
(261, '7412110169144', 'motorcycle', '2018/09/08 - 01:18 pm'),
(262, '6430165230', 'car', '2018/09/08 - 01:19 pm'),
(263, '6430165230', 'car', '2018/09/08 - 01:58 pm'),
(264, '6430165230', 'car', '2018/09/08 - 01:58 pm'),
(265, '6430165230', 'car', '2018/09/08 - 01:58 pm'),
(266, '7412110169144', 'motorcycle', '2018/09/08 - 01:58 pm'),
(267, '6430165230', 'car', '2018/09/14 - 08:33 am'),
(268, '6430165230', 'car', '2018/09/14 - 08:34 am'),
(269, '6430165230', 'car', '2018/09/14 - 08:56 am'),
(270, '372421243194', 'car', '2018/09/14 - 08:59 am'),
(271, '7412110169144', 'motorcycle', '2018/09/14 - 09:01 am'),
(272, '6430165230', 'car', '2018/09/14 - 09:09 am'),
(273, '6430165230', 'car', '2018/09/14 - 09:09 am'),
(274, '7412110169144', 'motorcycle', '2018/09/14 - 09:10 am'),
(275, '6430165230', 'car', '2018/09/17 - 04:52 pm'),
(276, '7412110169144', 'motorcycle', '2018/09/17 - 04:52 pm'),
(277, '7412110169144', 'motorcycle', '2018/09/17 - 04:52 pm'),
(278, '6430165230', 'car', '2018/09/21 - 03:21 pm'),
(279, '6430165230', 'car', '2018/09/21 - 04:01 pm'),
(280, '7412110169144', 'motorcycle', '2018/09/21 - 04:02 pm'),
(281, '6430165230', 'car', '2018/09/21 - 04:03 pm'),
(282, '7412110169144', 'motorcycle', '2018/09/21 - 04:04 pm'),
(283, '7412110169144', 'motorcycle', '2018/09/21 - 04:04 pm'),
(284, '6430165230', 'car', '2018/09/21 - 04:04 pm'),
(285, '6430165230', 'car', '2018/09/21 - 04:23 pm'),
(286, '7412110169144', 'motorcycle', '2018/09/21 - 04:23 pm');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblsementara`
--

CREATE TABLE `tblsementara` (
  `id` int(11) NOT NULL,
  `rfid` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tblsementara`
--

INSERT INTO `tblsementara` (`id`, `rfid`) VALUES
(1, '7412110169144');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbltarif`
--

CREATE TABLE `tbltarif` (
  `id` int(11) NOT NULL,
  `motor` varchar(50) NOT NULL,
  `mobil` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tbltarif`
--

INSERT INTO `tbltarif` (`id`, `motor`, `mobil`) VALUES
(3, '2000', '5000');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblregistrasirfid`
--
ALTER TABLE `tblregistrasirfid`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblrfid`
--
ALTER TABLE `tblrfid`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblrfidardu`
--
ALTER TABLE `tblrfidardu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblsementara`
--
ALTER TABLE `tblsementara`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbltarif`
--
ALTER TABLE `tbltarif`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tblregistrasirfid`
--
ALTER TABLE `tblregistrasirfid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tblrfid`
--
ALTER TABLE `tblrfid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `tblrfidardu`
--
ALTER TABLE `tblrfidardu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=287;

--
-- AUTO_INCREMENT untuk tabel `tblsementara`
--
ALTER TABLE `tblsementara`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tbltarif`
--
ALTER TABLE `tbltarif`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
