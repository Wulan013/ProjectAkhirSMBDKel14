<?php

if (isset($_POST['submit'])) {
    $nama_produk = $_POST['nama_produk'];
    $harga_produk = $_POST['harga_produk'];
    $deskripsi = $_POST['deskripsi'];
    $stok = $_POST['stok'];
    // Memproses file gambar yang diunggah
    $foto_produk = $_FILES['foto_produk']['name']; // Mendapatkan nama file gambar
    $foto_produk_tmp = $_FILES['foto_produk']['tmp_name']; // Mendapatkan path sementara file gambar
    $foto_produk_path = 'assets/img/' . $foto_produk; // Tentukan path untuk menyimpan file gambar yang diunggah

    // Pindahkan file gambar dari path sementara ke path tujuan
    move_uploaded_file($foto_produk_tmp, $foto_produk_path);

    // Menjalankan stored procedure dengan parameter tambahan
    $query = "CALL tambah_barang('$nama_produk', '$harga_produk', '$deskripsi', '$foto_produk', '$stok')";
    mysqli_query($conn, $query);

    // Memeriksa apakah barang berhasil ditambahkan
    if (mysqli_affected_rows($conn) > 0) {
        echo "<script>
        alert('Produk berhasil ditambahkan');
        document.location.href = 'index.php?halaman=produk';
        </script>";
    } else {
        echo "<script>
        alert('Produk gagal ditambahkan');
        document.location.href = 'index.php?halaman=produk';
        </script>";
    }
}

// Menutup koneksi database
mysqli_close($conn);
?>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Produk</title>
</head>
<body>
    <div class="container-fluid">
        <h1 class="mt-4">Tambah Produk</h1>
        <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
        <li class="breadcrumb-item active">Produk</li>
    </ol>
        <form action="" method="post" enctype="multipart/form-data">
            <div class="form-grup">
                <label for="nama_produk">Nama Produk</label>
                <input type="text" name="nama_produk" class="form-control" id="nama_produk" placeholder="Masukan nama produk . . . "required>
            </div>
            <div class="form-grup">
                <label for="stok">Stok</label>
                <input type="text" name="stok" class="form-control" id="stok" placeholder="Masukan stok produk . . . "required>
            </div>
            <div class="form-grup">
                <label for="harga">Harga (Rp)</label>
                <input type="number" name="harga_produk" class="form-control" id="harga_produk" placeholder="Masukan harga produk . . . "required>
            
            <div class="form-grup">
                <label for="deskripsi">Deskripsi Produk</label>
                <textarea class="form-control" name="deskripsi" class="form-control" id="deskripsi" rows=5 placeholder="Masukan deskripsi produk . . . "required></textarea>
            </div>
            <div class="form-grup">
                <label for="foto">Foto Produk</label>
                <input type="file" name="foto_produk" class="form-control"required>
            </div>
                <button type="submit" class="btn btn-primary mt-3" name="submit" >Tambah</button>
        </form>
    </div>
</body>
</html>