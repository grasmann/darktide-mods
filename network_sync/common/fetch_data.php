<?php
    header('Content-Type: application/json; charset=utf-8');

    // Get database connection
    if (!isset($pdo)) { include 'db_connection.php'; }

    // Check sql
    if (!isset($sql)) {
        // echo "No sql statement <br><br>";
        exit();
    }

    try {

        // Get data
        unset($data);
        $data = $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
        // $data = json_encode($results);

    } catch (Exception $e) {
        // echo 'Caught exception: ',  $e->getMessage(), "\n";
    }

?>