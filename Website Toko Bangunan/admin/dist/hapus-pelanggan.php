
<?php
$conn = mysqli_connect("localhost", "root", "", "tbangunan");
$idPelanggan = $_GET['id_pelanggan'];

// Buat pernyataan SQL untuk memanggil stored procedure delete_pelanggan
$sql = "CALL HapusPelanggan('$idPelanggan')";

// Eksekusi stored procedure
mysqli_query($conn, $sql);
$hapus = mysqli_affected_rows($conn);

if ($hapus > 0) {
    echo "<script>alert('Pelanggan terhapus');</script>";
    echo "<script>location='index.php?halaman=pelanggan&id=$idPelanggan';</script>";
}
?>
