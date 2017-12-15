import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import java.io.File

/**
 * This class
 *
 * @author david
 * @version 2017-12-08 08:10.
 */
internal class day08Test {

    @Test
    fun puzzle1() {
        val day08Object = day08()
        assertEquals(1, day08Object.puzzle1("b inc 5 if a > 1\n" +
                "a inc 1 if b < 5\n" +
                "c dec -10 if a >= 1\n" +
                "c inc -20 if c == 10"))
    }

    @Test
    fun puzzle2() {
        val day08Object = day08()
        assertEquals(10, day08Object.puzzle2("b inc 5 if a > 1\n" +
                "a inc 1 if b < 5\n" +
                "c dec -10 if a >= 1\n" +
                "c inc -20 if c == 10"))
    }

}