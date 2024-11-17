<?php 

//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database
//3. Output a message, if there is one
require_once("session.php");
require_once("included_functions.php");
require_once("database.php");

$mysqli = Database::dbConnect();
$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (($output = message()) !== null) {
    echo $output;
}






	
  	if (isset($_GET["id"]) && $_GET["id"] !== "") {
//////////////////////////////////////////////////////////////////////////////////////				
	  //Prepare and execute a query to DELETE FROM using GET id in criterion - WHERE tvID = ?
        $query = "DELETE FROM TV_S23 WHERE tvID = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bindParam(1, $_GET['id']);
        $stmt->execute();



		// Execute query

  
		if ($stmt) {
			//Create SESSION message that the tv show was successfully deleted
            $_SESSION["message"] = "TV show deleted";

		}
		else {
			//Create SESSION message that the tv show could not be deleted
            $_SESSION["message"] = "There was a problem deleting the TV show.";
		}
		
		//************** Redirect to readS23.php
        redirect("readS23.php");
		
//////////////////////////////////////////////////////////////////////////////////////				
	}
	else {
		$_SESSION["message"] = "TV show could not be found!";
		redirect("readS23.php");
	}

			
			
//Define footer with the phrase "Top 100 TV Shows"
//Disconnect from database
new_footer("Top 100 TV Shows");
Database::dbDisconnect($mysqli);


?>