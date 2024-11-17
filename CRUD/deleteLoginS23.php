<?php 
//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database

	require_once("session.php"); 
	require_once("included_functions.php");
	require_once("database.php");
	verify_login();

	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

///////////////////////////////////////////////////////////////////////////////////
//  Step 9  -  invoke verify_login
//				Will redirect to index_<yourLastName>.php if there is not a SESSION admin set
//				**************** NOTE:  REPLACE <yourLastName> with your last name
//				****************        Also include the semester in the filename as noted in the instructions


///////////////////////////////////////////////////////////////////////////////////

new_header("Delete from Metacritic"); 

//3. Output a message, if there is one
	if (($output = message()) !== null) {
		echo $output;
	}

///////////////////////////////////////////////////////////////////////////////////
// Step 5.  Get this admins ID and delete from the database
	if(isset($_GET["id"]) && $_GET["id"] !== "") {
		try{
			$queryDEL = "DELETE FROM admins WHERE id = ?";
			$stmtDEL = $mysqli -> prepare($queryDEL);
			$stmtDEL -> execute(array($_GET['id']));

			if($stmtDEL) {
				$_SESSION['message'] = 'User successfully deleted';
			} else {
				$_SESSION['message'] = 'Unable to delete user.';
			}
		} catch (PDOException $e) {
		    //Handle the exception appropriately, e.g. log the error, show a user-friendly message, etc.
		    $_SESSION['message'] = "An error occurred while deleting the user.";
		    redirect("addLoginS23.php");
		}
	}


redirect("addLoginS23.php");	
	
//Define footer with the phrase "Top 100 TV Shows"
//Disconnect from database database
	new_footer("Top 100 TV Shows ");	
	Database::dbDisconnect($mysqli);
?>