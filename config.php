<?php
// Conexión para el contenedor
$servername = "database"; // nombre del servicio definido en docker-compose
$username = "abgames";    // usuario definido en docker-compose
$password = "MariahCarey321."; // contraseña definida en docker-compose
$dbname = "Draftosaurus"; // nombre de la base de datos definido en docker-compose

try {
    // Crear conexión usando PDO
    $conn = new PDO("mysql:host=$servername;dbname=$dbname;charset=utf8", $username, $password);

    // Establecer el modo de error de PDO a excepción
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error en la conexión: " . $e->getMessage());
}
?>