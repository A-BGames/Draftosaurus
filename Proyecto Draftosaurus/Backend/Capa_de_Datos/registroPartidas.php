<?php
include 'db.php'; 

// Obtener el idPartida desde la URL
if (!isset($_GET['id'])) {
    echo json_encode(['success' => false, 'error' => 'ID de partida no proporcionado']);
    exit;
}

$id_partida = $_GET['id'];

// Obtener jugadores asociados a la partida
$sql = "SELECT jugador.nombre_usuario, partida_jugador.puntaje 
        FROM partida_jugador 
        JOIN jugador ON partida_jugador.id_jugador = jugador.id_jugador
        WHERE partida_jugador.id_partida = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id_partida);
$stmt->execute();
$res = $stmt->get_result();

// Mostrar si devolvio algo
if ($res->num_rows > 0) {
    $jugadores = [];
    while ($row = $res->fetch_assoc()) {
        $jugadores[] = [
            'nombre' => $row['nombre_usuario'],
            'puntos' => $row['puntaje']
        ];
    }
    echo json_encode(['success' => true, 'jugadores' => $jugadores]);
} else {
    echo json_encode(['success' => false, 'error' => 'No se encontraron jugadores para esta partida']);
}

$stmt->close();
$conn->close();
?>

