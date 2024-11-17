<?php 
require_once("session.php");
require_once("included_functions.php");
require_once("database.php");
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$mysqli = Database::dbConnect();
$mysqli->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

new_header("Add an Event");

if (($output = message()) !== null) {
    echo $output;
}

echo "<h3>Add an Event</h3>";
echo "<div class='row'>";
echo "<label for='left-label' class='left inline'>";

if (isset($_POST["submit"])) {

    $location_id = $_POST['location_id'];

    if (!empty($location_id)) {

        $query = "INSERT INTO event (name, date, location_id, channel, sport)
                    VALUES (:name, :date, :location_id, :channel, :sport)";

        $stmt = $mysqli->prepare($query);
        $stmt->bindParam(":name", $_POST['name']);
        $stmt->bindParam(":date", $_POST['date']);
        $stmt->bindParam(":location_id", $location_id, PDO::PARAM_INT);
        $stmt->bindParam(":channel", $_POST['channel']);
        $stmt->bindParam(":sport", $_POST['sport']);

        if ($stmt->execute()) {
            $_SESSION["message"] = "Event successfully added.";
            redirect("create.php");
        } else { 
            $_SESSION["message"] = "Could not add event.";
            redirect("create.php");
        }

    } else {
        $_SESSION["message"] = "Bad Location.";
        redirect("create.php");
    }
    
} else {
    echo "<form method='POST' action='create.php'>
    <div class='row'>
            <label for='left-label' class='left inline'>
                    <p>Event: <input type='text' name='name' /></p>
                    <p>Date: <input type='date' name='date' /></p>
                    <p>Sport: <input type='text' name='sport' /></p>
                    <p>Channel: <input type='text' name='channel' /></p>
                    <p>Location:
                    <select name='location_id'>";
                            $stmt2 = $mysqli->prepare("SELECT DISTINCT id, name FROM location");
                            $stmt2->execute();
                            while ($row = $stmt2->fetch(PDO::FETCH_ASSOC)) {
                                    echo '<option value="' . $row["id"] . '">' . $row['name'] . '</option>';
                            }
                    echo "</select></p>

                    <input type='submit' name='submit' class='tiny round button' value='Add an Event' />
            </label>
    </div>
    </form>";
}
echo "<br /><p>&laquo:<a href='read.php'>Back to Main Page</a>";
echo "</label>";
echo "</div>";

new_footer("Jonah Carpenter ");
Database::dbDisconnect($mysqli);
?>
