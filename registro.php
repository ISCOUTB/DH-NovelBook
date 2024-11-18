<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once 'configuracion/bd.php';
$conexionBD = BD::crearInstancia();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombre = $_POST['nombre'];
    $correo = $_POST['correo'];
    $contrasena = password_hash($_POST['contrasena'], PASSWORD_BCRYPT); // Encriptar la contraseña

    // Verificar si el correo ya está registrado
    $query = $conexionBD->prepare("SELECT * FROM usuarios WHERE correo = ?");
    $query->execute([$correo]);
    if ($query->rowCount() > 0) {
        echo json_encode(["error" => "El correo ya está registrado"]);
        exit;
    }

    // Insertar el nuevo usuario
    $query = $conexionBD->prepare("INSERT INTO usuarios (nombre, correo, contrasena) VALUES (?, ?, ?)");
    if ($query->execute([$nombre, $correo, $contrasena])) {
        echo json_encode(["mensaje" => "Registro exitoso"]);
    } else {
        echo json_encode(["error" => "Error al registrar el usuario"]);
    }
} else {
    echo json_encode(["error" => "Método no permitido"]);
}
?>
