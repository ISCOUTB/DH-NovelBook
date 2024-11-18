<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once 'configuracion/bd.php';
$conexionBD = BD::crearInstancia();

try {
    // Preparar y ejecutar la consulta para obtener todos los libros
    $query = $conexionBD->prepare("SELECT * FROM libros");
    $query->execute();
    
    // Obtener los resultados como un array asociativo
    $resultado = $query->fetchAll(PDO::FETCH_ASSOC);

    // Convertir las imágenes a base64
    foreach ($resultado as &$fila) {
        if (isset($fila['imagen']) && file_exists($fila['imagen'])) {
            $contenidoImagen = file_get_contents($fila['imagen']);
            $imagenBase64 = base64_encode($contenidoImagen);
            $fila['imagen'] = $imagenBase64;
        } else {
            $fila['imagen'] = null; // Si no hay imagen o no se encuentra, se establece como null
        }
    }

    // Verificar si se encontraron libros
    if ($resultado) {
        echo json_encode($resultado);
    } else {
        echo json_encode(["mensaje" => "No se encontraron libros"]);
    }
} catch (PDOException $e) {
    // Capturar y enviar el error si algo sale mal
    echo json_encode(["error" => "Error al consultar la base de datos: " . $e->getMessage()]);
}
?>
