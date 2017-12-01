<?php

namespace src\AdventOfCode;

abstract class AbstractAdventOfCode
{
    protected $input;

    abstract function firstPart(): string;
    abstract function secondPart(): string;

    public function __construct($input)
    {
        $this->input = $input;
    }

    public function result(int $part): array
    {
        $result = [];
        switch ($part) {
            case 0:
                $result[] = $this->firstPart();
                $result[] = $this->secondPart();
            case 1:
                $result[] = $this->firstPart();
                break;
            case 2:
                $result[] = $this->secondPart();
                break;
        }
    }
}