
<?php
include 'db.php';
header('Content-Type: application/json');

// Verificar la conexión 
if (!$conn) {
    echo json_encode(['success' => false, 'error' => 'Error de conexión a la base de datos']);
    exit;
}

// Obtener el ranking general
$sql = "SELECT j.nombreUsuario AS nombre, SUM(pj.puntuacion) AS puntos
        FROM jugador j
        INNER JOIN partida_jugador pj ON j.id_jugador = pj.id_jugador
        GROUP BY j.nombreUsuario
        ORDER BY puntos DESC";

$result = $conn->query($sql);

if (!$result) {
    echo json_encode(['success' => false, 'error' => $conn->error]);
    $conn->close();
    exit;
}

$ranking = [];
while ($row = $result->fetch_assoc()) {
    $ranking[] = [
        'nombre' => $row['nombre'],
        'puntos' => (int)$row['puntos']
    ];
}

echo json_encode(['success' => true, 'ranking' => $ranking]);
$conn->close();
?>