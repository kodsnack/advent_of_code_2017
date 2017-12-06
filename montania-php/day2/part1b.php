<?php

$input = file_get_contents('input');

$lines  = explode(PHP_EOL, $input);
$result = 0;

foreach ($lines as $line) {
    $columns = explode("\t", $line);

    usort($columns, function ($a, $b) {
        return intval($b) - intval($a);
    });

    for ($i = 0; $i < count($columns); $i++) {

        for ($j = ($i + 1); $j < count($columns); $j++) {

            if ($columns[$i] % $columns[$j] === 0) {
                $result += $columns[$i] / $columns[$j];

                break;
            }
        }
    }
}

printf('The sum of each row\'s result in my puzzle input is: %d', $result);