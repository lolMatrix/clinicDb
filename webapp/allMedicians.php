<?
include("database/databaseFabric.php");

$medicians = $database->getAllMedicians();

include("html/allMedicans.php");