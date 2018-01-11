<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day21 extends AbstractAdventOfCode
{
    protected $class = 21;
    private $rules = [];
    public $iteration;
    private $pattern = '.#...####';

    public function __construct($input = null)
    {
        parent::__construct($input);
        $this->rules = array_reduce(explode(PHP_EOL, $this->input), function ($carry, $line) {
            list($ruleL, $ruleR) = explode(' => ', $line);
            $carry[str_replace('/', '', $ruleL)] = str_replace('/', '', $ruleR);
            return $carry;
        });
        foreach ($this->rules as $rule => $solution) {
            $flipRule = $this->rotateOrFlipPattern($rule, true, false);
            $this->rules[$flipRule] = $solution;
            for ($i = 0; $i < 3; $i++) {
                $rule = $this->rotateOrFlipPattern($rule, false, true);
                $this->rules[$rule] = $solution;
                $flipRule = $this->rotateOrFlipPattern($rule, true, false);
                $this->rules[$flipRule] = $solution;
            }
        }
    }

    public function firstPart(): string
    {
        $pattern = $this->pattern;
        if (is_null($this->iteration)) {
            $this->iteration = 5;
        }

        for ($i = 0; $i < $this->iteration; $i++) {
            $pattern = $this->enhancement($pattern);
        }

        return $this->countPixels($pattern);
    }

    public function secondPart(): string
    {
        $this->iteration = 18;
        return $this->firstPart();
    }

    private function enhancement(string $pattern): string
    {
        $sizeOfPattern = sqrt(strlen($pattern));
        $size = ($sizeOfPattern % 2 == 0) ? 2 : 3;
        $pattern = $this->increase($pattern, $size);
        for ($stepY = 0; $stepY < $sizeOfPattern + $sizeOfPattern/$size; $stepY += $size + 1) {
            for ($stepX = 0; $stepX < $sizeOfPattern + $sizeOfPattern/$size; $stepX += $size + 1) {
                $subPattern = $this->getSubPattern($stepX, $stepY, $size, $pattern);
                $applyRule = $this->rules[$subPattern];
                $pattern = $this->applyRule($pattern, $applyRule, $stepX, $stepY);
            }
        }

        return $pattern;
    }

    private function increase(string $pattern, int $size): string
    {
        $sizeOfPattern = sqrt(strlen($pattern));
        for ($y = $size; $y <= strlen($pattern); $y += $size + 1) {
            $pattern = substr_replace($pattern, '@', $y, 0);
        }
        $line = $sizeOfPattern + $sizeOfPattern/$size;
        for ($y = $size*$line; $y < $line*$line; $y += ($size+1) * $line) {
            $pattern = substr_replace($pattern, implode('', array_fill(0, $line, '@')), $y, 0);
        }

        return $pattern;
    }

    private function applyRule(string $pattern, string $rule, int $x, int $y): string
    {
        $sizeOfPattern = sqrt(strlen($pattern));
        $sizeOfRule = sqrt(strlen($rule));
        for ($j = 0; $j < $sizeOfRule; $j++) {
            for ($i = 0; $i < $sizeOfRule; $i++) {
                $pattern[(int)(($j+$y)*$sizeOfPattern+($x+$i))] = $rule[(int)($j*$sizeOfRule+$i)];
            }
        }

        return $pattern;
    }

    private function rotateOrFlipPattern(string $pattern, bool $flip, bool $rotate): string
    {
        $sizeOfPattern = sqrt(strlen($pattern));
        $newPattern = $pattern = str_split($pattern);

        if ($flip) {
            for ($y = 0; $y < $sizeOfPattern; $y++) {
                for ($x = 0; $x < $sizeOfPattern; $x++) {
                    $newPattern[$y*$sizeOfPattern+$x] = $pattern[$y*$sizeOfPattern+$sizeOfPattern-$x-1];
                }
            }
            $pattern = $newPattern;
        }

        if ($rotate) {
            for ($y = 0; $y < $sizeOfPattern; $y++) {
                for ($x = 0; $x < $sizeOfPattern; $x++) {
                    $newPattern[$y*$sizeOfPattern+$x] = $pattern[($sizeOfPattern-1-$x)*$sizeOfPattern+$y];
                }
            }
        }

        return implode('', $newPattern);
    }

    private function countPixels(string $pattern): int
    {
        $pattern = str_split($pattern);

        return array_reduce($pattern, function ($carry, $char) {
            if ($char == '#') {
                $carry++;
            }

            return $carry;
        }, 0);
    }

    private function getSubPattern(int $x, int $y, int $size, string $pattern): string
    {
        $sizeOfPattern = sqrt(strlen($pattern));
        $subPattern = '';

        for ($j = 0; $j < $size; $j++) {
            for ($i = 0; $i < $size; $i++) {
                $idx = (int)(($j+$y)*$sizeOfPattern+($i+$x));
                $subPattern .= $pattern[$idx];
            }
        }

        return $subPattern;
    }

    private function printPattern(string $pattern)
    {
        $sizeOfPattern = (int)sqrt(strlen($pattern));
        echo PHP_EOL;
        for ($y = 0; $y < $sizeOfPattern; $y++) {
            for ($x = 0; $x < $sizeOfPattern; $x++) {
                echo $pattern[$y*$sizeOfPattern+$x];
            }
            echo PHP_EOL;
        }
    }
}
