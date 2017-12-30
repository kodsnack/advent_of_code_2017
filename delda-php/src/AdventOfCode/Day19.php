<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day19 extends AbstractAdventOfCode
{
    private $sizeOfDiagram;
    protected $class = 19;

    public function __construct($input = null)
    {
        parent::__construct($input);
        $diagram = explode(PHP_EOL, $this->input);
        $this->sizeOfDiagram = strlen($diagram[0]);
    }

    public function firstPart(): string
    {
        list($solution, $steps) =  $this->followThePath();

        return $solution;
    }

    public function secondPart(): string
    {
        list($solution, $steps) =  $this->followThePath();

        return $steps;
    }

    private function followThePath(): array
    {
        $offset = $this->findStart();

        return $this->followTheLine($offset);
    }

    private function findStart(): int
    {
        $diagram = $this->input;
        $i = 0;
        do {
            if ($diagram[$i] === PHP_EOL) {
                return false;
            } elseif ($diagram[$i] === '|') {
                return $i;
            }
        } while (++$i);
    }

    private function followTheLine(int $offset): array
    {
        $steps = 0;
        $solution = '';
        $direction = 'down';
        $diagram = $this->input;

        do {
            $char = $diagram[$offset];
            if ($char == '+') {
                $direction = $this->searchLineInNeighborhood($offset, $direction);
            } elseif (preg_match('/[A-Z]/', $char)) {
                $solution .= $char;
            }

            $offset = $this->move($offset, $direction);
            $steps++;
        } while ($char != ' ' || !$direction);

        return [$solution, --$steps];
    }

    private function searchLineInNeighborhood(int $offset, string $dir): string
    {
        $diagram = $this->input;

        if ($diagram[$offset] != '+') {
            return false;
        }

        switch ($dir) {
            case 'right':
                $dir = 'left';
                break;
            case 'left':
                $dir = 'right';
                break;
            case 'up':
                $dir = 'down';
                break;
            case 'down':
                $dir = 'up';
                break;
        }

        $directions = ['up', 'right', 'down', 'left'];
        $directions = array_diff($directions, [$dir]);
        foreach ($directions as $direction) {
            $newOffset = $this->move($offset, $direction);
            if ($diagram[$newOffset] != ' ') {
                return $direction;
            }
        }

        return false;
    }

    private function move(int $offset, string $direction): int
    {
        switch ($direction) {
            case 'up':
                $offset -= $this->sizeOfDiagram + 1;
                break;
            case 'right':
                $offset++;
                break;
            case 'down':
                $offset += $this->sizeOfDiagram + 1;
                break;
            case 'left':
                $offset--;
                break;
        }

        return $offset;
    }
}
