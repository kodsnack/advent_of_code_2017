import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import java.io.File

/**
 * This class
 *
 * @author david
 * @version 2017-12-14 20:32.
 */
internal class day12Test {

    @Test
    fun puzzle1_TestInput_ShouldReturn6() {
        val day12Object = day12()
        assertEquals(6, day12Object.puzzle1("0 <-> 2\n" +
                "1 <-> 1\n" +
                "2 <-> 0, 3, 4\n" +
                "3 <-> 2, 4\n" +
                "4 <-> 2, 3, 6\n" +
                "5 <-> 6\n" +
                "6 <-> 4, 5"))
    }

    @Test
    fun puzzle2_TestInput_ShouldReturn2() {
        val day12Object = day12()
        assertEquals(2, day12Object.puzzle2("0 <-> 2\n" +
                "1 <-> 1\n" +
                "2 <-> 0, 3, 4\n" +
                "3 <-> 2, 4\n" +
                "4 <-> 2, 3, 6\n" +
                "5 <-> 6\n" +
                "6 <-> 4, 5"))
    }
}