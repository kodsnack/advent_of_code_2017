class day02 {
    fun puzzle1(input: String): Int {
        return input.lines()
                .map { it.split("\t").map { c -> c.toInt() } }
                .sumBy { it.max()!! - it.min()!! }
    }

    fun puzzle2(input: String): Int {
        return input.lines()
                .map { it.split("\t").map { c -> c.toInt() } }
                .sumBy { getSumOfEvenlyDivisible(it) }
    }

    private fun getSumOfEvenlyDivisible(input: List<Int>): Int {
        input.forEach { item -> input
                    .filter { item != it && item % it == 0 }
                    .forEach { return item / it }
        }
        return 0
    }
}
