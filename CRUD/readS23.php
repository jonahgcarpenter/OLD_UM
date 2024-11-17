<?php 
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

	
	//****************  Add Query
	//Select from TV_S23, TV_GENRES_S23 and GENRES_S23 tables - you need all the TV_S23 attributes and the corresponding GENRES listed on one line with the Tv show's title

	$query = ("Select TV_S23.*, group_concat(name) as Genres from TV_S23 Natural Join TV_GENRES_S23 Left Outer Join GENRES_S23 on GENRES_S23.genreID = TV_GENRES_S23.genreID group by title order by tvID");
	
	//  Prepare and execute query

	$stmt = $mysqli->prepare($query);
	$stmt -> execute();
				
	if ($stmt) {
		echo "<div class='row'>";
		echo "<center>";
		echo "<h2>Top 100 TV Shows 2023</h2>";
		echo "<table>";
		echo "  <thead>";
		echo "    <tr><th></th><th>Show</th><th>IMDB Rating</th><th>Seasons</th><th>Genres</th><th>Edit</th></tr>";
		echo "  </thead>";
		echo "  <tbody>";
		while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			//////////// ADD CODE HERE
			// Retrieve information from query results
			$tvID = $row['tvID'];	
			$showTitle = $row['title'];
			$IMDB = $row['imdbRating'];
			$start = $row['start'];
			$end = $row['end'];
			$seasons = ($end - $start) + 1;
			$genres = $row['Genres'];
			
			echo "<tr>";
			//////////////// ADD CODE HERE
			//Output a red X for the first column, creating a Delete link.  Use URL.php for the href
			//Output Show's title, imdb rating, number of seasons and genres
			//Output "Edit", without the quotes, for the last column, creating an Edit link. User URL.php for the href

			echo "<td><a href='deleteS23.php?id=".urlencode($row['tvID'])."' onclick='return confirm(\"Are you sure?\");' style='color:red'>X</a></td>";
			echo "<td>$showTitle</td>";
			echo "<td>$IMDB</td>";
			echo "<td>$seasons</td>";
			echo "<td>$genres</td>";
			echo "<td><a href='updateS23.php?id=".urlencode($row['tvID'])."'>Edit</a></td>";
			
			echo "</tr>";
		}
		echo "  </tbody>";
		echo "</table>";
		/////////////////  ADD CODE HERE
		// Create a link to create.php and call the link "Add a tv show" but without the quotes

		echo "<a href='createS23.php'>Add a TV Show |</a>&nbsp;<a href='addLoginS23.php'>Add an admin |</a>&nbsp;<a href='logoutS23.php'>Logout</a>";

		echo "</center>";
		echo "</div>";
	}
	
/************       Uncomment Once Code Completed For This Section  ********************/
	new_footer("Top 100 TV Shows");	
	Database::dbDisconnect($mysqli);
 ?>