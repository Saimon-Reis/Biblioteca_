<?php
$servername = "localhost";
$username = "root";
$password = "0987654321fodase";
$database = "biblioteca";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $database);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
?>