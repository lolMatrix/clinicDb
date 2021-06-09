<?
include("database/databaseFabric.php");

$id = $_GET['id'];

$medician = $database->getMedicianById($id)[0];

include("html/medician.php");