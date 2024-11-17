<?php 

//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database
//3. Output a message, if there is one
	require_once("session.php"); 
	require_once("included_functions.php");
	require_once("database.php");
	verify_login();
	
	new_header("Top 100 TV Shows 2023"); 
	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	if (($output = message()) !== null) {
		echo $output;
	}

  	if (isset($_GET["id"]) && $_GET["id"] !== "") {
//////////////////////////////////////////////////////////////////////////////////////				
	    //Prepare and execute a query to DELETE FROM using GET id in criterion - WHERE tvID = ?
  		try {
		    $queryDEL = "DELETE FROM TV_S23 WHERE tvID = ?";
		    $stmtDEL = $mysqli->prepare($queryDEL);
		    $stmtDEL->execute(array($_GET["id"]));

		    if ($stmtDEL) {
		        //Create SESSION message that the tv show was successfully deleted
		        $_SESSION['message'] = "TV Show has been deleted successfully.";
		        redirect("readS23.php");
		    } else {
		        //Create SESSION message that the tv show could not be deleted
		        $_SESSION['message'] = "TV Show could not be deleted successfully.";
		        redirect("readS23.php");
		    }
		} catch (PDOException $e) {
		    //Handle the exception appropriately, e.g. log the error, show a user-friendly message, etc.
		    $_SESSION['message'] = "An error occurred while deleting the TV Show.";
		    redirect("readS23.php");
		}
		
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