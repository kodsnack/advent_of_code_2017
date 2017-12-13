package com.mantono.aoc

private const val INPUT: Long = 312051L

fun main(args: Array<String>)
{
	// Part 1
	println(distance(INPUT.toInt()))

	// Part 2
	println(distanceAggregatedSum(INPUT))
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
			.minBy { it.second }!!
			.first

	return values[index]
}

fun options(layer: Int): List<Int>
{
	val sideLength: Int = sideLength(layer)
	val maxSteps: Int = (sideLength / 2)
	val lastValue: Int = lastValueInLayer(layer.toLong()).toInt()

	return listOf(1, 3, 5, 7).map { lastValue - (it * maxSteps) }
}

fun sideLength(layer: Int): Int = (layer * 2) - 1

fun layerOf(n: Int): Int = when(n)
{
	1 -> 1
	else ->
	{
		val result = binarySearch(n.toLong(), 2, ::lastValueInLayer, 1L .. Short.MAX_VALUE.toLong())
		when(result)
		{
			is Result.Exact -> result.value
			is Result.Indeterminable -> result.high
		}.toInt()
	}
}

tailrec fun binarySearch(goal: Long,
						 input: Long = 2,
						 func: (Long) -> Long,
						 r: LongRange = 1L .. Byte.MAX_VALUE.toLong()): Result
{
	if((r.endInclusive - r.start) == 1L)
		return Result.Indeterminable(r.start, r.endInclusive)

	val result: Long = func(input)

	return when
	{
		result < goal -> {
			val range: LongRange = maxOf(r.first, input) .. r.last
			binarySearch(goal, range.middle(), func, range)
		}
		result > goal -> {
			val range: LongRange = maxOf(r.first, 1) .. minOf(r.last, input)
			binarySearch(goal, range.middle(), func, range)
		}
		else -> Result.Exact(input)
	}
}

sealed class Result
{
	class Exact(val value: Long): Result()
	class Indeterminable(val low: Long, val high: Long): Result()
}

fun distanceAggregatedSum(input: Long): Long
{
	val m = Matrix(12)
	initialize(m)
	val result: Result = binarySearch(INPUT, func = { input -> m[input.toInt()].toLong() })
	return when(result)
	{
		is Result.Indeterminable -> m[result.high.toInt()]
		is Result.Exact -> m[result.value.toInt()]
	}.toLong()
}

fun lastValueInLayer(layer: Long): Long
{
	if(layer < 1) throw IllegalArgumentException("We cannot have negative layers")
	val base: Long = (layer * 2) - 1
	return base * base
}

fun LongRange.middle(): Long = (this.start + this.last) / 2