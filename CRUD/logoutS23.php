<?php 
//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database
    require_once("session.php"); 
    require_once("included_functions.php");
    require_once("database.php");
    verify_login();

///////////////////////////////////////////////////////////////////////////////////
//  Step 9  -  invoke verify_login
//				Will redirect to indexS23<yourLastName>.php if there is not a SESSION admin set
//				**************** NOTE:  REPLACE <yourLastName> with your last name
//				****************        Also include the semester in the filename as noted in the instructions


///////////////////////////////////////////////////////////////////////////////////

new_header("Delete from IMDB TV"); 

//3. Output a message, if there is one
if (($output = message()) !== null) {
	echo $output;
}
/////////////////////////////////////////////////////////////////////////////////////////
// Step 10.  Kill the session by calling session_destroy()
//           Verify that after logging out, if you click to go back, you get the message you must log in first

session_destroy();
////////////////////////////////////////////////////////////////////////////////////////


 redirect("indexS23Carpenter.php");	//*************  REPLACE <yourLastName> with your last name. Don't forget the semester on the end of index!e
 
//Define footer with the phrase "Top 100 TV Shows"
//Disconnect from database database
    new_footer("Top 100 TV Shows ");    
    Database::dbDisconnect($mysqli);
 ?>
