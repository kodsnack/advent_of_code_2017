<?php

$input  = file_get_contents('input');
$total  = 0;
$length = strlen($input);

for ($pos = 0; $pos < $length; $pos++) {
    $pos2 = ($pos + ($length / 2)) % $length;

    if ($input[$pos] === $input[$pos2]) {
        $total += $input[$pos];
    }
}

echo $total;
