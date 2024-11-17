<?php 
    //Add beginning code to
    //1. Require the needed 3 files
    //2. Connect to your database
    //3. Output a message, if there is one
    require_once("session.php");
    require_once("included_functions.php");
    require_once("database.php");

ini_set('display_errors', 1);
error_reporting(E_ALL);

new_header("Add a TV Show");
    $mysqli = Database::dbConnect();
    $mysqli->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if (($output = message()) !== null) {
        echo $output;
    }

	echo "<h3>Add a TV Show</h3>";
	echo "<div class='row'>";
	echo "<label for='left-label' class='left inline'>";

	if (isset($_POST["submit"])) {
		if( (isset($_POST["title"]) && $_POST["title"] !== "") && (isset($_POST["imdb"]) && $_POST["imdb"] !== "") &&(isset($_POST["start"]) && $_POST["start"] !== "") &&(isset($_POST["end"]) && $_POST["end"] !== "")) {
            $tvID = 0;
            //STEP 2.
            //Create and prepare query to insert information that has been posted
            $query = "INSERT INTO TV_S23(TITLE, IMDBRATING, START, END) VALUES(?, ?, ?, ?)";
            $stmt3 = $mysqli->prepare($query);
            $stmt3 ->bindParam(1, $_POST['title']);
            $stmt3 ->bindParam(2, $_POST['imdb']);
            $stmt3 ->bindParam(3, $_POST['start']);
            $stmt3 ->bindParam(4, $_POST['end']);

            // Execute query
            $stmt3->execute();

            //Verify $stmt3 executed - create another query to select from TV_S23 to get newly added tvID. Use $stmt4
            if ($stmt3) {
                $query = "SELECT * from TV_S23 WHERE tvID = (SELECT MAX(tvID) from TV_S23)";
                $stmt4 = $mysqli->prepare($query);
                $stmt4->execute();
                while ($row = $stmt4->fetch(PDO::FETCH_ASSOC)) {
                    $tvID = $row['tvID'];
                }
            } else {
                $_SESSION["message"] = "Unable to add tv show.";
                redirect("createS23.php");
            }

            //Using results from $stmt4, create, prepare and execute a query
            //to INSERT into TV_GENRES_S23.  Use $stmt5
            if ($stmt3) {
                $query = "INSERT INTO TV_GENRES_S23(tvID, genreID) VALUES(?, ?)";
                $stmt5 = $mysqli->prepare($query);
                $stmt5 ->bindParam(1, $tvID);
                $stmt5 ->bindParam(2, $_POST['genre']);
                $stmt5->execute();
            }
            //Verify $stmt5 executed - create a SESSION message that the title has been added and redirect to readS23.php
            //If the statement did not execute, create a SESSION message that there was an error inserting the title
            if ($stmt5) {
                $_SESSION["message"] = "{$_POST['title']} has been added";
                redirect("readS23.php");
            } else {
                $_SESSION["message"] = "Error! Could not add {$_POST['title']}.";
            }

            redirect("readS23.php");

		}
		else {
				$_SESSION["message"] = "Unable to add tv show. Fill in all information!";
				redirect("createS23.php");
		}
	}
	else {
        // STEP 1.  Create a form that will post to this page: createS23.php
        //
        //          Include <input> tags for each of the attributes in tv shows:
        //                  TV title, imdb rating, start year, end year, and list of genres.
        //
        //			Include drop down list (i.e., <select> tags) for distinct genre types, using the genre ID for the option's value
        //			You MUST query your database.
        //
        //			Finally, add a submit button called Add a TV Show - include the class 'tiny round button'
        echo "<form method='POST' action='createS23.php'>
            <div class='row'>
                <label for='left-label' class='left inline'>
                    <p>Title: <input type='text' name='title'</input></p>
                    <p>IMDB Rating: <input type='number' min='0' max='10' step='0.1' name='imdb'</input></p>
                    <p>Start Year: <input type='number' name='start'</input></p>
                    <p>End Year: <input type='number' name='end'</input></p>
                    <p>Genre:
                    <select name='genre'>";
                        $stmt2 = $mysqli -> prepare("SELECT DISTINCT * FROM GENRES_S23");
                        $stmt2 -> execute();
                        while ($row = $stmt2->fetch(PDO::FETCH_ASSOC)) {
                            echo '<option value="' . $row["genreID"] . '">' . $row['name'] . '</option>';
                        }
                    echo "</select></p>



                    <input type='submit' name='submit' class='tiny round button' value='Add a TV Show' />
                </label>
            </div>
        </form>";

					
	}
	echo "</label>";
	echo "</div>";
	echo "<br /><p>&laquo:<a href='readS23.php'>Back to Main Page</a>";

    // STEP 3.
    // Define footer with the phrase "Top 100 TV Shows"
    // Disconnect from database

    new_footer("Top 100 TV Shows");
    Database::dbDisconnect($mysqli);
?>