<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day16 extends AbstractAdventOfCode
{
    protected $class = 16;
    public $programs;

    public function __construct($input = null)
    {
        parent::__construct($input);
        $this->programs = range('a', 'p');
    }

    public function firstPart(): string
    {
        foreach (explode(',', $this->input) as $command) {
            switch (substr($command, 0, 1)) {
                case 's':
                    preg_match('/s(\d+)/', $command, $matches);
                    $spin = $matches[1];
                    for ($i = 0; $i < $spin; $i++) {
                        array_unshift($this->programs, array_pop($this->programs));
                    }
                    break;
                case 'x':
                    preg_match('/x(\d+)/', $command, $matches);
                    $keyA = $matches[1];
                    preg_match('/x\d+\/(\d+)/', $command, $matches);
                    $keyB = $matches[1];
                    $tmp = $this->programs[$keyA];
                    $this->programs[$keyA] = $this->programs[$keyB];
                    $this->programs[$keyB] = $tmp;
                    break;
                case 'p':
                    $a = substr($command, 1, 1);
                    $b = substr($command, 3, 1);
                    $keyA = array_search($a, $this->programs);
                    $keyB = array_search($b, $this->programs);
                    $tmp = $this->programs[$keyA];
                    $this->programs[$keyA] = $this->programs[$keyB];
                    $this->programs[$keyB] = $tmp;
                    break;
            }
        }

        return implode($this->programs);
    }

    public function secondPart(): string
    {
        $solutions = [];
        while (!in_array(implode($this->programs), $solutions)) {
            $solutions[] = implode($this->programs);
            $this->programs = str_split($this->firstPart());
        }

        return $solutions[1000000000 % sizeof($solutions)];
    }
}
