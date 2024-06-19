<?php
$id = $_GET["id"];

// Memanggil stored procedure dengan perintah CALL
$query = "CALL hapus_barang($id)";
$result = mysqli_query($conn, $query);

if ($result) {
    echo "
    <script>
        alert('Produk berhasil dihapus');
        document.location.href = 'index.php?halaman=produk';
    </script>";
} else {
    echo "
    <script>
        alert('Produk gagal dihapus');
        document.location.href = 'index.php?halaman=produk';
    </script>";
}

// Menutup koneksi ke database
mysqli_close($conn);
?>