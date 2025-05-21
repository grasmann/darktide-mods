<?php

    // Get database connection
    if (!isset($pdo)) { include '../common/db_connection.php'; }

    // Get session id
    $session_id = $_GET['session_id'];
    if (!isset($session_id)) { exit(); }

    try {

        // Check if session exists
        unset($session_exists);
        $sql = "SELECT * FROM sessions WHERE session_id = '{$session_id}'";
        $results = $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
        if (count($results) > 0) {
            $session_exists = true;
        }

    } catch (Exception $e) {}

?>