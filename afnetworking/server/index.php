<?php

$content = var_export($_SERVER, true) .
    var_export($_GET, true) .
    var_export($_POST, true) .
    var_export($_FILES, true) .
    "\n\n";

file_put_contents(__DIR__ . '/request.log', $content, FILE_APPEND);


header('Content-Type: application/json');
echo json_encode([
    'get' => $_GET,
    'post' => $_POST,
    'files' => $_FILES,
]);