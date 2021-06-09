<?
if ($_POST["name"] == NULL){
    include("html/addMedician.php");
    exit;
}
include("database/database.php");

$database = new Database("mssql", "root", "localhost,55969", "Clinic");

$name = $_POST["name"];
$price = $_POST["price"];
$life = $_POST["life"];

$database->addMedician($name, $price, $life);
header("Location: /allMedecians");