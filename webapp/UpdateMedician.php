<?
include("database/databaseFabric.php");

$id = $_GET['id'];
$name = $_GET['name'];
$shelf = $_GET['shelf'];
$price = $_GET['price'];

if($name == null){
    $medician = $database->getMedicianById($id)[0];
    include('html/updateMedician.php');
    exit;
}

$database->updateMedician($id, $shelf, floatval($price), $name);
header("Location: /medician.php?id=$id");