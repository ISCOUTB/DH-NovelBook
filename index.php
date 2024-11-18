<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once 'configuracion/bd.php';
$conexionBD = BD::crearInstancia();

// Verifica si la conexión es exitosa y muestra un mensaje
if ($conexionBD) {
    echo json_encode(["mensaje" => "Conexión exitosa"]);
} else {
    echo json_encode(["error" => "No se pudo conectar a la base de datos"]);
}
?>
