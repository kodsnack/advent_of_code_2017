<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day10 extends AbstractAdventOfCode
{
    protected $class = 10;
    private $arraySize;
    private $finalSequence = [17, 31, 73, 47, 23];

    public function __construct($input = null, $arraySize = 255)
    {
        parent::__construct($input);
        $this->arraySize = $arraySize;
    }

    public function firstPart(): string
    {
        $circularList = $this->knotHash();
        return $circularList[0] *  $circularList[1];
    }

    public function knotHash()
    {
        $circularList = range(0, $this->arraySize);
        $input = explode(',', $this->input);
        list($circularList,,) = $this->hashFunction($circularList, $input, 0, 0);

        return $circularList;
    }

    private function hashFunction(array $circularList, array $sequenceOfLengths, int $skipSize, int $currentIdx): array
    {
        foreach ($sequenceOfLengths as $length) {
            $leftSublist = array_slice($circularList, $currentIdx, $length, true);

            $rightSublist = [];
            if ($length > 1 && $currentIdx+$length > sizeof($circularList)) {
                $rightSublist = array_slice($circularList, 0, $length-(sizeof($circularList)-$currentIdx), true);
            }

            $sublist = $leftSublist + $rightSublist;
            $k = array_keys($sublist);
            $v = array_values($sublist);
            $rv = array_reverse($v);
            $sublist = array_combine($k, $rv);

            $circularList = array_replace($circularList, $sublist);
            $currentIdx += $length + $skipSize++;
            $currentIdx %= sizeof($circularList);
        }

        return [$circularList, $skipSize, $currentIdx];
    }

    public function secondPart(): string
    {
        $denseHash = [];
        $circularList = range(0, $this->arraySize);
        $sparseHash = $this->stringOfBytes($this->input);
        $skipSize = $currentIdx = 0;

        for ($i = 0; $i < 64; $i++) {
            list($circularList, $skipSize, $currentIdx) = $this->hashFunction($circularList, $sparseHash, $skipSize, $currentIdx);
        }

        for ($i = 0; $i < 255; $i += 16) {
            $denseHash[] = $this->xorOperator(array_slice($circularList, $i, 16));
        }

        return $this->hexadecimalRappresentation($denseHash);
    }

    public function stringOfBytes(string $input): array
    {
        $circularList = $this->convertToASCII($input);
        $circularList = array_merge($circularList, $this->finalSequence);

        return $circularList;
    }

    private function convertToASCII(string $input): array
    {
        $converted = [];
        for ($i = 0; $i < strlen($input); $i++) {
            $converted[] = ord($input[$i]);
        }

        return $converted;
    }

    public function xorOperator(array $inputs): int
    {
        if (empty($inputs)) {
            return 0;
        }

        $result = (int)$inputs[0];
        for ($i = 1; $i < sizeof($inputs); $i++) {
            $result = $result ^ (int)$inputs[$i];
        }

        return $result;
    }

    static public function hexadecimalRappresentation(array $denseHash): string
    {
        $knotHash = '';
        foreach ($denseHash as $number) {
            $knotHash .= self::zeroPadding(dechex($number));
        }

        return $knotHash;
    }

    static public function zeroPadding(string $number, int $limit = 2): string
    {
        return (strlen($number) >= $limit) ? $number : self::zeroPadding("0" . $number);
    }
}
