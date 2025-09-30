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

// Crea la partida
$stmt = $conn->prepare("INSERT INTO partida (nombre_partida, id_modo, id_estado) VALUES (?, ?, ?)");
$stmt->bind_param("sii", $nombre_partida, $id_modo, $id_estado);

if (!$stmt->execute()) {
    echo json_encode(['success' => false, 'error' => $stmt->error]);
    exit;
}

$partidaId = $stmt->insert_id;
$stmt->close();

// Inserta la fecha
$stmtFecha = $conn->prepare("INSERT INTO fecha_partida (id_partida, fecha) VALUES (?, ?)");
$stmtFecha->bind_param("is", $partidaId, $fechaHoy);
$stmtFecha->execute();
$stmtFecha->close();

// Asocia la partida con la ronda
$idRonda = 1;
$stmtRondaPartida = $conn->prepare("INSERT INTO ronda_partida (id_ronda, id_partida) VALUES (?, ?)");
$stmtRondaPartida->bind_param("ii", $idRonda, $partidaId);
$stmtRondaPartida->execute();
$stmtRondaPartida->close();


$stmtJugador = $conn->prepare("INSERT INTO partida_jugador (id_partida, id_jugador, puntaje) VALUES (?, ?, 0)");
$stmtTableroPartida = $conn->prepare("INSERT INTO tablero_partida_jugador (id_tablero, id_partida, id_jugador) VALUES (?, ?, ?)");
$stmtTurnoPartidaJugador = $conn->prepare("INSERT INTO turno_partida_jugador (id_partida, id_turno, id_jugador) VALUES (?, ?, ?)");
$stmtCrearTablero = $conn->prepare("INSERT INTO tablero (nro_tablero) VALUES (?)");


$tableroNum = 1;
$idTurno = 1; 

foreach ($jugadores as $nombreUsuario) {
    // Obtiene id del jugador
    $stmtId = $conn->prepare("SELECT id_jugador FROM jugador WHERE nombre_usuario = ?");
    $stmtId->bind_param("s", $nombreUsuario);
    $stmtId->execute();
    $result = $stmtId->get_result()->fetch_assoc();
    $stmtId->close();

    if ($result) {
        $idJugador = $result['id_jugador'];

        // Crea el tablero para cada jugador
        $stmtCrearTablero->bind_param("i", $tableroNum);
        $stmtCrearTablero->execute();
        $tableroId = $conn->insert_id;

        // Asocia un jugador a la partida
        $stmtJugador->bind_param("ii", $partidaId, $idJugador);
        $stmtJugador->execute();

        // Asocia un tablero a la partida y a un jugador
        $stmtTableroPartida->bind_param("iii", $tableroId, $partidaId, $idJugador);
        $stmtTableroPartida->execute();

        // Asocia el turno a la partida y a un jugador
        $stmtTurnoPartidaJugador->bind_param("iii", $partidaId, $idTurno, $idJugador);
        $stmtTurnoPartidaJugador->execute();

        $tableroNum++;
    }
}

// Guarda la partida en sesión
$_SESSION['partida_id'] = $partidaId;


echo json_encode(['success' => true, 'idPartida' => $partidaId]);


$stmtJugador->close();
$stmtTableroPartida->close();
$stmtTurnoPartidaJugador->close();
$stmtCrearTablero->close();
$conn->close();
?>