<?php
include 'db.php';
session_start();

// Si el formulario fue enviado por POST, toma el usuario y contraseña
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $usuario = $_POST['usuario'] ?? '';
    $contraseña = $_POST['contraseña'] ?? '';

    //Consulta el usuario en la base de datos, evitando inyecciones SQL
    $sql = "SELECT * FROM jugador WHERE nombre_usuario = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $usuario);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($usuario = $resultado->fetch_assoc()) {
        
       if (password_verify($contraseña, $usuario['contraseña'])) {
        $_SESSION['usuario'] = $usuario['nombre_usuario'];
        header("Location: ../Frontend/Index/index.html");
        exit();
        } else {
            echo "<script>alert('Contraseña incorrecta.'); window.history.back();</script>";
        }
    } else {
        echo "<script>alert('Usuario no encontrado.'); window.history.back();</script>";
    }
    $stmt->close();
}
$conn->close();
?>