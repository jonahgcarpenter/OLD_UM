<?php 
//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database

	require_once("session.php"); 
	require_once("included_functions.php");
	require_once("database.php");

	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	new_header("Top 100 IMDB TV Shows"); 

//3. Output a message, if there is one

	if (($output = message()) !== null) {
		echo $output;
	}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     Step 7.  Check whether username and password have been submitted from the index form. Verify the values are not empty
//				Some of this code may be borrowed from addLogin.php
	if(isset($_POST["submit"])) {
		if((isset($_POST["username"]) && $_POST["username"] !== "") && (isset($_POST["password"]) && $_POST["password"] !== "")){

			$name = $_POST["username"];
			$pass = $_POST["password"];

			$queryExist = "SELECT * FROM admins WHERE username = ?";
			$stmtExist = $mysqli->prepare($queryExist);
			$stmtExist->execute([$name]);

			if($stmtExist) {
				if(($rowNum = $stmtExist->rowCount()) >= 1){
					while($row = $stmtExist->fetch(PDO::FETCH_ASSOC)) {
						$passOrg = $row['hashed_password'];
						$passCheck = password_check($pass, $passOrg);
						if($passCheck){
							$_SESSION['username'] = $_POST['username'];
							$_SESSION['admin'] = $row['id'];
							$_SESSION['message'] = "Successfully logged in.";
							redirect("readS23.php");
						} else {
							$_SESSION['message'] = "Password is incorrect.";
							redirect("indexS23Carpenter.php");
						}
					}
				} else {
					//username no exist
					$_SESSION['message'] = "This user does not exist.";
					redirect("indexS23Carpenter.php");
				}
			}
		}
	}

		echo "<div class='row'>";
		echo "<label for='left-label' class='left inline'>";
	
		echo "<h3>Top 100 IMDB TV Shows</h3>";

		echo "<form action='indexS23Carpenter.php' method='post'>";
		echo "<p>Username: <input type='text' name='username' value=''/><p>";
		echo "<p>Password: <input type='password' name='password' value=''/><p>";
		echo "<input type='submit' name='submit' value='Login' class='tiny round button'/>";
			
							
	echo "</div>";
	echo "</label>";


//Define footer with the phrase "Top 100 TV Shows"
//Disconnect from database database
	new_footer("Top 100 TV Shows ");	
	Database::dbDisconnect($mysqli);
 ?>
