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

    $queryLocation = "SELECT * FROM location WHERE id = ?";
    $stmtLocation = $mysqli->prepare($queryLocation);
    $stmtLocation->execute([$location_id]);
    $locationRow = $stmtLocation->fetch(PDO::FETCH_ASSOC);
    $location = $locationRow['name'] . ', ' . $locationRow['address'] . ', ' . $locationRow['city'] . ', ' . $locationRow['state'] . ', ' . $locationRow['zip'];

    echo "<div class='row'>";
    echo "<center>";
    echo "<h2>$name</h2>";
    echo "<table>";
    echo "<tr><td>Event Date:</td><td>$date</td></tr>";
    echo "<tr><td>Location:</td><td>$location</td></tr>";
    echo "<tr><td>Channel:</td><td>$channel</td></tr>";
    echo "<tr><td>Sport:</td><td>$sport</td></tr>";
    echo "</table>";
    echo "<br /><p>&laquo:<a href='read.php'>Back to Main Page</a>";
    echo "</center>";
    echo "</div>";
  } else {
    $_SESSION["message"] = "Error! Event ID not specified.";
    redirectTo("read.php");
  }

  new_footer("Jonah Carpenter "); 
  Database::dbDisconnect($mysqli);
?>
