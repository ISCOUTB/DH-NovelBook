<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once 'configuracion/bd.php';
$conexionBD = BD::crearInstancia();

$query = $conexionBD->prepare("SELECT * FROM libros LIMIT 3");
$query->execute();
$resultado = $query->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($resultado);
?>
