<?php
	function redirect($new_location) {
		header("Location: " . $new_location);
		exit;
	}
	
	function new_header() {
		echo "<html lang='en'>";
		echo "<head>";
/////////////////////////////////////////////////////////////////////////////////////////////////
		//To be modified at the final exam
		echo "	<title>Wheely Cheap Car Rentals</title>";
/////////////////////////////////////////////////////////////////////////////////////////////////

		//		<!-- Link to Foundation -->";
		echo "	<link rel='stylesheet' href='cssFinal/normalize.css'>";
		echo "	<link rel='stylesheet' href='cssFinal/foundation.css'>";
	  
		echo "	<script src='js/vendor/modernizr.js'></script>";
		echo "</head>";
		echo "<body>";
		echo "  <div class='contain-to-grid sticky'>";
		echo "  <nav class='top-bar' data-topbar data-options='sticky_on: large'>";
		echo "  <ul class='title-area'>";
		echo "  <li class='name'>";
//////////////////////////////////////////////////////////////////////////////////////////////////
		//  Complete the <h1> tag below by adding yourHomeDirectory/final/ (e.g., mine would read /~kdavidso/final/index2023.php )
		
		echo "  <h1 align='left'><a href='/~jgcarpe2/final/index2023.php'>Wheely Cheap Car Rentals</a></h1>";
		
/////////////////////////////////////////////////////////////////////////////////////////////////
		echo "  </li>";
		echo "  </ul>";
		echo "  </nav>";
		echo "  </div>";	
		echo "<div class='row'>";
		echo "<label for='left-label' class='left inline'>";
	}
	
	function print_alert($name="") {
		echo "<br />";
		echo "<div class='row'>";
		echo "<div data-alert class='alert-box info round'>".$name;
		echo "</div>";
		echo "</div>";
		echo "<a href='notImplemented.php'>Add a customer</a>&nbsp;|&nbsp;";
		echo "<a href='notImplemented.php'>Add an employee</a>&nbsp;|&nbsp;";
		echo "<a href='logout.php'>logout</a>";
		
	}
	
	function new_footer(){
		date_default_timezone_set("America/Chicago");
		echo "<br /><br /><br />";
///////////////////////////////////////////////////////////////////////////////////////////////////
		// Complete the <h4> tag by adding Webmaster yourName after the date (e.g., mine would read Webmaster Kristi Davidson)
		
	    echo "<h4><div class='text-center'><small>Copyright ".date("M Y").", Webmaster Jonah Carpenter</small></div></h4>";
		
//////////////////////////////////////////////////////////////////////////////////////////////////
		echo "</label>";
		echo "</div>";
		echo "</body>";
		echo "</html>";
	}
	function password_encrypt($password) {
	  $hash_format = "$2y$10$";   // Use Blowfish with a "cost" of 10
	  $salt_length = 22; 					// Blowfish salts should be 22-characters or more
	  $salt = generate_salt($salt_length);
	  $format_and_salt = $hash_format . $salt;
	  $hash = crypt($password, $format_and_salt);
	  return $hash;
	}
	
	function generate_salt($length) {
	  // MD5 returns 32 characters
	  $unique_random_string = md5(uniqid(mt_rand(), true));
	  
	  // Valid characters for a salt are [a-zA-Z0-9./]
	  $base64_string = base64_encode($unique_random_string);
	  
	  // Replace '+' with '.' from the base64 encoding
	  $modified_base64_string = str_replace('+', '.', $base64_string);
	  
	  // Truncate string to the correct length
	  $salt = substr($modified_base64_string, 0, $length);
	  
		return $salt;
	}
	
	function password_check($password, $existing_hash) {
	  // existing hash contains format and salt at start
	  $hash = crypt($password, $existing_hash);
	  if ($hash === $existing_hash) {
	    return true;
	  } 
	  else {
	    return false;
	  }
	}
	
?>
