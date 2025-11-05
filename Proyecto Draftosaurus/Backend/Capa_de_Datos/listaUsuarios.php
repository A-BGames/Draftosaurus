<?php
include 'db.php';
header('Content-Type: application/json');

$sql = "SELECT nombre_usuario FROM jugador";
$result = $conn->query($sql);

$usuarios = [];

while ($row = $result->fetch_assoc()) {
    $usuarios[] = $row['nombre_usuario'];
}

echo json_encode($usuarios);

$conn->close();
?>