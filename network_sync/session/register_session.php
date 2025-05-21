<?php

    // Get database connection
    if (!isset($pdo)) { include '../common/db_connection.php'; }

    // Get session id
    $session_id = $_GET['session_id'];
    if (!isset($session_id)) { exit(); }

    // Get peer id
    $peer_id = $_GET['peer_id'];
    if (!isset($peer_id)) { exit(); }

    // Check if session exists
    include 'session_exists.php';

    if (isset($session_exists)) {

        // Join session
        include 'join_session.php';

    } else {

        // Create session
        include 'create_session.php';

    }

?>