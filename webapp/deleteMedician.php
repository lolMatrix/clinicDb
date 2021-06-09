<?
include("database/database.php");
$database = new Database("mssql", "root", "localhost,55969", "Clinic");

$id = $_GET["id"];
$database->deleteMedician($id);
header('Location: /allMedicians.php');
exit;