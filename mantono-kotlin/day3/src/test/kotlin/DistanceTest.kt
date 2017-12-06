package com.mantono.aoc

import org.junit.Assert.assertEquals
import org.junit.Test

class DistanceTest
{
	@Test
	fun test1()
	{
		assertEquals(0, distance(1))
	}

	@Test
	fun test12()
	{
		assertEquals(3, distance(12))
	}

	@Test
	fun test23()
	{
		assertEquals(2, distance(23))
	}

	@Test
	fun test1024()
	{
		assertEquals(31, distance(1024))
	}
}