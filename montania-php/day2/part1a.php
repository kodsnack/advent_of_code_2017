<?php

$input = file_get_contents('input');

$lines  = explode(PHP_EOL, $input);
$result = 0;

foreach ($lines as $line) {
    $columns = explode("\t", $line);

    usort($columns, function ($a, $b) {
        return intval($a) - intval($b);
    });

    $first = $columns[0];
    $last  = $columns[count($columns) - 1];

    $result += $last - $first;
}

printf('The checksum for the spreadsheet is: %d', $result);