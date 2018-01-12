<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day22 extends AbstractAdventOfCode
{
    protected $class = 22;
    public $burstsOfActivity = 10000;

    public function firstPart(): string
    {
        $map = $this->parse($this->input);
        $x = $y = (int)(sizeof($map)/2);
        $direction = 'n';
        $activity = 0;
        for ($i = 0; $i < $this->burstsOfActivity; $i++) {
            $this->infection($map, $x, $y, $direction, $activity);
        }

        return $activity;
    }

    public function secondPart(): string
    {
        $map = $this->parse($this->input);
        $x = $y = (int)(sizeof($map)/2);
        $direction = 'n';
        $activity = 0;
        for ($i = 0; $i < $this->burstsOfActivity; $i++) {
            $this->infection2($map, $x, $y, $direction, $activity);
        }

        return $activity;
    }

    private function infection(array &$map, int &$x, int &$y, string &$direction, int &$activity)
    {
        if ($map[$y][$x] == '#') {
            $map[$y][$x] = '.';
            $this->turn($x, $y, $direction, 'r');
        } else {
            $activity++;
            $map[$y][$x] = '#';
            $this->turn($x, $y, $direction, 'l');
        }
        $this->enlarge($map, $x, $y);
    }

    private function infection2(array &$map, int &$x, int &$y, string &$direction, int &$activity)
    {
        switch ($map[$y][$x]) {
            case '.':
                $map[$y][$x] = 'W';
                $this->turn($x, $y, $direction, 'l');
                break;
            case 'W':
                $map[$y][$x] = '#';
                $activity++;
                $this->turn($x, $y, $direction, 'c');
                break;
            case '#':
                $map[$y][$x] = 'F';
                $this->turn($x, $y, $direction, 'r');
                break;
            case 'F':
                $map[$y][$x] = '.';
                $this->turn($x, $y, $direction, 'rc');
                break;
        }
        $this->enlarge($map, $x, $y);
    }

    private function turn(int &$x, int &$y, string &$direction, string $side)
    {
        switch ($direction) {
            case 'n':
                if ($side == 'l') {
                    $x--;
                    $direction = 'w';
                } elseif ($side == 'r') {
                    $x++;
                    $direction = 'e';
                } elseif ($side == 'c') {
                    $y--;
                } elseif ($side == 'rc') {
                    $y++;
                    $direction = 's';
                }
                break;
            case 'e':
                if ($side == 'l') {
                    $y--;
                    $direction = 'n';
                } elseif ($side == 'r') {
                    $y++;
                    $direction = 's';
                } elseif ($side == 'c') {
                    $x++;
                } elseif ($side == 'rc') {
                    $x--;
                    $direction = 'w';
                }
                break;
            case 's':
                if ($side == 'l') {
                    $x++;
                    $direction = 'e';
                } elseif ($side == 'r') {
                    $x--;
                    $direction = 'w';
                } elseif ($side == 'c') {
                    $y++;
                } elseif ($side == 'rc') {
                    $y--;
                    $direction = 'n';
                }
                break;
            case 'w':
                if ($side == 'l') {
                    $y++;
                    $direction = 's';
                } elseif ($side == 'r') {
                    $y--;
                    $direction = 'n';
                } elseif ($side == 'c') {
                    $x--;
                } elseif ($side == 'rc') {
                    $x++;
                    $direction = 'e';
                }
                break;
        }
    }

    private function printMap($map, $i, $j)
    {
        echo PHP_EOL;
        for ($y = 0; $y < sizeof($map); $y++) {
            for ($x = 0; $x < sizeof($map[$y]); $x++) {
                if ($i == $x && $j == $y) {
                    echo '@';
                } else {
                    echo $map[$y][$x];
                }
            }
            echo PHP_EOL;
        }
    }

    private function enlarge(&$map, &$x, &$y)
    {
        if ($x < 0) {
            for ($i = 0; $i < sizeof($map); $i++) {
                array_splice($map[$i], 0, 0, '.');
            }
            $x++;
        } elseif ($y < 0) {
            array_splice($map, 0, 0, [array_fill(0, sizeof($map[$x]), '.')]);
            $y++;
        } elseif ($y > (sizeof($map) - 1)) {
            $map[$y] = array_fill(0, sizeof($map[$y-1]), '.');
        } elseif ($x > (sizeof($map[$y]) - 1)) {
            for ($i = 0; $i < sizeof($map); $i++) {
                $map[$i][$x] = '.';
            }
        }
    }

    private function parse(string $input): array
    {
        $map = [];
        $lines = explode(PHP_EOL, $input);
        foreach ($lines as $line) {
            $map[] = str_split($line);
        }

        return $map;
    }
}
