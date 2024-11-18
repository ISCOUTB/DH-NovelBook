<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once 'configuracion/bd.php';
$conexionBD = BD::crearInstancia();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];

    $query = $conexionBD->prepare("SELECT * FROM usuarios WHERE correo = ?");
    $query->execute([$correo]);
    $usuario = $query->fetch(PDO::FETCH_ASSOC);

    if ($usuario && password_verify($contrasena, $usuario['contrasena'])) {
        echo json_encode(["mensaje" => "Inicio de sesión exitoso", "usuario" => $usuario]);
    } else {
        echo json_encode(["error" => "Correo o contraseña incorrectos"]);
    }
} else {
    echo json_encode(["error" => "Método no permitido"]);
}
?>
