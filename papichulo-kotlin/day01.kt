class day01() {
    fun puzzle1(input: String): Int {
        val argsStringAsChars = input.chunked(1)
        var sum = 0
        for ((index, value) in argsStringAsChars.withIndex()) {
            val compareIndex = if (index < argsStringAsChars.size - 1) index + 1 else 0
            if (value == argsStringAsChars[compareIndex]) {
                sum += value.toInt()
            }
        }
        return sum
    }

    fun puzzle2(input: String): Int {
        val argsStringAsChars = input.chunked(1)
        var sum = 0
        for ((index, value) in argsStringAsChars.withIndex()) {
            val compareIndex = (index + (argsStringAsChars.size / 2)) % argsStringAsChars.size
            if (value == argsStringAsChars[compareIndex]) {
                sum += value.toInt()
            }
        }
        return sum
    }
}