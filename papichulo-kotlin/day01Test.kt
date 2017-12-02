import org.junit.jupiter.api.Assertions.*

/**
 * This class
 *
 * @author david
 * @version 2017-12-01 14:59.
 */
internal class day01Test {
    @org.junit.jupiter.api.Test
    fun puzzle1_1122_ShouldReturn3() {
        val day01Object = day01()
        assertEquals(3, day01Object.puzzle1("1122"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle1_1111_ShouldReturn4() {
        val day01Object = day01()
        assertEquals(4, day01Object.puzzle1("1111"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle1_1234_ShouldReturn0() {
        val day01Object = day01()
        assertEquals(0, day01Object.puzzle1("1234"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle1_91212129_ShouldReturn9() {
        val day01Object = day01()
        assertEquals(9, day01Object.puzzle1("91212129"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle2_1212_ShouldReturn6() {
        val day01Object = day01()
        assertEquals(6, day01Object.puzzle2("1212"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle2_1221_ShouldReturn0() {
        val day01Object = day01()
        assertEquals(0, day01Object.puzzle2("1221"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle2_123425_ShouldReturn4() {
        val day01Object = day01()
        assertEquals(4, day01Object.puzzle2("123425"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle2_123123_ShouldReturn12() {
        val day01Object = day01()
        assertEquals(12, day01Object.puzzle2("123123"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle2_12131415_ShouldReturn4() {
        val day01Object = day01()
        assertEquals(4, day01Object.puzzle2("12131415"))
    }
}