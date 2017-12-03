import org.junit.jupiter.api.Assertions

internal class day02Test {
    @org.junit.jupiter.api.Test
    fun puzzle1_TestInput_ShouldReturn18() {
        val day02Object = day02()
        Assertions.assertEquals(18, day02Object.puzzle1("5\t1\t9\t5\n" +
                "7\t5\t3\n" +
                "2\t4\t6\t8"))
    }

    @org.junit.jupiter.api.Test
    fun puzzle2_TestInput_ShouldReturn9() {
        val day02Object = day02()
        Assertions.assertEquals(9, day02Object.puzzle2("5\t9\t2\t8\n" +
                "9\t4\t7\t3\n" +
                "3\t8\t6\t5"))
    }
}
