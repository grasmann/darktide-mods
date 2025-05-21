<?php

    // Get database connection
    if (!isset($pdo)) { include '../common/db_connection.php'; }

    // Get session id
    $session_id = $_GET['session_id'];
    if (!isset($session_id)) { exit(); }

    $debug = $_GET['debug'];

    try {

        // Get peers
        $sql = "SELECT * FROM session_peers WHERE session_id = '{$session_id}'";
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