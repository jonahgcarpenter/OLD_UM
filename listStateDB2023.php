<?php   

	// Add require_once function calls as you did in take-home quiz
	// Also set up connecting to your database
	require_once("included_functions.php");
	require_once("database.php");
	
	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	// Function to display one state's information
	function printStateInfo($s){
		echo "<tr>";
		echo "<td style='text-align:center'>".$s["Name"]."</td>";
		echo "<td style='text-align:center'>".$s["Capital"]."</td>";
		echo "<td style='text-align:center'>".$s["Abbr"]."</td>";
		echo "<td style='text-align:center'>".$s["Num"]."</td>";
		echo "<td style='text-align:center'>".$s["Est"]."</td>";
		echo "<td style='text-align:center'>".$s["Flower"]."</td>";
		echo "</tr>";
	}
?>

<!DOCTYPE html>
<html lang="en">
<?php new_header("States"); ?>

<div class="row">
<label for="left-label" class="left inline">
<h2>Here is/are Your State(s)</h2>
<?php
	//*******************  Add Code here to list states *******************
	echo "<table border='1'>";
	echo "<thead><tr><th>State</th><th>Capital</th><th>Abbreviation</th><th>Order of Statehood(s)</th><th>Established</th><th>Flower</th></tr></thead>";
	echo "<tbody>";

	if(isset($_POST['ID']) && $_POST['ID'] !== ""){
		$ID = $_POST['ID'];

		$query = "SELECT * FROM statesS23 WHERE Num = ? ORDER BY Num ASC";
		$stmt = $mysqli -> prepare($query);
		$stmt -> execute([$ID]);

		while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			printStateInfo($row);
		}
	}

	else if (isset($_POST['name']) && $_POST['name'] !== "") {
		$Name = $_POST['name'];

    $query = "SELECT * FROM statesS23 WHERE Name LIKE ? ORDER BY Name ASC";
    $stmt = $mysqli -> prepare($query);
    $stmt -> execute([$Name]);

    while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        printStateInfo($row);
    }
}

else if (isset($_POST['abbr']) && $_POST['abbr'] !== "") {
	$Abbr = $_POST['abbr'];

	$query = "SELECT * FROM statesS23 WHERE Abbr LIKE ? ORDER BY Abbr ASC";
	$stmt = $mysqli -> prepare($query);
	$stmt -> execute([$Abbr]);

	while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			printStateInfo($row);
	}
}

else if (isset($_POST['capital']) && $_POST['capital'] !== "") {
	$Capital = $_POST['capital'];

	$query = "SELECT * FROM statesS23 WHERE Capital LIKE ? ORDER BY Capital ASC";
	$stmt = $mysqli -> prepare($query);
	$stmt -> execute([$Capital]);

	while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			printStateInfo($row);
	}
}

else if(isset($_POST['StartYear']) && $_POST['StartYear'] !== "" && isset($_POST['EndYear']) && $_POST['EndYear'] !== "") {
	$StartYear = $_POST['StartYear'];
	$EndYear = $_POST['EndYear'];
	$query = "SELECT * FROM statesS23 WHERE YEAR(Est) >= ? and YEAR(Est) <=  ? ORDER BY YEAR(Est) ASC";
	$stmt = $mysqli -> prepare($query);
	$stmt -> execute([$StartYear, $EndYear]);

	while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			printStateInfo($row);
	}
}

else if (isset($_POST['flower']) && $_POST['flower'] !== "") {
	$Flower = $_POST['flower'];

	$query = "SELECT * FROM statesS23 WHERE Flower = ? ORDER BY Num ASC";
	$stmt = $mysqli -> prepare($query);
	$stmt -> execute([$Flower]);

	while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			printStateInfo($row);
	}
}
	
	echo "</tbody>";
	echo "</table>";
?>

</label>
</div>
<?php 
	new_footer(); 
	Database::dbDisconnect();
?>