<?php
include 'db.php';


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $primer_nombre = trim($_POST['primer_nombre']); 
    $apellido_paterno = trim($_POST['apellido_paterno']); 
    $apellido_materno = trim($_POST['apellido_materno']); 
    $nombre_usuario = trim($_POST['nombre_usuario']);
    $contraseña = trim($_POST['contraseña']);
    $correo = trim($_POST['correo']);
    $celular = trim($_POST['celular']);
    $fecha_nacimiento = $_POST['fecha_nacimiento'];

    // Validación con expresiones regulares 
    if (
        !preg_match('/^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{3,20}$/', $primer_nombre) ||
        !preg_match('/^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{3,20}$/', $apellido_paterno) ||
        !preg_match('/^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{3,20}$/', $apellido_materno) ||
        !preg_match('/^[A-Za-z0-9._%+ÁÉÍÓÚáéíóúÑñ]{3,20}$/', $nombre_usuario) ||
        strlen($contraseña) < 6 ||
        !filter_var($correo, FILTER_VALIDATE_EMAIL) ||
        !preg_match('/^[1-9][0-9]{6}$/', $celular)
    ) {
        echo "<script>alert('Datos inválidos.'); window.history.back();</script>";
        exit();
    }

    // Encripta la contraseña 
    $contraseñaHash = password_hash($contraseña, PASSWORD_DEFAULT);

    // Inserta los datos en la base de datos de forma segura
    $conn->set_charset("utf8mb4");
    $sqlJugador = "INSERT INTO jugador (primer_nombre, apellido_paterno, apellido_materno, nombre_usuario, contraseña, correo, celular)
            VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmtJugador = $conn->prepare($sqlJugador);
    $stmtJugador->bind_param("sssssss", $primer_nombre, $apellido_paterno, $apellido_materno, $nombre_usuario, $contraseñaHash, $correo, $celular);

    if ($stmtJugador->execute()) {
        $idJugador = $conn->insert_id;

        $sqlNacimiento = "INSERT INTO nacimiento_jugador (id_jugador, fecha_nacimiento) VALUES (?, ?)";
        $stmtNacimiento = $conn->prepare($sqlNacimiento);
        $stmtNacimiento->bind_param("is", $idJugador, $fecha_nacimiento);
        $stmtNacimiento->execute();
        $stmtNacimiento->close();

        echo "<script>alert('Registro exitoso.'); window.location.href='../../Frontend/InicioSesion/inicioSesion.html';</script>";
    } else {
        echo "<script>alert('Error al registrar.'); window.history.back();</script>";
    }
    $stmtJugador->close();
}
$conn->close();
?>