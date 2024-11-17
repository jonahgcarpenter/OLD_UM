<?php 
	// Add require_once function calls as you did in take-home quiz
	// Also set up connecting to your database
	require_once("included_functions.php");
	require_once("database.php");
	
	$mysqli = Database::dbConnect();
	$mysqli -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

?>

<!DOCTYPE html>
<html lang="en">
	<?php new_header("Pick Your State"); ?>

    <form method="POST" action="listStateDB2023.php">
	    <div class="row">
		  <label for="left-label" class="left inline">

			<h2>Pick Your State</h2>
			Choose the Order of Statehood:<select name="ID">
			<option></option>
			<?php
			//*******************  Add Code here to choose states *******************
				$stmt = $mysqli -> prepare("SELECT * FROM statesS23 ORDER BY Num ASC");
				$stmt -> execute();
			
				while($row=$stmt->fetch(PDO::FETCH_ASSOC)){
					echo"<option value=".$row['Num']."'>".$row["Num"]."</option>";
				}
			
			?>			
			</select><p />		
			<hr>&nbsp;&nbsp;&nbsp;<b>OR</b> &nbsp;&nbsp;&nbsp; fill in zero or more values below<hr> <p />
				<p>State: <input type=text name="name"></p>
        <p>State Abbreviation: <input type=text name="abbr"></p>
        <p>Capital: <input type=text name="capital"></p>
				Start Year:<select name="StartYear">
				<option></option>
				<?php
				    $stmt = $mysqli->prepare("SELECT DISTINCT YEAR(Est) AS start_year FROM statesS23 ORDER BY start_year ASC");
    				$stmt->execute();
    			
						while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    			    echo '<option value="' . htmlspecialchars($row['start_year'], ENT_QUOTES) . '">' . $row['start_year'] . '</option>';
    				}

				?>
				</select><p />	
				End Year:<select name="EndYear">
				<option></option>
				<?php
					$stmt = $mysqli -> prepare("SELECT DISTINCT YEAR(Est) as year FROM statesS23 ORDER BY year DESC");
					$stmt -> execute();
									
					while($row=$stmt->fetch(PDO::FETCH_ASSOC)){
						echo '<option value="'.htmlspecialchars($row['year'], ENT_QUOTES).'">'.$row["year"].'</option>';
					}
					
				?>
				</select><p />		
				Flower:<select name="flower">
				<option></option>
				<?php
					$stmt = $mysqli -> prepare("SELECT DISTINCT Flower FROM statesS23 ORDER BY Num ASC");
					$stmt -> execute();
								
					while($row=$stmt->fetch(PDO::FETCH_ASSOC)){
						echo '<option value="'.htmlspecialchars($row['Flower'], ENT_QUOTES).'">'.$row["Flower"].'</option>';
					}

				?>
		  <input type="submit" name="submit" class="button tiny round" value="Find a State" />
		  </label>
      </div>
    </form>
<?php 
    new_footer(); 
    Database::dbDisconnect();
?>
