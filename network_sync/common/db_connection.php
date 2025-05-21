<?php

    $servername = "localhost";
    $username = "floweb2_network_sync";
    $password = "MPkl01lJwlDCO8wtkfre";
    $database = "floweb2_network_sync";

    try {

        $pdo = new PDO("mysql:host={$servername};dbname={$database}", $username, $password);

    } catch (Exception $e) {
        // echo 'Caught exception: ',  $e->getMessage(), "\n";
    }

?> 