<?php 
require_once("session.php");
require_once("final_functions.php"); 
require_once("database.php");

new_header(); 
$mysqli = Database::dbConnect();
$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (($output = message()) !== null) {
	echo $output;
}
if(!isset($_SESSION["username"])) {
	$_SESSION["message"] = "You must login in first!";
	redirect("index2023.php");
}
if (($output = message()) !== null) {
	echo $output;
}

session_destroy();
redirect("index2023.php");
 

new_footer(); 
Database::dbDisconnect();
?>
