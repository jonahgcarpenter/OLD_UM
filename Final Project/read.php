<?php
require_once("session.php"); 
require_once("included_functions.php");
require_once("database.php");

new_header("Ole Miss Sports - Jonah Carpenter"); 
$mysqli = Database::dbConnect();
$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (($output = message()) !== null) {
  echo $output;
}

echo "<div class='row'>";
echo "<center>";
echo "<h2>Events</h2>";
echo "<table>";
echo "  <thead>";
echo "<tr><th></th><th>ID</th><th>Sport</th><th>Event</th><th>More Info</th><th>Players</th><th>Update</th></tr>";
echo "</thead>";
echo "<tbody>";  


$queryEvent = "SELECT * FROM event;";
$stmtEvent = $mysqli->prepare($queryEvent);
$stmtEvent->execute();

if($stmtEvent) {
  while($row = $stmtEvent->fetch(PDO::FETCH_ASSOC)) {
    $id = $row['id'];
    $sport = $row['sport'];
    $event = $row['name'];

    echo "<tr>";

    echo "<td><a href='delete.php?id=".urlencode($row['id'])."' onclick='return confirm(\"Are you sure?\");' style='color:red'>X</a></td>";
    echo "<td>$id</td>";
    echo "<td>$sport</td>";
    echo "<td>$event</td>";
    echo "<td><a href='event.php?id=".urlencode($row['id'])."'>More Info</a></td>";
    echo "<td><a href='players.php?id=".urlencode($row['id'])."'>View Players</a></td>";
    echo "<td><a href='update.php?id=".urlencode($row['id'])."' style='color:green'>Update</a></td>";

    echo "</tr>";
  }
  echo "  </tbody>";
  echo "</table>";
  echo "<a href='create.php'>Add an Event</a>";
  echo "</center>";
  echo "</div>";
} 

new_footer("Jonah Carpenter "); 
Database::dbDisconnect($mysqli);
?>
