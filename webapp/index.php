<?
include("database/database.php");
$database = new Database("mssql", "root", "localhost,55969", "Clinic");

$page = $_GET["page"];
if($page == NULL)
    $page = 1;

$array = $database->getAllTreatments($page);
$count = $database->countTreatments()[0][0];

include("html/all.php");