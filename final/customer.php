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

if (!isset($_SESSION["username"])) {
	$_SESSION["message"] = "You must log in first";
	redirect("index2023.php");
}

//****************************************************************************/

	echo "<h3>Your Car Rental Reservation</h3>";
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Part 3d QUERY 2b. - Create a query variable (query 2b. on your final) and prepare and execute query.  
//                      Output results within the table - no table headers are required.
//					    Be sure to consider the case where no reservation is found - see Sample Output



////////////////////////////////////////////////////////////////////////////
$query = "SELECT carCust2023.fname, carCust2023.lname, auto2023.make, auto2023.model, rental2023.endDate,
DATEDIFF(rental2023.startDate, rental2023.endDate) AS rentalDays,
(DATEDIFF(rental2023.startDate,rental2023.endDate) * auto2023.rate) AS rentalCharge,
payment2023.cType
FROM rental2023
JOIN carCust2023 ON rental2023.driversLicense = carCust2023.driversLicense
JOIN auto2023 ON rental2023.VIN = auto2023.VIN
JOIN payment2023 ON rental2023.rentNum = payment2023.rentNum
WHERE carCust2023.username = ?
ORDER BY rental2023.endDate DESC";
$stmt = $mysqli -> prepare($query);
$stmt -> execute([$_SESSION['username']]);
if($stmt){
	$row = $stmt -> fetch(PDO::FETCH_ASSOC);
	if($stmt->rowCount() > 0){
	echo "<table>";
	echo "<tr><td>".$row['fname']." ".$row['lname']."</td></tr>";
	echo "<tr><td>".$row['make']." ".$row['model']."</td></tr>";
	echo "<tr><td>Return Date: ".$row['endDate']."</td></tr>";
	echo "<tr><td>Total Days Rented: ".$row['rentCharge']."</td></tr>";
	echo "<tr><td>Credit Card: ".$row['cType']."</td></tr>";
	echo "</table>";
	}else{
		echo "<h2>NO Reservation Found</h2>";
	}

}

?>
	
<a href='logout.php'>logout</a>
<?php 
new_footer(); 
Database::dbDisconnect();
?>