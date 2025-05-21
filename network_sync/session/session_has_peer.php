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
    if (!isset($session_exists)) { exit(); }

    try {

        // Check if peer is already in session
        unset($session_has_peer);
        include 'session_peers.php';
        if (isset($data)) {
            foreach ($data as $peer_row) {
                if ($peer_row['peer_id'] == $peer_id) {
                    $session_has_peer = true;
                }
            }
        }

    } catch (Exception $e) {}

?>