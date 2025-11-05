<?php
include 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['id_partida']) || !isset($data['estado'])) {
    echo json_encode(['success' => false, 'error' => 'Datos incompletos']);
    exit;
}

$id_partida = $data['id_partida'];
$estado = $data['estado']; 

$update = $conn->prepare("UPDATE partida SET estado = ? WHERE id_partida = ?");
$update->bind_param("si", $estado, $id_partida);

if ($update->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'error' => $conn->error]);
}

$update->close();
$conn->close();
?>