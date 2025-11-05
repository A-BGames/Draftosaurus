<?php
include 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['id_partida']) || !isset($data['jugadores'])) {
    echo json_encode(['success' => false, 'error' => 'Datos incompletos']);
    exit;
}

$id_partida = $data['id_partida'];
$jugadores = $data['jugadores']; 

foreach ($jugadores as $jugador) {
    $nombre = $jugador['nombre'];
    $puntos = $jugador['puntos'];

    
    $stmt = $conn->prepare("SELECT id_jugador FROM jugador WHERE nombreUsuario = ?");
    $stmt->bind_param("s", $nombre);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($row = $res->fetch_assoc()) {
        $id_jugador = $row['id_jugador'];

        
        $update = $conn->prepare("UPDATE partida_jugador 
                                  SET puntuacion = ? 
                                  WHERE id_jugador = ? AND id_partida = ?");
        $update->bind_param("iii", $puntos, $id_jugador, $id_partida);
        $update->execute();
        $update->close();
    }
     else {
        
    }
    $stmt->close();
}

$conn->close();
echo json_encode(['success' => true]);
?>