<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day8 extends AbstractAdventOfCode
{
    protected $class = 8;

    public function __construct($input = null)
    {
        parent::__construct($input);
        list($this->largestValue, $this->highestValue) = $this->executeInstructions();
    }

    public function firstPart(): string
    {
        return $this->largestValue;
    }

    public function secondPart(): string
    {
        return $this->highestValue;
    }

    private function executeInstructions(): array
    {
        $registers = [];
        $highestValue = -PHP_INT_MAX;
        foreach (explode(PHP_EOL, $this->input) as $line) {
            $parsedLine = $this->parser($line);

            ${$parsedLine->leftCondition} = isset(${$parsedLine->leftCondition}) ? ${$parsedLine->leftCondition} : 0;
            $conditionEvaluation = eval('return $'.$parsedLine->leftCondition.' '.$parsedLine->condition.' '.$parsedLine->rightCondition.';');

            if ($conditionEvaluation) {
                ${$parsedLine->register} = isset(${$parsedLine->register}) ? ${$parsedLine->register} : 0;
                $operation = ($parsedLine->operation == 'inc') ? '+=' : '-=';
                eval('return $'.$parsedLine->register.' '.$operation.' '.$parsedLine->amount.';');
                $registers[$parsedLine->register] = ${$parsedLine->register};
                if (${$parsedLine->register} > $highestValue) {
                    $highestValue = ${$parsedLine->register};
                }
            }
        }

        $largestValue = -PHP_INT_MAX;
        foreach ($registers as $register) {
            if ($register > $largestValue) {
                $largestValue = $register;
            }
        }

        return [$largestValue, $highestValue];
    }

    private function parser(string $line): \stdClass
    {
        list($registerPart, $conditionPart) = explode('if ', $line);
        list($register, $operation, $amount) = explode(' ', $registerPart);
        list($leftCondition, $condition, $rightCondtion) = explode(' ', $conditionPart);

        $result = new \stdClass();
        $result->register = $register;
        $result->operation = $operation;
        $result->amount = $amount;
        $result->leftCondition = $leftCondition;
        $result->condition = $condition;
        $result->rightCondition = $rightCondtion;

        return $result;
    }
}
