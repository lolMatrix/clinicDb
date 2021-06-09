<?
include("database/database.php");
$database = new Database("mssql", "root", "localhost,55969", "Clinic");

$id = $_GET["id"];

$tr = $database->getTreatmentById($id)[0];
$med = $database->getMediciansByTreatmentId($id);
$total = floatval($database->getTotalPrice($id)[0][0]);

include("html/treatment.php");