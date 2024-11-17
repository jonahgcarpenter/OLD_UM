<?php
require_once("session.php"); 
require_once("included_functions.php");
require_once("database.php");

new_header("Ole Miss Sports - Jonah Carpenter"); 
$mysqli = Database::dbConnect();
$mysqli->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (($output = message()) !== null) {
  echo $output;
}

if (isset($_GET['id']) && $_GET['id'] !== "") {
  $id = $_GET['id'];
  $queryEvent = "SELECT * FROM event WHERE id = ?";
  $stmtEvent = $mysqli->prepare($queryEvent);
  $stmtEvent->execute([$id]);
  $row = $stmtEvent->fetch(PDO::FETCH_ASSOC);
  if (!$row) {
    $_SESSION["message"] = "Error! Event not found.";
    redirectTo("read.php");
  }

  $name = $row['name'];
  $date = $row['date'];
  $location_id = $row['location_id'];
  $channel = $row['channel'];
  $sport = $row['sport'];

  $queryLocation = "SELECT * FROM location";
  $stmtLocation = $mysqli->prepare($queryLocation);
  $stmtLocation->execute();

  $locationOptions = "";
  while($locationRow = $stmtLocation->fetch(PDO::FETCH_ASSOC)) {
    $selected = ($locationRow['id'] == $location_id) ? "selected" : "";
    $locationOptions .= "<option value='{$locationRow['id']}' $selected>{$locationRow['name']}, {$locationRow['address']}, {$locationRow['city']}, {$locationRow['state']}, {$locationRow['zip']}</option>";
  }

  echo "<div class='row'>";
  echo "<center>";
  echo "<h2>Update Event Information</h2>";
  echo "<form action='process_update.php?id={$id}' method='post'>";
  echo "<table>";
  echo "<tr><td>Event Name:</td><td><input type='text' name='name' value='{$name}' /></td></tr>";
  echo "<tr><td>Event Date:</td><td><input type='date' name='date' value='{$date}' /></td></tr>";
  echo "<tr><td>Location:</td><td><select name='location_id'>$locationOptions</select></td></tr>";
  echo "<tr><td>Channel:</td><td><input type='text' name='channel' value='{$channel}' /></td></tr>";
  echo "<tr><td>Sport:</td><td><input type='text' name='sport' value='{$sport}' /></td></tr>";
  echo "</table>";
  echo "<br /><input type='submit' name='submit' value='Update' />&nbsp;&nbsp;";
  echo "<a href='read.php'>Cancel</a>";
  echo "</form>";
  echo "</center>";
  echo "</div>";
}

new_footer("Jonah Carpenter "); 
Database::dbDisconnect($mysqli);

?>
