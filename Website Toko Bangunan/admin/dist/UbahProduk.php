<?php
//session_start();
//require 'functions.php';

$id = $_GET['id'];
$produk = query("SELECT * FROM produk WHERE id_produk='$id'")[0];

if (isset($_POST["submit"])) {
    // Ambil data dari form
    $namaProduk = $_POST["nama_produk"];
    $stok = $_POST["stok"];
    $hargaProduk = $_POST["harga_produk"];
    $deskripsi = $_POST["deskripsi"];
    $fotoProduk = $_POST["foto_produk_lama"]; // Default to old photo

    // Jika ada file foto baru yang diupload, gunakan yang baru
    if ($_FILES['foto_produk']['name']) {
        $fotoProduk = $_FILES['foto_produk']['name'];
        move_uploaded_file($_FILES['foto_produk']['tmp_name'], "assets/img/" . $fotoProduk);
    }

    // Buat pernyataan SQL untuk memanggil stored procedure update_barang
    $sql = "CALL update_barang('$id', '$namaProduk','$stok','$hargaProduk', '$deskripsi', '$fotoProduk')";
    
    // Eksekusi query
    if (mysqli_query($conn, $sql)) {
        echo 
        "<script>
            alert('Produk berhasil diupdate');
            document.location.href='index.php?halaman=produk';
        </script>";
    } else {
        echo
        "<script>
            alert('Produk gagal diupdate');
            document.location.href='index.php?halaman=produk';
        </script>";
    }
}

?>

<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Halaman Ubah produk</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700">
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/Check-Out-Page-V100.css">
    <link rel="stylesheet" href="assets/css/ebs-contact-form-1.css">
    <link rel="stylesheet" href="assets/css/ebs-contact-form.css">
    <link rel="stylesheet" href="assets/css/Header-Blue.css">
    <link rel="stylesheet" href="assets/css/Login-Form-Clean.css">
    <link rel="stylesheet" href="assets/css/Navigation-with-Search.css">
    <link rel="stylesheet" href="assets/css/Pretty-Product-List.css">
    <link rel="stylesheet" href="assets/css/Profile-Edit-Form-1.css">
    <link rel="stylesheet" href="assets/css/Profile-Edit-Form.css">
    <link rel="stylesheet" href="assets/css/Registration-Form-with-Photo.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="assets/css/WOWSlider-about-us-1.css">
    <link rel="stylesheet" href="assets/css/WOWSlider-about-us-2.css">
    <link rel="stylesheet" href="assets/css/WOWSlider-about-us.css">
</head>
<body>
    <div class="container-fluid">
        <h1 class="mt-4">Update Produk</h1>
        <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
        <li class="breadcrumb-item active">Produk</li>
    </ol>
        <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id_produk" value="<?= $produk['id_produk']; ?>">
        <input type="hidden" name="foto_produk_lama" value="<?= $produk['foto_produk'];?>">
            <div class="form-grup">
                <label for="nama_produk">Nama Produk</label>
                <input type="text" value="<?= $produk['nama_produk']; ?>" name="nama_produk" class="form-control" id="nama_produk">
            </div>

            <div class="form-grup">
                <label for="stok">Stok</label>
                <input type="text" value="<?= $produk['stok']; ?>" name="stok" class="form-control" id="stok">
            </div>

            <div class="form-grup">
                <label for="harga">Harga (Rp)</label>
                <input type="number" value="<?= $produk['harga_produk'];?>" name="harga_produk" class="form-control" id="harga_produk">
            </div>

            <div class="form-grup">
                <label for="deskripsi">Deskripsi Produk</label>
                <textarea class="form-control" name="deskripsi" class="form-control" id="deskripsi" rows=5><?= $produk['deskripsi']; ?></textarea>
            </div>
            
            <div class="form-grup">
            <img src="assets/img/<?= $produk['foto_produk']; ?>" width=100 class="mt-2"> <br>
                <label for="foto">Foto Produk</label>
                <input type="file" name="foto_produk" class="form-control">
            </div>
                <button type="submit" class="btn btn-primary mt-3" name="submit" >Update</button>
        </form>
    </div>
</body>
</html>
