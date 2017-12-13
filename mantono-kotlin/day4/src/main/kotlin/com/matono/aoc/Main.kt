package com.matono.aoc

import java.io.File
import java.nio.file.Files

fun main(args: Array<String>)
{
	val uniqueWords: Int = Files.readAllLines(File("input").toPath()).asSequence()
			.map { it.split(Regex("\\s")) }
			.flatMap { it.asSequence() }
			.distinct()
			.count()

	println(uniqueWords)

	val fac: Long = factorial(uniqueWords.toLong())
	println(fac)
}

fun factorial(n: Long) = factorial(n, n)

private tailrec fun factorial(n: Long, sum: Long): Long
{
	if(n == 1L) return sum
	return factorial(n - 1, (n - 1) * sum)
}