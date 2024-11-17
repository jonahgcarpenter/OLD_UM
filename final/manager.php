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
//***************  Uncomment once code is complete *************************

if (!isset($_SESSION["username"]) || !isset($_SESSION["admin"])) {
	$_SESSION["message"] = "You must log in as admin first";
	redirect("index2023.php");
}

//****************************************************************************/
	echo "<h3>Car Rentals</h3>";


/////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Part 3b.  Prepare and execute QUERY 2a. displaying all car reservations in ascending order by last name
//			  Results should be displayed in a table - be sure to include <table>   and   </table>
//            Include table headers: Name (will include both first and last name), Make, Model, From (start date), To (end date), and Charge (derived by multiplying the difference in date by rate)

	$query = "SELECT carCust2023.fname, carCust2023.lname, auto2023.make, auto2023.model, rental2023.startDate, rental2023.endDate, 
	(DATEDIFF(rental2023.endDate, rental2023.startDate) * auto2023.rate) AS rentCharge
	FROM rental2023
	JOIN carCust2023 ON rental2023.driversLicense = carCust2023.driversLicense
	JOIN auto2023 ON rental2023.VIN = auto2023.VIN
	ORDER BY carCust2023.lname ASC";
	$stmt = $mysqli -> prepare($query);
	$stmt -> execute();
	if($stmt){
		echo "<table>";
		echo "<thead>";
		echo "<tr><th>Name</th><th>Make</th><th>Model</th><th>From</th><th>To</th><th>Charge</th></tr>";
		echo "</thead>";
		while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
			echo "<tr>";
			echo "<td>".$row['fname']." ".$row['lname']."</td>";
			echo "<td>".$row['make']."</td>";
			echo "<td>".$row['model']."</td>";
			echo "<td>".$row['startDate']."</td>";
			echo "<td>".$row['endDate']."</td>";
			echo "<td>".$row['rentCharge']."</td>";
			echo "</tr>";
		}
		echo "</table>";
	}
///////////////////////////////////////////////////////////////////////////////////////////
					
echo "<p />";
echo "<center>";
echo "<a href='addCustomer.php'>Add a customer</a>&nbsp;|&nbsp;";
echo "<a href='addManagement.php'>Add an employee</a>&nbsp;|&nbsp;";
echo "<a href='logout.php'>logout</a>";
echo "</center>";
echo "<br /><br />";					
echo "<hr />";
				
				
				echo "<h3>Available Cars</h3>";			
///////////////////////////////////////////////////////////////////////////////////////////
//  Part 3c.  Prepare and execute QUERIES 2c. & 2d., listing the total number of vehicles 
//            for each make and mode (ascending) in the rental fleet.  
//			  You should execute 2c and then execute 2d WITHIN 2c. I recommend using $stmt1 and $stmt2 to differentiate

//            Car categories are NOT in a table - use the <h4> header tags instead
//            Car make, model and count for each car category IS in a table. No table headers required here.


$query1 = "SELECT DISTINCT category FROM auto2023 ORDER BY category ASC";
$stmt1 = $mysqli->prepare($query1);
$stmt1->execute();
if ($stmt1) {
	while ($row1 = $stmt1->fetch(PDO::FETCH_ASSOC)) {
		echo "<h4>".$row1['category']."</h4>";
		$category = $row1['category'];
		$query2 = "SELECT make, model, COUNT(*) AS total_vehicles FROM auto2023 WHERE category=:category GROUP BY make, model ORDER BY make ASC";
		$stmt2 = $mysqli->prepare($query2);
		$stmt2->bindParam(':category', $category);
		$stmt2->execute();
		if ($stmt2) {
		echo "<table>";
		echo "<tr><th>Make</th><th>Model</th><th>Total Vehicles</th></tr>";
		while ($row2 = $stmt2->fetch(PDO::FETCH_ASSOC)) {
		echo "<tr><td>".$row2['make']."</td><td>".$row2['model']."</td><td>".$row2['total_vehicles']."</td></tr>";
		}
		echo "</table>";
		}
		}
		} else {
		echo "Error in preparing statement";
		}





///////////////////////////////////////////////////////////////////////////////////////////////
				
?>
	
			
<?php
   new_footer();
   Database::dbDisconnect();

 ?>