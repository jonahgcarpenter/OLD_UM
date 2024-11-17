
<?php
	function redirect($new_location) {
		header("Location: " . $new_location);
		exit;
	}
	
	function new_header($name="Jonah Carpenter", $urlLink="") {
		echo "<head>";
		echo "	<title>$name</title>";
		//		<!-- Link to Foundation -->";
		echo "	<link rel='stylesheet' href='/~jgcarpe2/css/normalize.css'>";
		echo "	<link rel='stylesheet' href='/~jgcarpe2/css/foundation.css'>";
	  
		echo "	<script src='js/vendor/modernizr.js'></script>";
		echo "</head>";
		echo "<body>";
		echo "<div class='contain-to-grid sticky'>";
		echo "<nav class='top-bar' data-topbar data-options='sticky_on: large'>";
		echo "<ul class='title-area'>";
		echo "<li class='name'>";
		echo "  <h1 align='left'><a href='/~jgcarpe2/".$urlLink."'>$name</a></h1>";
		echo "</li>";
		echo "</ul>";
		echo "</nav>";
		echo "</div>";	
	}

	function new_footer($name="Jonah Carpenter"){
		date_default_timezone_set("America/Chicago");
		echo "<br /><br /><br />";
	    echo "<h4><div class='text-center'><small>Copyright {$name}".date("M Y").", ".$name."</small></div></h4>";
		echo "</body>";
		echo "</html>";
	}	
	
	function print_alert($name="") {
		echo "<br />";
		echo "<div class='row'>";
		echo "<div data-alert class='alert-box info round'>".$name;
		
		echo "</div>";
		echo "</div>";
		
	}

	$states = ['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve','thirteen'];

	$one = ['Num'=>1,'Name'=>'Delaware','Abbr'=>'DE','Capital'=>'Dover','Est'=>1787,'Flower'=>'Peach blossom'];
	$two = ['Num'=>2,'Name'=>'Pennsylvania','Abbr'=>'PA','Capital'=>'Harrisburg','Est'=>1787,'Flower'=>'Mountain laurel'];
	$three = ['Num'=>3,'Name'=>'New Jersey','Abbr'=>'NJ','Capital'=>'Trenton','Est'=>1787,'Flower'=>'Violet'];
	$four = ['Num'=>4,'Name'=>'Georgia','Abbr'=>'GA','Capital'=>'Atlanta','Est'=>1788,'Flower'=>'Cherokee rose'];
	$five = ['Num'=>5,'Name'=>'Connecticut','Abbr'=>'CT','Capital'=>'Hartford','Est'=>1788,'Flower'=>'Mountain laurel'];
	$six = ['Num'=>6,'Name'=>'Massachusetts','Abbr'=>'MA','Capital'=>'Boston','Est'=>1788,'Flower'=>'Mayflower'];
	$seven = ['Num'=>7,'Name'=>'Maryland','Abbr'=>'MD','Capital'=>'Annapolis','Est'=>1788,'Flower'=>'Black-eyed susan'];
	$eight = ['Num'=>8,'Name'=>'South Carolina','Abbr'=>'SC','Capital'=>'Columbia','Est'=>1788,'Flower'=>'Dogwood'];
	$nine = ['Num'=>9,'Name'=>'New Hampshire','Abbr'=>'NH','Capital'=>'Concord','Est'=>1788,'Flower'=>'Purple lilac'];
	$ten = ['Num'=>10,'Name'=>'Virginia','Abbr'=>'VA','Capital'=>'Richmond','Est'=>1788,'Flower'=>'Dogwood'];
	$eleven = ['Num'=>11,'Name'=>'New York','Abbr'=>'NY','Capital'=>'Albany','Est'=>1788,'Flower'=>'Peach blossom'];
	$twelve = ['Num'=>12,'Name'=>'North Carolina','Abbr'=>'NC','Capital'=>'Raleigh','Est'=>1789,'Flower'=>'Dogwood'];
	$thirteen = ['Num'=>13,'Name'=>'Rhode Island','Abbr'=>'RI','Capital'=>'Providence','Est'=>1790,'Flower'=>'Violet'];

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
