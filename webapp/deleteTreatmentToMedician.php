<?
include('database/databaseFabric.php');

$treatmentId = $_GET['treatment'];
$medicianId = $_GET['medician'];

$database->deleteMedicianToTreatment($treatmentId, $medicianId);

header("Location: /treatment.php?id=$treatmentId");