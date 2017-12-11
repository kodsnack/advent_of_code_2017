package com.mantono.aoc

fun main(args: Array<String>)
{
	println(distance(312051))
	val m = Matrix(12)
	initialize(m)
	binarySearch(312051, func = { m[] })
}

fun distance(n: Int): Int
{
	val layer: Int = layerOf(n)
	val options: List<Int> = options(layer)
	val closest: Int = findClosestValue(n, options)
	val stepsToClosest: Int = Math.abs(n - closest)
	return (layer - 1) + stepsToClosest
}

fun findClosestValue(n: Int, values: List<Int>): Int
{
	val index: Int = values.asSequence()
			.mapIndexed { index, i -> index to Math.abs(n - i) }
			.onEach { println(it) }
			.minBy { it.second }!!
			.first

	return values[index]
}

fun options(layer: Int): List<Int>
{
	val sideLength: Int = sideLength(layer)
	val maxSteps: Int = (sideLength / 2)
	val lastValue: Int = lastValueInLayer(layer)

	return listOf(1, 3, 5, 7).map { lastValue - (it * maxSteps) }
}

fun sideLength(layer: Int): Int = (layer * 2) - 1

fun layerOf(n: Int): Int = when(n)
{
	1 -> 1
	else -> layer(n, 2)
}

private val ceil: Int = Math.sqrt(Int.MAX_VALUE.toDouble()).toInt() / 2

private tailrec fun layer(n: Int, l: Int, r: IntRange = 1 .. ceil): Int
{
	val first: Int = lastValueInLayer(l - 1) + 1
	val last: Int = lastValueInLayer(l)

	println(r)

	return when
	{
		n < first -> {
			val range = r.start .. minOf(r.last, l - 1)
			layer(n, range.middle(), range)
		}
		n > last -> {
			val range = maxOf(r.start, l + 1) .. r.last
			layer(n, range.middle(), range)
		}
		else -> l
	}
}

tailrec fun binarySearch(goal: Long, input: Long = 2, func: (Long) -> Long, r: LongRange = 1L .. Byte.MAX_VALUE.toLong()): Long
{
	val result: Long = func(input)

	println(result)
	return when
	{
		result < goal -> {
			val range: LongRange = maxOf(r.first, input) .. r.last + 1
			binarySearch(goal, range.middle(), func, range)
		}
		result > goal -> {
			val range: LongRange = maxOf(r.first - 1, 1) .. minOf(r.last, input)
			binarySearch(goal, range.middle(), func, range)
		}
		else -> input
	}
}

fun lastValueInLayer(layer: Int): Int
{
	if(layer < 1) throw IllegalArgumentException("We cannot have negative layers")
	val base: Int = (layer * 2) - 1
	return base * base
}

fun IntRange.middle(): Int = (this.start + this.last) / 2
fun LongRange.middle(): Long = (this.start + this.last) / 2