<?php

    // Get database connection
    if (!isset($pdo)) { include '../common/db_connection.php'; }

    $debug = $_GET['debug'];

    try {

        // Get sessions
        $sql = "SELECT * FROM sessions";
        include '../common/fetch_data.php';
        if (isset($debug)) {

            ob_end_clean();
            header_remove();

            ob_start();
            header("Content-type: application/json");
            echo json_encode($data);
            ob_end_flush();

            exit();
        }

    } catch (Exception $e) {}

?>