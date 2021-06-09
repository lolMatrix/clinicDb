<?
include("database/databaseFabric.php");

$id = $_GET['id'];
$description = $_GET['desc'];
$days = $_GET['days'];

if($description == null){
    $treatment = $database->getTreatmentById($id)[0];
    include("html/updateTreatment.php");
    exit;
}

$database->updateTreatment($id, $description, $days);
header("Location: /treatment.php?id=$id");