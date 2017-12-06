<?php

class Direction
{
    private $direction = 3;

    const RIGHT = 0;
    const UP = 1;
    const LEFT = 2;
    const DOWN = 3;

    public function turn()
    {
        $this->direction++;
    }

    public function getDirection()
    {
        return $this->direction % 4;
    }
}

class Position
{
    private $x = 0;
    private $y = 0;

    public function move(Direction $direction, $offset)
    {
        switch ($direction->getDirection()) {
            case Direction::RIGHT:
                $this->x += $offset;
                break;

            case Direction::UP:
                $this->y += $offset;
                break;

            case Direction::LEFT:
                $this->x -= $offset;
                break;

            case Direction::DOWN:
                $this->y -= $offset;
                break;
        }
    }

    public function getDistanceToAccessPort()
    {
        return abs($this->x) + abs($this->y);
    }

    /**
     * @return int
     */
    public function getX()
    {
        return $this->x;
    }

    /**
     * @return int
     */
    public function getY()
    {
        return $this->y;
    }
}

$input = 325489;

$number         = 1;
$steps          = 1;
$direction      = new Direction();
$position       = new Position();
$incrementSteps = false;

while ($number < $input) {
    //Sväng
    $direction->turn();

    //Gå $steps steg
    $position->move($direction, $steps);
    $number += $steps;

    printf('Number %d is at (%d,%d)' . PHP_EOL, $number, $position->getX(), $position->getY());

    if ($incrementSteps) {
        $steps++;
    }

    $incrementSteps = !$incrementSteps;
}

$tooLong = $number - $input;
$position->move($direction, -1 * $tooLong);

printf('Number %d is at (%d,%d)' . PHP_EOL, $input, $position->getX(), $position->getY());

printf('Distance to access port: %d steps', $position->getDistanceToAccessPort());