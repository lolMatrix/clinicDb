<?
include("database/databaseFabric.php");

$treatmentId = $_GET["id"];
$medicianId = $_GET["medician"];
$count = $_GET['count'];
if($medicianId == NULL){
    $arr = $database->getAllMedicians();
    include("html/addMedicianToTreatment.php");
    exit;
}

$database->addMedicianToTreatment($treatmentId, $medicianId, $count);
header("Location: /treatment.php?id=$treatmentId");