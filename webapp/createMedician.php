<?
include("database/databaseFabric.php");

$name = $_GET['name'];
$shelf = $_GET['shelf'];
$price = floatval($_GET['price']);

if($name == null){
    include("html/createMedician.php");
    exit;
}

$id = $database->createMedician($name, $price, $shelf);
header("Location: /medician.php?id=$id");