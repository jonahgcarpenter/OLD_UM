<?php 
//  NOTE: NOT all comments will reference the S23.php

//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database
//3. Output a message, if there is one
    require_once("session.php");
    require_once("included_functions.php");
    require_once("database.php");
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

    $mysqli = Database::dbConnect();
    $mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    new_header("Update Entry");
    if (($output = message()) !== null) {
        echo $output;
    }




	echo "<h3>Update A TV Show</h3>";
	echo "<div class='row'>";
	echo "<label for='left-label' class='left inline'>";

	if (isset($_POST["submit"])) {
///////////////////////////////////////////////////////////////////////////////////////////				
		//Step 2.
		//Create an UPDATE query using anonymous parameters and the criterion WHERE tvID = ?
        $query = "UPDATE TV_S23 SET title = ?, imdbRating = ? WHERE tvID = ?";

					
		//Prepare and execute query (use $_POST values from submitted form)
        $stmt = $mysqli->prepare($query);
        $stmt -> bindParam(1, $_POST['title'], PDO::PARAM_STR);
        $stmt -> bindParam(2, $_POST['imdb'], PDO::PARAM_STR);
        $stmt -> bindParam(3, $_POST['tvID'], PDO::PARAM_INT);
        $stmt -> execute();

		
		//Verify $stmt executed
        if ($stmt) {
		//If so, you need to also determine if a genre was selected and insert into TV_GENRES_S23 for this tv show - use stmt2 and row2
		//NOTE: You will need to verify this genre does not already exist for the TV show (you break your code if you try to insert a genre that already exists)
		//	    Create another query that selects - use stmtVerify
		//      $stmtVerify -> rowCount() returns the number of rows - if you need to add this genre you expect 0 rows
            $_SESSION["message"] = "{$_POST['title']} has been updated.";
            if (isset($_POST['genre']) && $_POST['genre'] !== "") {
                $query2 = "SELECT * FROM TV_GENRES_S23 WHERE tvID = ? AND genreID = ?";
                $stmtVerify = $mysqli->prepare($query2);
                $stmtVerify->bindParam(1, $_POST['tvID'], PDO::PARAM_INT);
                $stmtVerify->bindParam(2, $_POST['genre'], PDO::PARAM_INT);
                $stmtVerify->execute();
                if ($stmtVerify->rowCount() === 0) {
                    $query3 = "INSERT INTO TV_GENRES_S23(tvID, genreID) VALUES(?, ?)";
                    $stmt2 = $mysqli->prepare($query3);
                    $stmt2->bindParam(1, $_POST['tvID'], PDO::PARAM_INT);
                    $stmt2->bindParam(2, $_POST['genre'], PDO::PARAM_INT);
                    $stmt2->execute();
                    if ($stmt2) {
                        $_SESSION["message"] = "Genre updated";
                    }
                } else {
                    $_SESSION["message"] = "{$_POST['title']} already has this genre.";
                }
            }
        } else {
            $_SESSION["message"] = "There was an error updating {$_POST['title']}.";
        }
		//If the statement did not execute, create a SESSION message that thetv show already has this genre

		//Now execute $stmt2 and verify $stmt2 executed - create a SESSION message that this video game was updated
		//If the statement did not execute, create a SESSION message that there was an error updating the game





		//Redirect back to read.php



///////////////////////////////////////////////////////////////////////////////////////////

		//Output query results and return to read.php			
		if($stmt) {
			$_SESSION["message"] = $_POST["title"]." has been changed";
		}
		else {
			$_SESSION["message"] = "Error! Could not change ".$_POST["title"];
		}
		redirect("readS23.php");
	}
	else {
///////////////////////////////////////////////////////////////////////////////////////////
	  //Step 1.
	  if (isset($_GET["id"]) && $_GET["id"] !== "") {
	  //Prepare and execute a query to SELECT FROM TV_S23, TV_GENRES_S23 and GENRES_S23
      //using GET id in criterion - WHERE tvID = ?
          $query = "SELECT *, GROUP_CONCAT(GENRES_S23.name SEPARATOR ', ') AS genres 
                FROM TV_S23 NATURAL JOIN TV_GENRES_S23 LEFT OUTER JOIN GENRES_S23 ON TV_GENRES_S23.genreID = GENRES_S23.genreID 
                WHERE tvID = ?
                GROUP BY TV_S23.tvID ORDER BY TV_S23.tvID";
          $stmt = $mysqli->prepare($query);
          $stmt->bindParam(1, $_GET['id']);
          $stmt -> execute();


	  
		//Verify statement successfully executed - I assume that results are returned to variable $stmt
		if ($stmt)  {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            $seasons = $row['end'] - $row['start'] + 1;
            echo "<form method='POST' action='updateS23.php'>
            <div class='row'>
                <label for='left-label' class='left inline'>
                    <p>Title: <input value='".$row['title']."' type='text' name='title'</input></p>
                    <p>IMDB Rating: <input value='".$row['imdbRating']."' type='number' min='0' max='10' step='0.1' name='imdb'</input></p>
                    <p>Seasons: <input readonly value='".$seasons."' type='number' name='seasons'</input></p>
                    <p>Genre:
                    <select name='genre'>";
                        $stmt2 = $mysqli -> prepare("SELECT DISTINCT * FROM GENRES_S23");
                        $stmt2 -> execute();
                        echo "<option></option>";
                        while ($row = $stmt2->fetch(PDO::FETCH_ASSOC)) {
                            echo '<option value="' . $row["genreID"] . '">' . $row['name'] . '</option>';
                        }
                    echo "</select></p>


                    <input type = 'hidden' name = 'tvID' value = '".$_GET['id']."' />
                    <input type='submit' name='submit' class='tiny round button' value='Update a TV Show' />
                </label>
            </div>";

			//Pre-populate form inputs with the tv shows's information that we are updating
			//You need to determine the number of seasons
			//We will output both the number of seasons and all the genres but will not allow them to be edited
			//You also need to create a drop-down for the distinct genres - use stmt2 and row2
			//DON'T FORGET your submit button - use class attribute (i.e., class='button tiny round') and name is "Edit TV Show"

			//UNCOMMENT ONCE YOU'VE COMPLETED THE FILE
			//echo "<h3>".$row["title"]." Information</h3>";





			
///////////////////////////////////////////////////////////////////////////////////////////

			echo "<br /><p>&laquo:<a href='readS23.php'>Back to Main Page</a>";
			echo "</label>";
			echo "</div>";
		}
		//Query failed. Return to readS23.php and output error
		else {
			$_SESSION["message"] = "TV Show could not be found!";
			redirect("readS23.php");
		}
	  }
    }
					
//Define footer with the phrase "Top 100 TV Shows"
//Disconnect from database
    new_footer("Top 100 TV Shows");
    Database::dbDisconnect($mysqli);


?>