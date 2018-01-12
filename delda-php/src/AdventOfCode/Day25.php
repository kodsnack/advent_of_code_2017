<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day25 extends AbstractAdventOfCode
{
    protected $class = 25;

    public function firstPart(): string
    {
        list($state, $diagnosticChecksum, $rules) = $this->parser($this->input);
        $slot = 0;
        $tape = [];
        for ($i = 0; $i < $diagnosticChecksum; $i++) {
            $this->touringMachine($rules, $tape, $slot, $state);
        }

        return array_sum($tape);
    }

    public function secondPart(): string
    {
        return 0;
    }

    private function parser($input): array
    {
        $rules = [];
        $rule = explode(PHP_EOL.PHP_EOL, $input);
        preg_match('/Begin in state ([A-Z])./', $rule[0], $matches);
        $startState = $matches[1];
        preg_match('/Perform a diagnostic checksum after (\d+) steps./', $rule[0], $matches);
        $diagnosticChecksum = $matches[1];

        for ($i = 1; $i < sizeof($rule); $i++) {
            preg_match('/In state ([A-Z]):/', $rule[$i], $matches);
            $state = $matches[1];
            preg_match_all('/If the current value is ([01]):/', $rule[$i], $value);
            preg_match_all('/Write the value ([01])./', $rule[$i], $write);
            preg_match_all('/Move one slot to the ([lr])/', $rule[$i], $move);
            preg_match_all('/Continue with state ([A-Z])./', $rule[$i], $nextState);
            for ($j = 0; $j < 2; $j++) {
                $rules[$state][$value[1][$j]] =
                    (object)[
                        'write' => $write[1][$j],
                        'move' => $move[1][$j],
                        'state' => $nextState[1][$j]];
            }
        }

        return [$startState, $diagnosticChecksum, $rules];
    }

    private function touringMachine(array $rules, array &$tape, int &$slot, string &$state)
    {
        if ($slot == sizeof($tape)) {
            $tape[] = 0;
        } elseif ($slot == -1) {
            array_unshift($tape, 0);
            $slot = 0;
        }

        $value = $tape[$slot];
        $tape[$slot] = $rules[$state][$value]->write;
        $slot += ($rules[$state][$value]->move == 'l') ? -1 : 1;
        $state = $rules[$state][$value]->state;
    }

    private function printTape(array $tape)
    {
        foreach ($tape as $slot) {
            echo $slot;
        }
        echo PHP_EOL;
    }
}
