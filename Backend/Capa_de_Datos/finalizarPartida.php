<?php
include 'db.php';
$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['id_partida']) || !isset($data['jugadores']) || !isset($data['ganador'])) {
    echo json_encode(['success' => false, 'error' => 'Datos incompletos']);
    exit;
}

$id_partida = intval($data['id_partida']);
$jugadores = $data['jugadores']; 
$ganadorNombre = $data['ganador'];

// Busca el id del ganador
$stmt = $conn->prepare("SELECT id_jugador FROM jugador WHERE nombre_usuario = ?");
$stmt->bind_param("s", $ganadorNombre);
$stmt->execute();
$res = $stmt->get_result();

if ($row = $res->fetch_assoc()) {
    $ganadorId = $row['id_jugador'];
} else {
    echo json_encode(['success' => false, 'error' => 'Ganador no encontrado']);
    exit;
}
$stmt->close();



$id_estado_finalizada = 3; 

$updatePartida = $conn->prepare("UPDATE partida SET id_estado = ?, ganador = ? WHERE id_partida = ?");
$updatePartida->bind_param("iii", $id_estado_finalizada, $ganadorId, $id_partida);
$updatePartida->execute();
$updatePartida->close();


foreach ($jugadores as $j) {
    $nombreJugador = $j['nombre'];
    $puntaje = intval($j['puntaje']);

   
    $stmt = $conn->prepare("SELECT id_jugador FROM jugador WHERE nombre_usuario = ?");
    $stmt->bind_param("s", $nombreJugador);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($row = $res->fetch_assoc()) {
        $id_jugador = $row['id_jugador'];

        $updatePuntaje = $conn->prepare("UPDATE partida_jugador SET puntaje = ? WHERE id_jugador = ? AND id_partida = ?");
        $updatePuntaje->bind_param("iii", $puntaje, $id_jugador, $id_partida);
        $updatePuntaje->execute();
        $updatePuntaje->close();
    }
    $stmt->close();
}

echo json_encode(['success' => true, 'message' => 'Partida finalizada y puntajes actualizados']);
$conn->close();
?>