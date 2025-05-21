<?php

    // Get database connection
    if (!isset($pdo)) { include '../common/db_connection.php'; }

    // Get session id
    $session_id = $_GET['session_id'];
    if (!isset($session_id)) { exit(); }

    // Get peer id
    $peer_id = $_GET['peer_id'];
    if (!isset($peer_id)) { exit(); }

    try {

        // Create session
        $sql = "INSERT INTO sessions (session_id) VALUES (?)";
        if ($pdo->prepare($sql)->execute([$session_id])) {

            // Join session
            include 'join_session.php';
            
        }

    } catch (Exception $e) {}

?>