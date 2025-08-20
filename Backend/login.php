<?php
include 'db.php';
// Si el formulario fue enviado por POST, toma el username y password
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    //Consulta el usuario en la base de datos, evitando inyecciones SQL
    $sql = "SELECT * FROM jugador WHERE nombreUsuario = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($usuario = $resultado->fetch_assoc()) {
        
       if (password_verify($password, $usuario['Contraseña'])) {
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