package com.mantono.aoc

fun main(args: Array<String>)
{

}

fun distance(n: Int): Int
{
	return -1
}

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
			//val next: Int = (l * 2).coerceIn(range)
			layer(n, range.middle(), range)
		}
		else -> l
	}
}

fun lastValueInLayer(layer: Int): Int
{
	if(layer < 1) throw IllegalArgumentException("We cannot have negative layers")
	val base: Int = (layer * 2) - 1
	return base * base
}

fun IntRange.middle(): Int = (this.start + this.last) / 2