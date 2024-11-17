<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Arrays</title>
	</head>
	<body>
	<?php
		$numbers = array();
		$numbers2 = array(4, 8, 15, 16, 23, 42);

		$numbers3 = array(5, "bear", $numbers2, "ram", 3.14);
		echo "Numbers2[1]: ".$numbers2[1]."<br />";
		
		echo "<pre>";
		print_r($numbers3);   //Print readable function for troubleshooting
		
	?>
	</body>
</html>