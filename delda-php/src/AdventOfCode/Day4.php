<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day4 extends AbstractAdventOfCode
{
    protected $class = 4;

    public function firstPart(): string
    {
        $validPassphrases = 0;
        foreach (explode(PHP_EOL, $this->input) as $line) {
            $passphraseList = [];
            $valid = true;
            foreach (explode(" ", $line) as $word) {
                if (in_array($word, $passphraseList)) {
                    $valid = false;
                    continue;
                } else {
                    array_push($passphraseList, $word);
                }
            }
            $validPassphrases += $valid ? 1 : 0;
        }

        return $validPassphrases;
    }

    public function secondPart(): string
    {
        $validPassphrases = 0;
        foreach (explode(PHP_EOL, $this->input) as $line) {
            $passphraseList = [];
            $words = explode(" ", $line);
            $valid = true;
            foreach ($words as $word) {
                if (!$valid) {
                    break;
                }
                foreach ($passphraseList as $passphrase) {
                    $valid = !$this->anagram($word, $word, $passphrase);
                    if (!$valid) {
                        break;
                    }
                }
                if ($valid) {
                    $passphraseList[] = $word;
                }
            }
            $validPassphrases += $valid ? 1 : 0;
        }

        return $validPassphrases;
    }

    private function anagram(string $baseA, string $a, string $b): bool
    {
        if (strlen($a) == 0 && strlen($b) == 0) {
            return true;
        }
        if (strlen($b) == 0) {
            return false;
        }

        if (strpos($a, substr($b, 0, 1)) !== false) {
            return $this->anagram($baseA, $this->remove(substr($b, 0, 1), $a), substr($b, 1));
        } else {
            return $this->anagram($baseA, $baseA, substr($b, 1));
        }
    }

    private function remove(string $needle, string $haystack): string
    {
        $result = '';
        $firstOccurrence = true;
        $strlen = strlen($haystack);
        for ($i = 0; $i <= $strlen; $i++) {
            $char = substr($haystack, $i, 1);
            if ($firstOccurrence && $char == $needle) {
                $firstOccurrence = false;
            } else {
                $result .= $char;
            }
        }

        return $result;
    }
}
