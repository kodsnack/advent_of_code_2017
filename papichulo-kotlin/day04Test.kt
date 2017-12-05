import org.junit.jupiter.api.Test
import java.io.File
import kotlin.test.assertFalse
import kotlin.test.assertTrue

internal class day04Test {
    @Test
    fun puzzle1_UniqueList_ShouldReturnTrue() {
        val day04Object = day04()
        assertTrue(day04Object.puzzle1("aa bb cc dd ee"))
    }

    @Test
    fun puzzle1_NotUniqueList_ShouldReturnFalse() {
        val day04Object = day04()
        assertFalse(day04Object.puzzle1("aa bb cc dd aa"))
    }

    @Test
    fun puzzle1_UniqueListIncludesSubset_ShouldReturnTrue() {
        val day04Object = day04()
        assertTrue(day04Object.puzzle1("aa bb cc dd aaa"))
    }

    @Test
    fun puzzle2_List1_ShouldReturnTrue() {
        val day04Object = day04()
        assertTrue(day04Object.puzzle2("abcde fghij"))
    }

    @Test
    fun puzzle2_List2_ShouldReturnFalse() {
        val day04Object = day04()
        assertFalse(day04Object.puzzle2("abcde xyz ecdab"))
    }

    @Test
    fun puzzle2_List3_ShouldReturnTrue() {
        val day04Object = day04()
        assertTrue(day04Object.puzzle2("a ab abc abd abf abj"))
    }

    @Test
    fun puzzle2_List4_ShouldReturnTrue() {
        val day04Object = day04()
        assertTrue(day04Object.puzzle2("iiii oiii ooii oooi oooo"))
    }

    @Test
    fun puzzle2_List5_ShouldReturnFalse() {
        val day04Object = day04()
        assertFalse(day04Object.puzzle2("oiii ioii iioi iiio"))
    }
}