<?php 

require_once("session.php");
require_once("included_functions.php");
require_once("database.php");

$mysqli = Database::dbConnect();
$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (($output = message()) !== null) {
    echo $output;
}

if(isset($_GET["id"]) && $_GET["id"] !== "") {
    try{
        $queryDEL = "DELETE FROM event WHERE id = ?";
        $stmtDEL = $mysqli -> prepare($queryDEL);
        $stmtDEL -> execute(array($_GET['id']));

        if($stmtDEL) {
            $_SESSION['message'] = 'Event successfully deleted';
        } else {
            $_SESSION['message'] = 'Unable to delete event.';
        }
    } catch (PDOException $e) {
        //Handle the exception appropriately, e.g. log the error, show a user-friendly message, etc.
        $_SESSION['message'] = "An error occurred while deleting the event.";
        redirect("read.php");
    }
}


redirect("read.php");	

new_footer("Jonah Carpenter ");
Database::dbDisconnect($mysqli);

?>
