package com.mantono.aoc

import org.junit.Assert.assertEquals
import org.junit.Test

class LayerTest
{
	@Test
	fun testLayer1()
	{
		assertEquals(1, layerOf(1))
	}

	@Test
	fun testLayer2()
	{
		assertEquals(2, layerOf(2))
	}

	@Test
	fun testLayer9()
	{
		assertEquals(2, layerOf(9))
	}

	@Test
	fun testLayer40()
	{
		assertEquals(4, layerOf(40))
	}
}