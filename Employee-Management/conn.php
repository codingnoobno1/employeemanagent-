<?php
$host = 'db'; // service name of MySQL container in docker-compose
$user = 'admin';
$password = 'admin';
$dbname = 'test';

$conn = mysqli_connect($host, $user, $password, $dbname);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
?>
