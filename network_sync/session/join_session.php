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
        include 'session_has_peer.php';
        if ($session_has_peer) { exit(); }

        // Join session
        $sql = "INSERT INTO session_peers (session_id, peer_id) VALUES (?, ?)";
        if ($pdo->prepare($sql)->execute([$session_id, $peer_id])) {

            ob_end_clean();
            header_remove();

            ob_start();
            header("Content-type: application/json");
            echo json_encode(array('session_id' => $session_id, 'peer_id' => $peer_id));
            ob_end_flush();

            exit();
        }

    } catch (Exception $e) {}

?>