import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*

/**
 * This class
 *
 * @author david
 * @version 2017-12-15 19:23.
 */
internal class day15Test {

    @Test
    fun puzzle1_TestInput_ShouldReturn1() {
        val day15Object = day15()
        assertEquals(1, day15Object.puzzle1(65, 8921, 5))
    }

    @Test
    fun puzzle2_TestInput_ShouldReturn0() {
        val day15Object = day15()
        assertEquals(0, day15Object.puzzle2(65, 8921, 5))
    }

    @Test
    fun puzzle1_TestInput_ShouldReturn588() {
        val day15Object = day15()
        assertEquals(588, day15Object.puzzle1(65, 8921))
    }

    @Test
    fun puzzle2_TestInput_ShouldReturn309() {
        val day15Object = day15()
        assertEquals(309, day15Object.puzzle2(65, 8921, 5000000))
    }

    @Test
    fun puzzle1_Solve() {
        val day15Object = day15()
        System.out.println(day15Object.puzzle1(699, 124))
    }

    @Test
    fun puzzle2_Solve() {
        val day15Object = day15()
        System.out.println(day15Object.puzzle2(699, 124, 5000000))
    }
}