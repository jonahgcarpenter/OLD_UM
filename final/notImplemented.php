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

/*****************  Uncomment once code is complete *************************

if (!isset($_SESSION["username"])) {
	$_SESSION["message"] = "You must log in first";
	redirect("index2023.php");
}

****************************************************************************/

?>

   <div id="page">
   <br /><br />
   <h2>Under Construction</h2>
   	<br /><p>&laquo:<a href='manage.php'>Back to Manage Content</a>

   	</div>
<?php
    new_footer(); 
    Database::dbDisconnect();
?>