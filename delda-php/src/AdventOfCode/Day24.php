<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day24 extends AbstractAdventOfCode
{
    protected $class = 24;

    public function firstPart(): string
    {
        $components = $this->parser($this->input);
        return $this->strongestBridge($components);
    }

    public function secondPart(): string
    {
        $components = $this->parser($this->input);
        list($length, $result) = $this->strongestLongestBridge($components);

        return $result;
    }

    private function parser($input): array
    {
        $components = [];
        foreach (explode(PHP_EOL, $input) as $component) {
            $components[] = explode('/', $component);
        }

        return $components;
    }

    private function strongestBridge(array $components, int $value = 0): int
    {
        $maxResult = 0;
        foreach ($components as $component) {
            if (in_array($value, $component)) {
                $newComponents = array_filter($components, function ($comp) use ($component) {
                    return $comp == $component ? 0 : 1;
                });
                $newValue = ($value == $component[0]) ? $component[1] : $component[0];
                $maxResult = max($maxResult, $this->strongestBridge($newComponents, $newValue) + array_sum($component));
            }
        }

        return $maxResult;
    }

    private function strongestLongestBridge(array $components, int $value = 0): array
    {
        $maxResult = 0;
        $maxLenght = 0;
        foreach ($components as $component) {
            if (in_array($value, $component)) {
                $newComponents = array_filter($components, function ($comp) use ($component) {
                    return $comp == $component ? 0 : 1;
                });
                $newValue = ($value == $component[0]) ? $component[1] : $component[0];
                list($lenght, $result) = $this->strongestLongestBridge($newComponents, $newValue);
                if ($lenght + 1 > $maxLenght) {
                    $maxResult = $result + array_sum($component);
                    $maxLenght = $lenght + 1;
                } elseif ($lenght + 1 == $maxLenght) {
                    $maxResult = max($maxResult, $result + array_sum($component));
                }
            }
        }

        return [$maxLenght, $maxResult];
    }
}
