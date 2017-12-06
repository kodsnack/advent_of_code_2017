import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*


/**
 * This class
 *
 * @author david
 * @version 2017-12-05 08:06.
 */
internal class day05Test {

    @Test
    fun puzzle1() {
        val day05Object = day05()
        assertEquals(5, day05Object.puzzle1("0\n" +
                "3\n" +
                "0\n" +
                "1\n" +
                "-3"))
    }

    @Test
    fun puzzle2() {
        val day05Object = day05()
        assertEquals(10, day05Object.puzzle2("0\n" +
                "3\n" +
                "0\n" +
                "1\n" +
                "-3"))
    }
}