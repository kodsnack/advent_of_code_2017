package com.mantono.aoc

import java.io.File
import java.nio.file.Files
import java.util.*
import kotlin.collections.ArrayList

fun main(args: Array<String>)
{
	val input = File("input")
	val result1 = checksum(input, ::lowestHighest)
	val result2 = checksum(input, ::evenDivisible)
	println(result1)
	println(result2)
	println(ops)
}

fun checksum(input: File, sumFunc: (List<Int>) -> Int): Int
{
	return Files.readAllLines(input.toPath()).asSequence()
			.map { it.split(Regex("\\s+")) }
			.map { it.map { it.toInt() } }
			.map(sumFunc)
			.sum()
}

fun lowestHighest(numbers: List<Int>): Int
{
	val sorted: SortedSet<Int> = numbers.toSortedSet()
	return sorted.last() - sorted.first()
}

var ops: Int = 0

fun evenDivisible(numbers: List<Int>): Int
{
	val (x, y) = numbers.sorted()
			.toList()
			.toMatrix { x, y -> x <= y / 2}
			.onEach(::println)
			.first { (x, y) -> x % y == 0 }

	return x / y
}

inline fun <T> List<T>.toMatrix(preFilterPredicate: (x: T, y: T) -> Boolean = {_, _ -> true }): Sequence<Pair<T, T>>
{
	val out: MutableList<Pair<T, T>> = ArrayList(this.size*this.size)

	for(n in this.indices)
		for(i in this.lastIndex downTo 0)
			if(preFilterPredicate(this[n], this[i]))
				out.add(this[n] to this[i])

	return out.asSequence()
}