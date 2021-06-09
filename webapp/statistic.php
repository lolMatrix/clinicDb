<?
include("database/databaseFabric.php");

$stats = $database->getStats();

include('html/stats.php');