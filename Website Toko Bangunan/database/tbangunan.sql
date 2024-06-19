-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2024 at 08:18 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tbangunan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cari_barang` (IN `nama_barang` VARCHAR(50))  BEGIN
    SELECT * FROM produk WHERE nama_produk LIKE CONCAT('%', nama_barang, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HapusPelanggan` (IN `pelanggan_id` INT)  BEGIN
    DELETE FROM pelanggan WHERE id_pelanggan = pelanggan_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hapus_barang` (IN `id_produk_param` INT)  BEGIN
    DELETE FROM produk WHERE id_produk = id_produk_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_barang` (IN `nama_produk_baru` VARCHAR(200), IN `stok_baru` INT(20), IN `harga_produk_baru` INT, IN `deskripsi_baru` TEXT, IN `foto_produk_baru` VARCHAR(200))  BEGIN
    DECLARE jumlah_baris INT;

    INSERT INTO produk (nama_produk, stok, harga_produk, deskripsi, foto_produk)
    VALUES (nama_produk_baru, stok_baru, harga_produk_baru, deskripsi_baru, foto_produk_baru);
    
    SET jumlah_baris = ROW_COUNT();

    IF jumlah_baris > 0 THEN
        SELECT 'Produk berhasil ditambahkan' AS STATUS;
    ELSE
        SELECT 'Produk gagal ditambahkan' AS STATUS;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_pelanggan` ()  BEGIN
    DECLARE id_pelanggan INT DEFAULT 1;
    DECLARE max_id INT;
    
    -- Mendapatkan nilai maksimum ID pelanggan dalam tabel
    SELECT MAX(id_pelanggan) INTO max_id FROM pelanggan;
    
    -- Inisialisasi untuk menghindari infinite loop
    SET max_id = COALESCE(max_id, 0);
    
    -- Looping untuk menampilkan data pelanggan
    WHILE id_pelanggan <= max_id DO
        SELECT * FROM pelanggan WHERE id_pelanggan= id_pelanggan;
        SET id_pelanggan = id_pelanggan + 1;
    END WHILE;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_barang` (IN `id_produk_param` INT, IN `nama_produk_param` VARCHAR(200), IN `stok_param` INT, IN `harga_produk_param` INT, IN `deskripsi_param` TEXT, IN `foto_produk_param` VARCHAR(100))  BEGIN
    UPDATE produk
    SET
        nama_produk = nama_produk_param,
        stok = stok_param,
        harga_produk = harga_produk_param,
        deskripsi = deskripsi_param,
        foto_produk = foto_produk_param
    WHERE
        id_produk = id_produk_param;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `Nama` varchar(30) NOT NULL,
  `username` char(7) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email_admin` varchar(40) NOT NULL,
  `telp_admin` int(30) NOT NULL,
  `alamat_admin` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `Nama`, `username`, `password`, `email_admin`, `telp_admin`, `alamat_admin`) VALUES
(0, 'Admin', 'admin', 'admin', 'admin@gmail.com', 891234566, 'Jl. Kenangan Kemana saja'),
(1, 'asalbae', 'asall', '111', 'asal@gmail.com', 1, 'bondoll');

-- --------------------------------------------------------

--
-- Stand-in structure for view `akhir`
-- (See below for the actual view)
--
CREATE TABLE `akhir` (
`nama` text
,`no_telp` varchar(20)
,`email` varchar(100)
,`tanggal_pembelian` datetime
,`total_harga` int(15)
,`status_pembelian` varchar(100)
,`alamat` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `barangdikirim`
-- (See below for the actual view)
--
CREATE TABLE `barangdikirim` (
`id_pembelian` int(11)
,`id_pelanggan` int(20)
,`nama` text
,`tanggal_pembelian` datetime
,`alamat` text
,`no_telp` varchar(20)
,`total_harga` int(15)
,`status_pembelian` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `baranglunas`
-- (See below for the actual view)
--
CREATE TABLE `baranglunas` (
`id_pembelian` int(11)
,`id_pelanggan` int(20)
,`nama` text
,`tanggal_pembelian` datetime
,`alamat` text
,`no_telp` varchar(20)
,`total_harga` int(15)
,`status_pembelian` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `baru`
-- (See below for the actual view)
--
CREATE TABLE `baru` (
`Nama_Pelanggan` varchar(30)
,`Nama_Checkout` varchar(200)
);

-- --------------------------------------------------------

--
-- Table structure for table `checkout`
--

CREATE TABLE `checkout` (
  `id_pembelian_produk` int(11) NOT NULL,
  `id_pembelian` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `harga_produk` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `sub_harga` int(11) NOT NULL,
  `deskripsi` text NOT NULL,
  `foto_produk` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `checkout`
--

INSERT INTO `checkout` (`id_pembelian_produk`, `id_pembelian`, `id_produk`, `nama`, `harga_produk`, `jumlah`, `sub_harga`, `deskripsi`, `foto_produk`) VALUES
(37, 35, 29, 'Semen', 51000, 1, 51000, '40 kg', 'semen.png'),
(38, 35, 27, 'Meteran', 27000, 1, 27000, '7,5 meter', 'meteran.jpg'),
(39, 36, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(40, 37, 52, 'spatula cat', 20000, 1, 20000, 'bagus kualitasnya', 'spt.jpeg'),
(41, 38, 22, 'Paku', 50000, 1, 50000, 'sangat berkualitas', 'paku.jpeg'),
(42, 39, 22, 'Paku', 50000, 1, 50000, 'sangat berkualitas', 'paku.jpeg'),
(43, 40, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(44, 41, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(45, 41, 27, 'Meteran', 27000, 1, 27000, '7,5 meter', 'meteran.jpg'),
(46, 42, 22, 'Pakuu', 50000, 1, 50000, 'sangat berkualitas', 'paku.jpeg'),
(47, 43, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(48, 44, 50, 'batu bata', 30000, 2, 60000, 'berkualitas', 'download.jpeg'),
(49, 45, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(50, 46, 22, 'Pakuu', 50000, 1, 50000, 'sangat berkualitas', 'paku.jpeg'),
(51, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(52, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(53, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(54, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(55, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(56, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(57, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(58, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(59, 0, 24, 'Kayu', 80000, 2, 160000, '1 Batang(4m)', 'kayu.jpg'),
(60, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(61, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(62, 0, 26, 'Cat Tembok', 85000, 1, 85000, '5 kg', 'cat.jpg'),
(63, 0, 26, 'Cat Tembok', 85000, 1, 85000, '5 kg', 'cat.jpg'),
(64, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(65, 0, 23, 'Obeng', 30000, 2, 60000, '1 Buah', 'obeng.jpg'),
(66, 0, 23, 'Obeng', 30000, 2, 60000, '1 Buah', 'obeng.jpg'),
(67, 0, 23, 'Obeng', 30000, 2, 60000, '1 Buah', 'obeng.jpg'),
(68, 0, 23, 'Obeng', 30000, 2, 60000, '1 Buah', 'obeng.jpg'),
(69, 0, 22, 'Pakuu', 50000, 1, 50000, 'sangat berkualitas', 'paku.jpeg'),
(70, 0, 22, 'Pakuu', 50000, 1, 50000, 'sangat berkualitas', 'paku.jpeg'),
(71, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(72, 0, 24, 'Kayu', 80000, 2, 160000, '1 Batang(4m)', 'kayu.jpg'),
(73, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg'),
(74, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(75, 0, 24, 'Kayu', 80000, 1, 80000, '1 Batang(4m)', 'kayu.jpg'),
(76, 0, 23, 'Obeng', 30000, 1, 30000, '1 Buah', 'obeng.jpg');

--
-- Triggers `checkout`
--
DELIMITER $$
CREATE TRIGGER `PenguranganStok` AFTER INSERT ON `checkout` FOR EACH ROW BEGIN
	UPDATE produk SET
	stok = stok-NEW.jumlah
	WHERE id_produk = NEW.id_produk;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `masihproses`
-- (See below for the actual view)
--
CREATE TABLE `masihproses` (
`id_pembelian` int(11)
,`id_pelanggan` int(20)
,`nama` text
,`tanggal_pembelian` datetime
,`alamat` text
,`no_telp` varchar(20)
,`total_harga` int(15)
,`status_pembelian` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `Nama` varchar(30) NOT NULL,
  `username` char(10) NOT NULL,
  `password` varchar(20) NOT NULL,
  `no_hp` int(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `Nama`, `username`, `password`, `no_hp`, `email`, `alamat`) VALUES
(19, 'wulan', 'wulan', '123', 2147483647, 'wulan1@gmail.com', 'bojonegoro'),
(22, 'fira', 'fira', '000', 2147483647, 'fira@gmail.com', 'sby'),
(23, 'husnul', 'husnul', '111', 2147483647, 'husnul@gamil.com', 'Malang');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_pembelian` varchar(17) NOT NULL,
  `Nama` varchar(40) NOT NULL,
  `Bank` varchar(50) NOT NULL,
  `tanggal` date NOT NULL,
  `Bukti` varchar(255) NOT NULL,
  `Jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pembelian`, `Nama`, `Bank`, `tanggal`, `Bukti`, `Jumlah`) VALUES
(40, '34', 'andre', 'bni', '2023-05-25', '2023-05-25 22;01;43download.jpeg', 30000),
(41, '35', 'hendra', 'bni', '2023-05-25', '2023-05-25 22;03;33download.jpeg', 78000),
(42, '34', 'Andreansyah', 'bni', '2023-05-25', '2023-05-25 22;51;44download.jpeg', 30000),
(43, '38', 'yuda', 'bri', '2023-05-25', '2023-05-25 23;13;18Struk-seminar-42c179385a598c3e0007f6bde43989be.jpg', 50000),
(44, '39', 'wulan', 'BRI', '2024-06-13', '2024-06-13 13;00;16h1.jpg', 50),
(45, '42', 'wulan', 'BRI', '2024-06-13', '2024-06-13 16;18;20h2.jpg', 50),
(46, '44', 'wulan', 'BRI', '2024-06-13', '2024-06-13 17;08;34h10.jpg', 60),
(47, '45', 'wulan', 'BRI', '2024-06-13', '2024-06-13 17;24;29gn.jpg', 80),
(48, '45', 'wulan', 'BRI', '2024-06-13', '2024-06-13 17;24;45h8.jpg', 80),
(49, '45', 'wulan', 'BRI', '2024-06-13', '2024-06-13 17;25;04h1.jpg', 80),
(50, '45', 'wulan', 'BRI', '2024-06-13', '2024-06-13 17;26;44h1.jpg', 80),
(51, '46', 'wulan', 'BRI', '2024-06-13', '2024-06-13 17;35;06h1.jpg', 50),
(52, '40', 'wulan', 'BRI', '2024-06-13', '2024-06-13 18;00;36h1.jpg', 80),
(53, '41', 'wulan', 'BRI', '2024-06-13', '2024-06-13 18;01;38h2.jpg', 107);

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_barang`
--

CREATE TABLE `pembelian_barang` (
  `id_pembelian` int(11) NOT NULL,
  `id_pelanggan` int(20) NOT NULL,
  `nama` text NOT NULL,
  `tanggal_pembelian` datetime NOT NULL,
  `alamat` text NOT NULL,
  `no_telp` varchar(20) NOT NULL,
  `total_harga` int(15) NOT NULL,
  `status_pembelian` varchar(100) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian_barang`
--

INSERT INTO `pembelian_barang` (`id_pembelian`, `id_pelanggan`, `nama`, `tanggal_pembelian`, `alamat`, `no_telp`, `total_harga`, `status_pembelian`) VALUES
(34, 17, 'putry', '2023-05-25 22:01:21', 'lamongan', '8777', 30000, 'Batal'),
(35, 17, 'putry', '2023-05-25 22:02:58', 'lamongan', '8777', 78000, 'Batal'),
(39, 19, 'wulan', '2024-06-13 12:59:59', 'bojonegoro', '2147483647', 50000, 'lunas'),
(40, 19, 'wulan', '2024-06-13 16:16:25', 'bojonegoro', '2147483647', 80000, 'lunas'),
(41, 19, 'wulan', '2024-06-13 16:16:51', 'bojonegoro', '2147483647', 107000, 'lunas'),
(42, 19, 'wulan', '2024-06-13 16:18:06', 'bojonegoro', '2147483647', 50000, 'Barang dikirim'),
(43, 19, 'wulan', '2024-06-13 16:53:07', 'bojonegoro', '2147483647', 30000, 'Pending'),
(44, 19, 'wulan', '2024-06-13 17:07:57', 'bojonegoro', '2147483647', 60000, ''),
(45, 19, 'wulan', '2024-06-13 17:24:10', 'bojonegoro', '2147483647', 80000, 'lunas'),
(46, 19, 'wulan', '2024-06-13 17:34:45', 'bojonegoro', '2147483647', 50000, 'Pending');

--
-- Triggers `pembelian_barang`
--
DELIMITER $$
CREATE TRIGGER `statusup` AFTER INSERT ON `pembelian_barang` FOR EACH ROW BEGIN
    UPDATE tabel_pembelian_barang
    SET STATUS = 'Pending'
    WHERE id_pembelian = NEW.id_pembelian;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `penghasilan`
-- (See below for the actual view)
--
CREATE TABLE `penghasilan` (
`total_harga_pembayaran` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(200) NOT NULL,
  `stok` int(20) NOT NULL,
  `harga_produk` int(11) NOT NULL,
  `deskripsi` text NOT NULL,
  `foto_produk` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `nama_produk`, `stok`, `harga_produk`, `deskripsi`, `foto_produk`) VALUES
(22, 'Pakuuuu', 100, 50000, 'sangat berkualitas', 'paku.jpeg'),
(23, 'Obeng', 30, 30000, '1 Buah', 'obeng.jpg'),
(24, 'Kayu', 34, 80000, '1 Batang(4m)', 'kayu.jpg'),
(25, 'Keramik', 50, 90000, 'Ukuran 20x20', 'keramik.jpg'),
(26, 'Cat Tembok', 48, 85000, '5 kg', 'cat.jpg'),
(27, 'Meteran', 47, 27000, '7,5 meter', 'meteran.jpg'),
(28, 'Sekop', 49, 50000, '1 buah', 'sekop.jpg'),
(29, 'Semen', 48, 51000, '40 kg', 'semen.png'),
(34, 'Semen Putih', 48, 58000, '40kg', 'semen putih.jpg'),
(50, 'batu bata', 18, 30000, 'berkualitas', 'download.jpeg'),
(51, 'palu', 40, 700000, 'sangat bagus', 'palu.jpeg'),
(52, 'spatula cat', 29, 20000, 'bagus kualitasnya', 'spt.jpeg'),
(57, 'Bubu', 50, 10000, 'baru', 'paku.jpeg');

--
-- Triggers `produk`
--
DELIMITER $$
CREATE TRIGGER `delete_produk` AFTER DELETE ON `produk` FOR EACH ROW BEGIN
    DECLARE id_produk_deleted INT;

    SET id_produk_deleted = OLD.id_produk;
    DELETE FROM checkout WHERE id_produk = id_produk_deleted;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `tampilkandataproduk`
-- (See below for the actual view)
--
CREATE TABLE `tampilkandataproduk` (
`id_produk` int(11)
,`nama_produk` varchar(200)
,`stok` int(20)
,`harga_produk` int(11)
,`deskripsi` text
,`foto_produk` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `akhir`
--
DROP TABLE IF EXISTS `akhir`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `akhir`  AS SELECT `pb`.`nama` AS `nama`, `pb`.`no_telp` AS `no_telp`, `p`.`email` AS `email`, `pb`.`tanggal_pembelian` AS `tanggal_pembelian`, `pb`.`total_harga` AS `total_harga`, `pb`.`status_pembelian` AS `status_pembelian`, `p`.`alamat` AS `alamat` FROM (`pembelian_barang` `pb` left join `pelanggan` `p` on(`pb`.`id_pelanggan` = `p`.`id_pelanggan`)) WHERE `pb`.`id_pembelian` <> 0 ;

-- --------------------------------------------------------

--
-- Structure for view `barangdikirim`
--
DROP TABLE IF EXISTS `barangdikirim`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `barangdikirim`  AS SELECT `pembelian_barang`.`id_pembelian` AS `id_pembelian`, `pembelian_barang`.`id_pelanggan` AS `id_pelanggan`, `pembelian_barang`.`nama` AS `nama`, `pembelian_barang`.`tanggal_pembelian` AS `tanggal_pembelian`, `pembelian_barang`.`alamat` AS `alamat`, `pembelian_barang`.`no_telp` AS `no_telp`, `pembelian_barang`.`total_harga` AS `total_harga`, `pembelian_barang`.`status_pembelian` AS `status_pembelian` FROM `pembelian_barang` WHERE `pembelian_barang`.`status_pembelian` = 'Barang dikirim' ORDER BY `pembelian_barang`.`nama` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `baranglunas`
--
DROP TABLE IF EXISTS `baranglunas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `baranglunas`  AS SELECT `pembelian_barang`.`id_pembelian` AS `id_pembelian`, `pembelian_barang`.`id_pelanggan` AS `id_pelanggan`, `pembelian_barang`.`nama` AS `nama`, `pembelian_barang`.`tanggal_pembelian` AS `tanggal_pembelian`, `pembelian_barang`.`alamat` AS `alamat`, `pembelian_barang`.`no_telp` AS `no_telp`, `pembelian_barang`.`total_harga` AS `total_harga`, `pembelian_barang`.`status_pembelian` AS `status_pembelian` FROM `pembelian_barang` WHERE `pembelian_barang`.`status_pembelian` = 'Lunas' ORDER BY `pembelian_barang`.`nama` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `baru`
--
DROP TABLE IF EXISTS `baru`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `baru`  AS SELECT `pelanggan`.`Nama` AS `Nama_Pelanggan`, `checkout`.`nama` AS `Nama_Checkout` FROM ((`pelanggan` join `pembelian_barang` on(`pelanggan`.`id_pelanggan` = `pembelian_barang`.`id_pelanggan`)) join `checkout` on(`pembelian_barang`.`id_pembelian` = `checkout`.`id_pembelian`)) ;

-- --------------------------------------------------------

--
-- Structure for view `masihproses`
--
DROP TABLE IF EXISTS `masihproses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `masihproses`  AS SELECT `pembelian_barang`.`id_pembelian` AS `id_pembelian`, `pembelian_barang`.`id_pelanggan` AS `id_pelanggan`, `pembelian_barang`.`nama` AS `nama`, `pembelian_barang`.`tanggal_pembelian` AS `tanggal_pembelian`, `pembelian_barang`.`alamat` AS `alamat`, `pembelian_barang`.`no_telp` AS `no_telp`, `pembelian_barang`.`total_harga` AS `total_harga`, `pembelian_barang`.`status_pembelian` AS `status_pembelian` FROM `pembelian_barang` WHERE `pembelian_barang`.`status_pembelian` = 'pending' ORDER BY `pembelian_barang`.`nama` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `penghasilan`
--
DROP TABLE IF EXISTS `penghasilan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `penghasilan`  AS SELECT sum(`pembayaran`.`Jumlah`) AS `total_harga_pembayaran` FROM `pembayaran` ;

-- --------------------------------------------------------

--
-- Structure for view `tampilkandataproduk`
--
DROP TABLE IF EXISTS `tampilkandataproduk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tampilkandataproduk`  AS SELECT `produk`.`id_produk` AS `id_produk`, `produk`.`nama_produk` AS `nama_produk`, `produk`.`stok` AS `stok`, `produk`.`harga_produk` AS `harga_produk`, `produk`.`deskripsi` AS `deskripsi`, `produk`.`foto_produk` AS `foto_produk` FROM `produk` ORDER BY `produk`.`nama_produk` ASC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`id_pembelian_produk`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indexes for table `pembelian_barang`
--
ALTER TABLE `pembelian_barang`
  ADD PRIMARY KEY (`id_pembelian`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `id_pembelian_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
