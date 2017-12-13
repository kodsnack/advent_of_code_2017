package com.matono.aoc

import java.io.File
import java.nio.file.Files

fun main(args: Array<String>)
{
	val validPhrases1: Int = Files.readAllLines(File("input").toPath()).asSequence()
			.map { it.split(Regex("\\s")) }
			.filter(::noRepeatedWords)
			.count()

	println(validPhrases1)

	val validPhrases2: Int = Files.readAllLines(File("input").toPath()).asSequence()
			.map { it.split(Regex("\\s")) }
			.map(::sortLetters)
			.filter(::noRepeatedWords)
			.count()

	println(validPhrases2)
}

fun noRepeatedWords(words: List<String>): Boolean
{
	val total: Int = words.count()
	val unique: Int = words.distinct().count()
	return total == unique
}

fun sortLetters(words: List<String>): List<String>
{
	return words.asSequence()
			.map { String(it.toList().sorted().toCharArray()) }
			.toList()
}