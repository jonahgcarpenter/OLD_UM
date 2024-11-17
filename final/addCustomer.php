<?php
require_once("session.php");
require_once("final_functions.php");
require_once("database.php");

new_header();
$mysqli = Database::dbConnect();
$mysqli->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if (($output = message()) !== null) {
    echo $output;
}

if (!isset($_SESSION["username"])) {
	$_SESSION["message"] = "You must log in first";
	redirect("index2023.php");
}

// Hash the password and display it as a comment
$password = "secret";
$hashed_password = password_hash($password, PASSWORD_DEFAULT);
// Hashed Password in Database = $2y$10$lj24qHL1jLM1j5eCW6akmenKlj/anSzB5QCqtPuUz0V5lcQXyWLoC

if (isset($_POST["submit"])) {
    $username = trim($_POST["username"]);
    $password = trim($_POST["password"]);

    // Validate form data
    $errors = [];
    if (empty($username)) {
        $errors[] = "Username cannot be blank.";
    }
    if (empty($password)) {
        $errors[] = "Password cannot be blank.";
    }

    if (empty($errors)) {
        // Check if the username is already taken
        $query = "SELECT * FROM login2023 WHERE username = :username";
        $stmt = $mysqli->prepare($query);
        $stmt->bindValue(':username', $username);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        if ($result) {
            $errors[] = "Username already taken.";
        } else {
            // Insert the new user into the database
            $query = "INSERT INTO login2023 (username, password, permission) VALUES (:username, :password, :permission)";
            $stmt = $mysqli->prepare($query);
            $stmt->bindValue(':username', $username);
            $stmt->bindValue(':password', password_hash($password, PASSWORD_DEFAULT));
            $stmt->bindValue(':permission', 'n');
            $stmt->execute();
            $stmt->closeCursor();

            $_SESSION["message"] = "New customer added: $username";
            redirect("manager.php");
        }
    }
}

?>

<div id="page">
    <h2>Add Customer</h2>
    <br />
    <?php
    if (!empty($errors)) {
        echo "<div class=\"errors\">";
        foreach ($errors as $error) {
            echo "<p>$error</p>";
        }
        echo "</div>";
    }
    ?>
    <form action="addCustomer.php" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" value="<?php echo htmlspecialchars($username); ?>" /><br />
        <label for="password">Password:</label>
        <input type="password" name="password" value="" /><br />
        <input type="submit" name="submit" value="Add Customer" />
    </form>
    <br />
    <p>&laquo;<a href='manager.php'>Back to Manage Page</a></p>
</div>

<?php
new_footer();
Database::dbDisconnect();
?>
