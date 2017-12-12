package com.mantono.aoc

import java.awt.Point

class Matrix(x: Int)
{
	val width: Int = x
	private val arr: Array<Int> = Array(x*x, {0})

	operator fun get(x: Int, y: Int): Int = arr[x + width * y]
	operator fun get(p: Point): Int = arr[p.x + width * p.y]
	operator fun set(x: Int, y: Int, e: Int) { arr[x + width * y] = e }
	operator fun set(p: Point, e: Int) { arr[p.x + width * p.y] = e }

	operator fun get(n: Int): Int
	{
		if(n < 0) throw IndexOutOfBoundsException("$n")
		if(n == 0) return 1
		val center = center(this)
		return getRec(n, 1, center, HashSet())
	}

	private tailrec fun getRec(wantedIndex: Int, currentIndex: Int, pos: Point, seen: MutableSet<Point>): Int
	{
		if(wantedIndex == currentIndex) return this[pos]
		seen.add(pos)
		val nextPos: Point = adjacentEightOf(pos)
				.minus(seen)
				.filterNot { isOutOfBounds(it) }
				.map { this[it] to it }
				.sortedBy { it.first }
				.map { it.second }
				.first()

		return getRec(wantedIndex, currentIndex + 1, nextPos, seen)
	}

	fun getSafe(p: Point, replacement: Int = 0): Int
	{
		if(isOutOfBounds(p)) return replacement
		return this[p]
	}


	fun isOutOfBounds(p: Point): Boolean
	{
		if(p.x < 0 || p.y < 0) return true
		return (p.x >= width || p.y >= width)
	}

	override fun toString(): String
	{
		return arr.asSequence()
				.mapIndexed { index, i ->
					"$i" + if(index % width == (width - 1)) "\n" else ", "
				}
				.joinToString(separator = "") { it }
	}
}

fun initialize(m: Matrix)
{
	val center = center(m)
	m[center.x, center.y] = 1
	fill(m, center go Direction.EAST)
}

enum class Direction(val deltaX: Int, val deltaY: Int)
{
	NORTH(0, -	1),
	WEST(-1, 0),
	SOUTH(0, 1),
	EAST(1, 0);
}

infix fun Point.go(d: Direction): Point = Point(this.x + d.deltaX, this.y + d.deltaY)

private tailrec fun fill(m: Matrix, p: Point)
{
	val sum: Int = sumOfAdjacentForPos(m, p)
	m[p.x, p.y] = sum

	val nextDirection: Direction = nextDirection(m, p) ?: return

	fill(m, p go nextDirection)
}

fun adjacentFourOf(p: Point): Sequence<Pair<Point, Direction>>
{
	return Direction.values().asSequence()
			.map { dir ->  p go dir to dir }
}

fun adjacentEightOf(p: Point): Sequence<Point>
{
	return adjacentFourOf(p)
			.map { it.first }
			.plus(p go Direction.NORTH go Direction.WEST)
			.plus(p go Direction.NORTH go Direction.EAST)
			.plus(p go Direction.SOUTH go Direction.WEST)
			.plus(p go Direction.SOUTH go Direction.EAST)
}

fun nextDirection(m: Matrix, p: Point): Direction?
{
	val bitCombo = adjacentFourOf(p)
			.map { (adjacentPos, dir) ->
				val occupied: Int = m.getSafe(adjacentPos, 1).coerceIn(0, 1)
				occupied shl dir.ordinal
			}
			.sum()

	return when(bitCombo)
	{
		0, 1, 3, 5, 7 -> Direction.EAST
		2, 6, 10, 14 -> Direction.NORTH
		4, 12 -> Direction.WEST
		8, 9 -> Direction.SOUTH
		15 -> null
		else -> throw IllegalStateException("Unhandled value $bitCombo ($p) for matrix\n$m")
	}
}

fun sumOfAdjacentForPos(m: Matrix, p: Point): Int
{
	return sequenceOf(
			p go Direction.WEST,
			p go Direction.EAST,
			p go Direction.NORTH,
			p go Direction.SOUTH,
			p go Direction.NORTH go Direction.WEST,
			p go Direction.NORTH go Direction.EAST,
			p go Direction.SOUTH go Direction.WEST,
			p go Direction.SOUTH go Direction.EAST
	)
			.filter { !m.isOutOfBounds(it) }
			.map { m[it.x, it. y] }
			.sum()
}

fun center(m: Matrix): Point
{
	val center: Int = m.width/2 + (m.width % 2)
	return Point(center, center)
}