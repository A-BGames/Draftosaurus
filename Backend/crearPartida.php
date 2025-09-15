<?php
include 'db.php';
session_start();

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['nombre_partida']) || !isset($data['id_modo']) || !isset($data['jugadores'])) {
    echo json_encode(['success' => false, 'error' => 'Faltan parámetros']);
    exit;
}

$nombre_partida = $data['nombre_partida'];
$id_modo = intval($data['id_modo']); 
$jugadores = $data['jugadores']; // array de nombres
$fechaHoy = date('Y-m-d');
$id_estado = 1;

// crear la partida
$sql = "INSERT INTO partida (nombre_partida, fecha, id_modo, id_estado) VALUES (?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssii", $nombre_partida, $fechaHoy, $id_modo, $id_estado);

if (!$stmt->execute()) {
    echo json_encode(['success' => false, 'error' => $stmt->error]);
    exit;
}

$partidaId = $stmt->insert_id;

// Asosiar jugadores y su puntaje
$sqlJugador = "INSERT INTO partida_jugador (id_partida, id_jugador, puntaje) VALUES (?, ?, 0)";
$stmtJugador = $conn->prepare($sqlJugador);

// Asosiar tableros
$sqlTableroPartida = "INSERT INTO tablero_partida_jugador (id_tablero, id_partida, id_jugador) VALUES (?, ?, ?)";
$stmtTableroPartida = $conn->prepare($sqlTableroPartida);

// Asosiar turnos
$sqlTurnoJugador = "INSERT INTO turno_partida_jugador (id_partida, id_turno, id_jugador) VALUES (?, ?, ?)";
$stmtTurno = $conn->prepare($sqlTurnoJugador);

$tableroId = 1; 
foreach ($jugadores as $nombreUsuario) {
    $sqlId = "SELECT id_jugador FROM jugador WHERE nombre_usuario = ?";
    $stmtId = $conn->prepare($sqlId);
    $stmtId->bind_param("s", $nombreUsuario);
    $stmtId->execute();
    $result = $stmtId->get_result()->fetch_assoc();
    if ($result) {
        $idJugador = $result['id_jugador'];
        $stmtJugador->bind_param("ii", $partidaId, $idJugador);
        $stmtJugador->execute();
        
        $stmtTableroPartida->bind_param("iii", $tableroId, $partidaId, $idJugador);
        $stmtTableroPartida->execute();

        $tableroId++;
        
        $idTurno = 1;
        $stmtTurno->bind_param("iii", $partidaId, $idTurno, $idJugador);
        $stmtTurno->execute();
    }
}

$_SESSION['partida_id'] = $partidaId;
echo json_encode(['success' => true, 'idPartida' => $partidaId]);
?>