<?php

namespace src\AdventOfCode;

use SebastianBergmann\CodeCoverage\Report\PHP;

class Day12 extends AbstractAdventOfCode
{
    protected $class = 12;

    public function firstPart(): string
    {
        $graph = $this->parser();

        return sizeof($this->programsGroup($graph, 0));
    }

    public function secondPart(): string
    {
        $graph = $this->parser();
        $groups = 0;

        while (sizeof($graph)) {
            $program = (reset($graph))[0];
            $groups++;
            $partialGraph = $this->programsGroup($graph, $program);
            $graph = array_diff_key($graph, $partialGraph);
        }

        return $groups;
    }

    private function parser(): array
    {
        $graph = [];
        foreach(explode(PHP_EOL, $this->input) as $line) {
            list($node, $nodes) = explode(' <-> ', $line);
            $graph[$node] = explode(', ', $nodes);
        }

        return $graph;
    }

    private function programsGroup(array $graph, int $program): array
    {
//        var_dump($graph);
        $circle = false;
        $nodesVisited = [];
        $nodesQueue = new \SplQueue();
        $nodesQueue->enqueue($program);
        $nodesVisited[$program] = true;

        while (!$nodesQueue->isEmpty()) {
            $currentNode = $nodesQueue->dequeue();

//            var_dump("* $currentNode");
            foreach ($graph[$currentNode] as $node) {
                if (!$circle && $node == $program) {
                    $circle = true;
                }
                if (!isset($nodesVisited[$node])) {
                    $nodesVisited[$node] = true;
                    $nodesQueue->enqueue($node);
                }
            }
        }

        return $circle ? $nodesVisited : [];
    }
}
