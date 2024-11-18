<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once 'configuracion/bd.php';
$conexionBD = BD::crearInstancia();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Validar datos recibidos
    $titulo = isset($_POST['titulo']) ? $_POST['titulo'] : null;
    $autor = isset($_POST['autor']) ? $_POST['autor'] : null;
    $descripcion = isset($_POST['descripcion']) ? $_POST['descripcion'] : null;

    if (!$titulo || !$autor || !$descripcion) {
        echo json_encode(["error" => "Todos los campos de texto son obligatorios"]);
        exit();
    }

    $imagenRuta = null;
    $pdfRuta = null;

    // Verificar y manejar la imagen
    if (isset($_FILES['imagen']) && $_FILES['imagen']['error'] === UPLOAD_ERR_OK) {
        $imagenNombre = basename($_FILES['imagen']['name']);
        $imagenRuta = 'uploads/' . $imagenNombre;

        if (!move_uploaded_file($_FILES['imagen']['tmp_name'], $imagenRuta)) {
            echo json_encode(["error" => "Error al guardar la imagen"]);
            exit();
        }
    }

    // Verificar y manejar el PDF
    if (isset($_FILES['pdf']) && $_FILES['pdf']['error'] === UPLOAD_ERR_OK) {
        $pdfNombre = basename($_FILES['pdf']['name']);
        $pdfRuta = 'uploads/' . $pdfNombre;

        if (!move_uploaded_file($_FILES['pdf']['tmp_name'], $pdfRuta)) {
            echo json_encode(["error" => "Error al guardar el PDF"]);
            exit();
        }
    }

    // Insertar los datos en la base de datos
    try {
        $sql = "INSERT INTO libros (titulo, autor, descripcion, imagen, pdf) VALUES (?, ?, ?, ?, ?)";
        $stmt = $conexionBD->prepare($sql);
        $stmt->execute([$titulo, $autor, $descripcion, $imagenRuta, $pdfRuta]);

        echo json_encode(["mensaje" => "Libro agregado exitosamente"]);
    } catch (PDOException $e) {
        echo json_encode(["error" => "Error al insertar en la base de datos: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["error" => "Método no permitido"]);
}
?>
