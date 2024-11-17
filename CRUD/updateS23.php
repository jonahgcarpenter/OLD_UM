<?php 
//  NOTE: NOT all comments will reference the S23.php

//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database
//3. Output a message, if there is one
	require_once("session.php"); 
	require_once("included_functions.php");
	require_once("database.php");
	verify_login();

	new_header("Top 100 TV Shows 2023"); 
	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	if (($output = message()) !== null) {
		echo $output;
	}

	echo "<h3 style='text-align:center'>Update A TV Show</h3>";
	echo "<div class='row' style='margin-left:40%'>";
	echo "<label for='left-label' class='left inline'>";

	if (isset($_POST["submit"])) {
///////////////////////////////////////////////////////////////////////////////////////////				
		//Step 2.
		//Create an UPDATE query using anonymous parameters and the criterion WHERE tvID = ?
		$queryUp = "UPDATE TV_S23 SET title = ?, imdbRating = ?, start = ?, end = ? WHERE tvID = ?";
					
		//Prepare and execute query (use $_POST values from submitted form)
		$stmtUp = $mysqli -> prepare($queryUp);
		$stmtUp -> execute([$_POST['title'], $_POST['imdb'], $_POST['start'], $_POST['end'], $_POST['tvID']]);
		
		if($stmtUp) {
			if(isset($_POST['Genre']) && $_POST['Genre'] != "") {
				$Query3 = "INSERT INTO TV_GENRES_S23 (genreID, tvID) VALUES (?, ?)";
	
				$VerifyQuery = "SELECT genreID from TV_GENRES_S23 WHERE genreID = ? and tvID = ?";
				$stmt3 = $mysqli -> prepare($VerifyQuery);
				$stmt3 -> execute([$_POST['Genre'], $_POST['tvID']]);
				if($stmt3 -> rowCount() != 0) {
					$_SESSION["message"] = "The TV Show already has this genre.";
					redirect("readS23.php");
				}
				else {
					$stmt4 = $mysqli -> prepare($Query3);
					$stmt4 -> execute([$_POST['Genre'], $_POST['tvID']]);
				}
			}
			if($stmt3) {
				$_SESSION["message"] = "The TV Show was edited.";
			} else {
				$_SESSION["message"] = "There was an error updating the genre.";
			}

		
		//Now execute $stmt2 and verify $stmt2 executed - create a SESSION message that this video game was updated
		//If the statement did not execute, create a SESSION message that there was an error updating the game
		}

		//Now execute $stmt2 and verify $stmt2 executed - create a SESSION message that this video game was updated
		//If the statement did not execute, create a SESSION message that there was an error updating the game
		//Redirect back to read.php

		redirect("readS23.php");

///////////////////////////////////////////////////////////////////////////////////////////

		//Output query results and return to read.php			
		if($stmtUp) {
			$_SESSION["message"] = $_POST["Name"]." has been changed";
		}
		else {
			$_SESSION["message"] = "Error! Could not change ".$_POST["Name"];
		}
		redirect("readS23.php");
	}
	else {
///////////////////////////////////////////////////////////////////////////////////////////
	  //Step 1.
	  if (isset($_GET["id"]) && $_GET["id"] !== "") {
	  //Prepare and execute a query to SELECT FROM TV_S23, TV_GENRES_S23 and GENRES_S23
      //using GET id in criterion - WHERE tvID = ?
	  	$query = ("Select TV_S23.*, group_concat(name) as Genres FROM TV_S23 NATURAL JOIN TV_GENRES_S23 LEFT OUTER JOIN GENRES_S23 on GENRES_S23.genreID = TV_GENRES_S23.genreID WHERE TV_S23.tvID = ?");
		$stmt = $mysqli->prepare($query);
		$stmt->execute(array($_GET["id"]));
	  
		//Verify statement successfully executed - I assume that results are returned to variable $stmt
		if ($stmt)  {


			//Pre-populate form inputs with the tv shows's information that we are updating
			//You need to determine the number of seasons
			//We will output both the number of seasons and all the genres but will not allow them to be edited
			//You also need to create a drop-down for the distinct genres - use stmt2 and row2
			//DON'T FORGET your submit button - use class attribute (i.e., class='button tiny round') and name is "Edit TV Show"

			while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
				$tvID = $row['tvID'];	
				$showTitle = $row['title'];
				$IMDB = $row['imdbRating'];
				$start = $row['start'];
				$end = $row['end'];
				$seasons = ($end - $start) + 1;
				$genres = $row['Genres'];
			}

			//UNCOMMENT ONCE YOU'VE COMPLETED THE FILE
			echo "<h3>".$showTitle." Information</h3>";
			echo "<form method='POST' action='updateS23.php'>";
			echo "Title: <p><input type='text' name='title' value='$showTitle'/></p>";
			echo "IMDB Rating: <p><input type='number' min='0' max='10' step='.1' name='imdb' value='$IMDB'/></p>";
			echo "Start Year: <p><input type='number' name='start' value='$start'/></p>";
			echo "End Year: <p><input type='number' name='end' value='$end'/></p>";
			$query2 = ("SELECT * FROM GENRES_S23");
			$stmt2 = $mysqli->prepare($query2);
			$stmt2 -> execute();
			if($stmt2) {
				echo "Genre Type: <p><select name='Genre'>";
				echo "<option value='none'>No Genre</option>";
				while($row = $stmt2->fetch(PDO::FETCH_ASSOC)) {
					 $genreID = $row['genreID'];
        			$genreType = $row['name'];
        			echo "<option value='$genreID'>$genreType</option>";
				}
				echo "</select></p>";
			}
			echo "<input type='hidden' name='tvID' value='$tvID'/>";
			echo "<input type='submit' name='submit' value='Edit TV Show' class='button tiny round'>";
			echo "</form>";




			
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
    new_footer("Top 100 TV Shows\n");	
	Database::dbDisconnect($mysqli);
?>