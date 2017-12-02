<?php

declare(strict_types=1);

namespace Puzzles;

class Day1
{
    public static function solveCaptcha(string $puzzelInput, int $match) : int
    {
        $captcha = 0;
        $puzzelInputLenght = strlen($puzzelInput);

        for ($i = 0; $i <= $puzzelInputLenght; $i++) {
            if ($puzzelInput[$i] === $puzzelInput[($i + $match) % $puzzelInputLenght]) {
                $captcha += $puzzelInput[$i];
            }
        }
        return $captcha;
    }
}
