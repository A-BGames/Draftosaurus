<?php
include 'db.php';

// Si se envio el formulario mediante POST, guarda los datos
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombreCompleto = $_POST['nombreCompleto']; 
    $nombreJugador = $_POST['nombreJugador'];
    $contraseña = $_POST['contraseña'];
    $correoJugador = $_POST['correoJugador'];
    $celularJugador = $_POST['celularJugador'];
    $fechaNacimiento = $_POST['fechaNacimiento'];

    // Valida los datos
    if (
    !preg_match('/^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{3,50}$/', $nombreCompleto ) ||
    !preg_match('/^[A-Za-z0-9._%+ÁÉÍÓÚáéíóúÑñ]{3,20}$/', $nombreJugador) ||
    strlen($contraseña) < 6 ||
    !filter_var($correoJugador, FILTER_VALIDATE_EMAIL) ||
    !preg_match('/^0[0-9]{9}$/', $celularJugador)
    ) {
    echo "<script>alert('Datos inválidos.'); window.history.back();</script>";
    exit();
    }

    // encripta la contraseña 
    $contraseñaHash = password_hash($contraseña, PASSWORD_DEFAULT);

    // inserta los datos en la base de datos de forma segura
    $conn->set_charset("utf8mb4");
    $sql = "INSERT INTO jugador (nombreCompleto, nombreUsuario, Contraseña, correo, celular, fechaNacimiento)
            VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssss", $nombreCompleto, $nombreJugador, $contraseñaHash, $correoJugador, $celularJugador, $fechaNacimiento);

    if ($stmt->execute()) {
        echo "<script>alert('Registro exitoso.'); window.location.href='../Frontend/InicioSesion/inicioSesion.html';</script>";
    } else {
        echo "<script>alert('Error al registrar.'); window.history.back();</script>";
    }
    $stmt->close();
}
$conn->close();
?>