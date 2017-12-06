import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*

/**
 * This class
 *
 * @author david
 * @version 2017-12-06 07:54.
 */
internal class day06Test {

    @Test
    fun puzzle1() {
        val day06Object = day06()
        assertEquals(5, day06Object.puzzle1("0\t2\t7\t0"))
    }

    @Test
    fun solvePuzzle1() {
        val day06Object = day06()
        System.out.println(day06Object.puzzle1("11\t11\t13\t7\t0\t15\t5\t5\t4\t4\t1\t1\t7\t1\t15\t11"))
    }
}