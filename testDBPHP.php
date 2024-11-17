<?php 
  require_once("included_functions.php");
  require_once("database.php");
  
  new_header("Test DB");
  $mysqli = Database::dbConnect();
  $mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
?>