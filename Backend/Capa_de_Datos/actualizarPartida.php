<?php
include 'db.php';
$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['id_partida']) || !isset($data['id_estado']) || !isset($data['id_jugador'])) {
    echo json_encode(['success' => false, 'error' => 'Faltan parámetros']);
    exit;
}

$id_partida = intval($data['id_partida']);
$id_estado = intval($data['id_estado']); 
$id_jugador = intval($data['id_jugador']); // jugador que esta jugando 

// Actualizar estado de la partida
$sql = "UPDATE partida SET id_estado = ? WHERE id_partida = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $id_estado, $id_partida);
$stmt->execute();

// Obtener primer jugador de la partida
$sql = "SELECT id_jugador FROM partida_jugador WHERE id_partida = ? ORDER BY id_jugador ASC LIMIT 1";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id_partida);
$stmt->execute();
$result = $stmt->get_result()->fetch_assoc();
$primer_jugador = intval($result['id_jugador']);

// Incrementar turno 
if ($id_jugador === $primer_jugador) {
    // Obtener el turno más alto actual
    $sqlMax = "SELECT MAX(id_turno) AS max_turno FROM turno_partida_jugador WHERE id_partida = ?";
    $stmtMax = $conn->prepare($sqlMax);
    $stmtMax->bind_param("i", $id_partida);
    $stmtMax->execute();
    $resultMax = $stmtMax->get_result()->fetch_assoc();
    $nuevo_turno = intval($resultMax['max_turno']) + 1;

    // Actualizar el primer jugador con el nuevo turno
    $sqlUpdate = "UPDATE turno_partida_jugador 
                  SET id_turno = ? 
                  WHERE id_partida = ? AND id_jugador = ?";
    $stmtUpdate = $conn->prepare($sqlUpdate);
    $stmtUpdate->bind_param("iii", $nuevo_turno, $id_partida, $id_jugador);
    $stmtUpdate->execute();
}
// Obtener turno actual global 
$sqlTurno = "SELECT MAX(id_turno) AS turno_actual FROM turno_partida_jugador WHERE id_partida = ?";
$stmtT = $conn->prepare($sqlTurno);
$stmtT->bind_param("i", $id_partida);
$stmtT->execute();
$resultT = $stmtT->get_result()->fetch_assoc();

echo json_encode([
    'success' => true,
    'turno' => intval($resultT['turno_actual']),
    'estado' => $id_estado
]);
?>