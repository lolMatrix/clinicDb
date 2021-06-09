<?
include("database/databaseFabric.php");

$name = $_GET['desc'];
$count = $_GET['days'];

if($name == null){
    include("html/createTreatment.php");
    exit;
}

$id = $database->createTreatment($name, $count);
header("Location: /treatment.php?id=$id");