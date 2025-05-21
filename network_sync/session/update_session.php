<?php

    // Get database connection
    if (!isset($pdo)) { include '../common/db_connection.php'; }

    // Get session id
    $session_id = $_GET['session_id'];
    if (!isset($session_id)) { echo "No session id <br><br>"; return; }

    // Get peer id
    $peer_id = $_GET['peer_id'];
    if (!isset($peer_id)) { echo "No peer id <br><br>"; return; }

    try {

        // Create session
        $sql = "UPDATE sessions SET(session_id) VALUES (?)";
        if ($pdo->prepare($sql)->execute([$session_id])) {
            // echo "Created session '{$session_id}' <br><br>";
        }

        // Join session
        include 'join_session.php';

    } catch (Exception $e) { echo 'Caught exception: ',  $e->getMessage(), "<br><br>"; }

?>