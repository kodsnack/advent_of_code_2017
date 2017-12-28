<?php

namespace src\AdventOfCode;

abstract class AbstractAdventOfCode
{
    protected $input;

    abstract public function firstPart(): string;
    abstract public function secondPart(): string;

    public function __construct($input = null)
    {
        if (is_null($input)) {
            $input = file_get_contents(__DIR__.'/../Resources/Day'.$this->class.'Input');
        }
        $this->input = $input;
    }

    public function result(int $part): array
    {
        $result = [];
        switch ($part) {
            case 0:
                $result[] = $this->firstPart();
                $result[] = $this->secondPart();
                break;
            case 1:
                $result[] = $this->firstPart();
                break;
            case 2:
                $result[] = $this->secondPart();
                break;
        }

        return $result;
    }
}
