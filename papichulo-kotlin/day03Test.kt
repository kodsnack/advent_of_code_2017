import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*

/**
 * This class
 *
 * @author david
 * @version 2017-12-03 19:39.
 */
internal class day03Test {

    @Test
    fun puzzle1_Input1_ShouldReturn0() {
        val day03Object = day03_1()
        assertEquals(0, day03Object.puzzle1("1"))
    }

    @Test
    fun puzzle1_Input12_ShouldReturn3() {
        val day03Object = day03_1()
        assertEquals(3, day03Object.puzzle1("12"))
    }

    @Test
    fun puzzle1_Input23_ShouldReturn2() {
        val day03Object = day03_1()
        assertEquals(2, day03Object.puzzle1("23"))
    }

    @Test
    fun puzzle1_Input1024_ShouldReturn31() {
        val day03Object = day03_1()
        assertEquals(31, day03Object.puzzle1("1024"))
    }
}