<?php
require_once("session.php"); 
require_once("included_functions.php");
require_once("database.php");

if(isset($_GET['id'])) {
  $event_id = $_GET['id'];
} else {
  redirect("index.php");
}

new_header("Ole Miss Sports - Jonah Carpenter"); 
$mysqli = Database::dbConnect();
$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (($output = message()) !== null) {
  echo $output;
}

echo "<div class='row'>";
echo "<center>";
echo "<h2>Players</h2>";
echo "<table>";
echo "  <thead>";
echo "<tr><th>ID</th><th>Name</th><th>Position</th><th>Jersey Number</th></tr>";
echo "</thead>";
echo "<tbody>";  

$queryPlayers = "SELECT * FROM player WHERE event_id = ?";
$stmtPlayers = $mysqli->prepare($queryPlayers);
$stmtPlayers->execute([$event_id]);

if($stmtPlayers) {
  while($row = $stmtPlayers->fetch(PDO::FETCH_ASSOC)) {
    $id = $row['id'];
    $first_name = $row['first_name'];
    $last_name = $row['last_name'];
    $position = $row['position'];
    $jersey_number = $row['jersey_number'];

    echo "<tr>";
    echo "<td>$id</td>";
    echo "<td>$first_name $last_name</td>";
    echo "<td>$position</td>";
    echo "<td>$jersey_number</td>";
    echo "</tr>";
  }
  echo "  </tbody>";
  echo "</table>";
  echo "<br /><p>&laquo:<a href='read.php'>Back to Main Page</a>";
  echo "</center>";
  echo "</div>";
} else {
  $_SESSION["message"] = "Error: Failed to retrieve player information.";
  redirect("index.php");
}




new_footer("Jonah Carpenter "); 
Database::dbDisconnect($mysqli);
?>
