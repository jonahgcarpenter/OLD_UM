<?php 
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

	echo "<h3 style='text-align:center'>Add a TV Show</h3>";
	echo "<div class='row' style='margin-left:40%'>";
	echo "<label for='left-label' class='left inline'>";

	if (isset($_POST["submit"])) {
		if( (isset($_POST["title"]) && $_POST["title"] !== "") && (isset($_POST["imdb"]) && $_POST["imdb"] !== "") &&(isset($_POST["start"]) && $_POST["start"] !== "") &&(isset($_POST["end"]) && $_POST["end"] !== "")) {
//////////////////////////////////////////////////////////////////////////////////////////////////
					//STEP 2.
					//Create and prepare query to insert information that has been posted
					$query3 = "INSERT INTO TV_S23 (title, imdbRating, start, end) VALUES(?, ?, ?, ?)";
					$stmt3 = $mysqli->prepare($query3);
					// Execute query
					$stmt3->execute([$_POST["title"], $_POST["imdb"], $_POST["start"], $_POST["end"]]);

					//Verify $stmt3 executed - create another query to select from TV_S23 to get newly added tvID. Use $stmt4
					if ($stmt3) {
						$query4 = "SELECT tvID FROM TV_S23 WHERE title=?";
						$stmt4 = $mysqli->prepare($query4);
						$stmt4->execute([$_POST["title"]]);
						while ($row = $stmt4->fetch(PDO::FETCH_ASSOC)) {
							$tvID = $row['tvID'];
						}
						//Using results from $stmt4, create, prepare and execute a query
						//to INSERT into TV_GENRES_S23.  Use $stmt5
						$query5 = "INSERT INTO TV_GENRES_S23 VALUES(?, ?)";
						$stmt5 = $mysqli->prepare($query5);
						$stmt5->execute([$tvID, $_POST["Genre"]]);
						//Verify $stmt5 executed - create a SESSION message that the title has been added and redirect to readS23.php
						//If the statement did not execute, create a SESSION message that there was an error inserting the title
						if ($stmt5) {
							$_SESSION["message"] = $_POST["title"]." has been added";
						} else {
							$_SESSION["message"] = "Error! Could not add ".$_POST["title"];
						}
					} 
					redirect("readS23.php");
		}
		else {
				$_SESSION["message"] = "Unable to add tv show. Fill in all information!";
				redirect("createS23.php");
		}
	}
	else {
//////////////////////////////////////////////////////////////////////////////////////////////////
					// STEP 1.  Create a form that will post to this page: createS23.php
					//          
					//          Include <input> tags for each of the attributes in tv shows:
					//                  TV title, imdb rating, start year, end year, and list of genres.
					//
					//			Include drop down list (i.e., <select> tags) for distinct genre types, using the genre ID for the option's value
					//			You MUST query your database. 
					//
					//			Finally, add a submit button called Add a TV Show - include the class 'tiny round button'



			echo "<form method='POST' action='createS23.php'>";
			echo "Title: <p><input type='text' name='title'></p>";
			echo "IMDB Rating: <p><input type='number' min='0' max='10' step='.1' name='imdb'/></p>";
			echo "Start Year: <p><input type='number' name='start'></p>";
			echo "End Year: <p><input type='number' name='end'></p>";
			$query2 = ("SELECT * FROM GENRES_S23");
			$stmt2 = $mysqli->prepare($query2);
			$stmt2 -> execute();
			if($stmt2) {
				echo "Genre Type: <p><select name='Genre'>";
				while($row = $stmt2->fetch(PDO::FETCH_ASSOC)) {
					 $genreID = $row['genreID'];
        			$genreType = $row['name'];
        			echo "<option value='$genreID'>$genreType</option>";
				}
				echo "</select></p>";
			}

			echo "<input type='submit' name='submit' value='Add' class='tiny round button'>";

			echo "</form>";
					
					
					
//////////////////////////////////////////////////////////////////////////////////////////////////
				
	}
	echo "</label>";
	echo "</div>";
	echo "<br /><p style='margin-left:40%'>&laquo:<a href='readS23.php'>Back to Main Page</a>";

///////////////////////////////////////////////////////////////////
// STEP 3.
// Define footer with the phrase "Top 100 TV Shows"
// Disconnect from database
	new_footer("Top 100 TV Shows");	
	Database::dbDisconnect($mysqli);
?>