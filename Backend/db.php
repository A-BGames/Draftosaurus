<?php
//coneccion a base de datos
$host = "localhost";
$usuario = "root";
$contrasena = ""; 
$base_de_datos = "draftosaurus"; 

$conn = new mysqli($host, $usuario, $contrasena, $base_de_datos);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}


?>