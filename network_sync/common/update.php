<?php
    header('Content-Type: application/json; charset=utf-8');

    function calculateTransactionDuration($startDate, $endDate) {
        $startDateFormat = new DateTime($startDate);
        $EndDateFormat = new DateTime($endDate);
        // the difference through one million to get micro seconds
        $uDiff = ($startDateFormat->format('u') - $EndDateFormat->format('u')) / (1000 * 1000);
        $diff = $startDateFormat->diff($EndDateFormat);
        $s = (int) $diff->format('%s') - $uDiff;
        $i = (int) ($diff->format('%i')) * 60; // convert minutes into seconds
        $h = (int) ($diff->format('%h')) * 60 * 60; // convert hours into seconds
        return sprintf('%.6f', abs($h + $i + $s)); // return total duration in seconds
    }

    try {

        $current_timestamp = date("Y-m-d H:i:s"); 

        // // Update sessions
        // include 'get_sessions.php';
        // foreach ($data as $session) {
            
        // }

    } catch (Exception $e) {
        // echo 'Caught exception: ',  $e->getMessage(), "<br><br>";
    }

?>