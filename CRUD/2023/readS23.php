<?php 
	require_once("session.php"); 
	require_once("included_functions.php");
	require_once("database.php");

	new_header("Top 100 TV Shows 2023"); 
	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	if (($output = message()) !== null) {
		echo $output;
	}

	
	//****************  Add Query
	//Select from TV_S23, TV_GENRES_S23 and GENRES_S23 tables - you need all the TV_S23 attributes and the corresponding GENRES listed on one line with the Tv show's title
    $query = "SELECT *, GROUP_CONCAT(GENRES_S23.name SEPARATOR ', ') AS genres 
                FROM TV_S23 NATURAL JOIN TV_GENRES_S23 LEFT OUTER JOIN GENRES_S23 ON TV_GENRES_S23.genreID = GENRES_S23.genreID 
                GROUP BY TV_S23.tvID ORDER BY TV_S23.tvID";

	
	//  Prepare and execute query
    $stmt = $mysqli->prepare($query);
    $stmt -> execute();

				
				
///********************    Uncomment Once Code Completed  **************************
	if ($stmt) {
		echo "<div class='row'>";
		echo "<center>";
		echo "<h2>Top 100 TV Shows 2023</h2>";
		echo "<table>";
		echo "  <thead>";
		echo "    <tr><th></th><th>Show</th><th>IMDB Rating</th><th>Seasons</th><th>Genres</th><th></th></tr>";
		echo "  </thead>";
		echo "  <tbody>";
		while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			//////////// ADD CODE HERE
			// Retrieve information from query results
            $show = $row['title'];
            $rating = $row['imdbRating'];
            $seasons = ($row['end'] - $row['start']) + 1;
            $genres = $row['genres'];


			echo "<tr>";
			//////////////// ADD CODE HERE
			//Output a red X for the first column, creating a Delete link.  Use URL.php for the href
            echo "<td><a style='color: red' href='deleteS23.php?id=".urlencode($row['tvID'])."' onclick='return confirm(\"Are you sure you want to delete this tv show?\");'>X</a></td>";
			//Output Show's title, imdb rating, number of seasons and genres
            echo "<td>$show</td>";
            echo "<td>$rating</td>";
            echo "<td>$seasons</td>";
            echo "<td>$genres</td>";
            echo "</tr>";
			//Output "Edit", without the quotes, for the last column, creating an Edit link. User URL.php for the href
            echo "<td><a href='updateS23.php?id=".urlencode($row['tvID'])."'>Edit</a></td>";





			
			echo "</tr>";
		}
		echo "  </tbody>";
		echo "</table>";
		/////////////////  ADD CODE HERE
		// Create a link to create.php and call the link "Add a tv show" but without the quotes
        echo "<a href='createS23.php'>Add a tv show</a>";

		echo "</center>";
		echo "</div>";
	}

/************       Uncomment Once Code Completed For This Section  ********************/
	new_footer("Top 100 TV Shows");
	Database::dbDisconnect($mysqli);
 ?>