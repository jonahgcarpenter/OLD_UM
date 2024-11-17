<?php 
//Add beginning code to 
//1. Require the needed 3 files
//2. Connect to your database
//3. Check if there is an output message.  NOTE that this is given and is BELOW Step 9.
	require_once("session.php"); 
	require_once("included_functions.php");
	require_once("database.php");
	verify_login();

	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

///////////////////////////////////////////////////////////////////////////////////
//  Step 9  -  invoke verify_login
//				Will redirect to index_<yourLastName>.php if there is not a SESSION admin set
//				**************** NOTE:  REPLACE <yourLastName> with your last name
//				****************        Also include the semester in the filename as noted in the instructions


/////////////////////////////////////////////////////////////////////////////////// 

new_header("IMDB TV Admin"); 

//Output a message, if there is one
	if (($output = message()) !== null) {
		echo $output;
	}

	  
	  
///////////////////////////////////////////////////////////////////////////////////////////////
//  Step 4.  Check to see if form submitted username and password text boxes are filled in.
//           If it has, verify username and password have been set and are not empty fields
	if(isset($_POST["submit"])) {
		if((isset($_POST["username"]) && $_POST["username"] !== "") && (isset($_POST["password"]) && $_POST["password"] !== "")){

		    //Grab posted values for username and password, encrypting the password
			//so that it is set up to compare with the encrypted password in the database
			//Use password_encrypt
			$name = $_POST["username"];
			$pass = password_encrypt($_POST["password"]);
			
			//Query database for this "new" username

			$queryExist = "SELECT * FROM admins WHERE username = ?";
			$stmtExist = $mysqli->prepare($queryExist);
			$stmtExist->execute([$name]);
			
			//If the username DOES exist in table, create a session message - "The username already exists"
			//Reidrect back to addLogin.php

			$rowNum = $stmtExist->rowCount();

			if($rowNum >= 1) {
				$_SESSION["message"] = ("This username already exists.");
				redirect("addLoginS23.php");
			} else {
		
			//If the username DOES NOT exist in table, insert into table
			//Verify stmt successfully executes
			// If successful, create a session message - "User successfully added"
			// If NOT successful, create a session message - "Could not add user"
			//In both cases, redirect back to addLogin.php

				$queryIns = "INSERT INTO admins (username, hashed_password) VALUES (?, ?)";
				$stmtIns = $mysqli->prepare($queryIns);
				$stmtIns->execute([$name, $pass]);

				if($stmtIns) {
					$_SESSION["message"] = ("User successfully added.");
					redirect("addLoginS23.php");
				} else { 
					$_SESSION["message"] = ("Could not add user.");
					redirect("addLoginS23.php");
				}
			}
		}
	}

////////////////////////////////////////////////////////////////////////////////////////////////
?>
		
		<div class='row'>
		<label for='left-label' class='left inline'>

		<h3>Add IMDB TV Administrator</h3>

<!--//////////////////////////////////////////////////////////////////////////////////////////////// -->
<!--    Step 2. Create a form with textboxes for adding both a username and password -->
	
			<form action="addLoginS23.php" method="post">
				<p>Username: <input type="text" name="username" value=""/><p>
				<p>Password: <input type="password" name="password" value=""/><p>
				<input type="submit" name="submit" value="Add Administrator" class="tiny round button"/>
			</form>	
	
<!--///////////////////////////////////////////////////////////////////////////////////////////////// -->


			<p><br /><br /><hr />
			<h3>Current IMDB TV Adminstrators</h3>

<!--//////////////////////////////////////////////////////////////////////////////////////////////// -->
<!--    Step 3. Display current Administrators.  Also provide a red X in front of each row that allows you to delete -->
<!--            the username from your database This requires including the id# in the query string -->

			<?php

				$query = ("Select * FROM admins");
		
				//  Prepare and execute query

				$stmt = $mysqli->prepare($query);
				$stmt -> execute();
							
				if ($stmt) {
					echo "<div class='row'>";
					echo "<center>";
					echo "<table>";
					echo "  <thead>";
					echo "    <tr><th>Delete</th><th>Username</th></tr>";
					echo "  </thead>";
					echo "  <tbody>";
					while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
						//////////// ADD CODE HERE
						// Retrieve information from query results
						$id = $row['id'];	
						$username = $row['username'];
						
						echo "<tr>";
						echo "<td><a href='deleteLoginS23.php?id=".urlencode($row['id'])."' onclick='return confirm(\"Are you sure?\");' style='color:red'>X</a></td>";
						echo "<td>$username</td>";
						echo "</tr>";
					}
					echo "  </tbody>";
					echo "</table>";
				}
			?>

<!--//////////////////////////////////////////////////////////////////////////////////////////////// -->
			
  	  <?php echo "<br /><p>&laquo:<a href='readS23.php'>Back to Main Page</a>"; ?>
			
	</div>
	</label>

<?php 
//Define footer with the phrase "Top 100 TV Shows"
//Disconnect from database database
	new_footer("Top 100 TV Shows ");	
	Database::dbDisconnect($mysqli);
?>