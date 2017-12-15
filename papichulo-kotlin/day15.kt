class day15 {
    fun puzzle1(valueA: Int, valueB: Int, pairs: Int = 40000000): Int {
        var generatorA: Long = valueA.toLong()
        var generatorB: Long = valueB.toLong()
        val factorA = 16807
        val factorB = 48271
        val divisor = 2147483647
        var numberOfMatches = 0
        for (i in 1..pairs) {
            generatorA = calculateNextValue(generatorA, factorA, divisor, 1)
            generatorB = calculateNextValue(generatorB, factorB, divisor, 1)
            if (generatorsMatch(generatorA, generatorB)) {
                numberOfMatches++
            }
        }
        return numberOfMatches
    }

    fun puzzle2(valueA: Int, valueB: Int, pairs: Int = 40000000): Int {
        var generatorA: Long = valueA.toLong()
        var generatorB: Long = valueB.toLong()
        val factorA = 16807
        val factorB = 48271
        val multipleA = 4
        val multipleB = 8
        val divisor = 2147483647
        var numberOfMatches = 0
        for (i in 1..pairs) {
            generatorA = calculateNextValue(generatorA, factorA, divisor, multipleA)
            generatorB = calculateNextValue(generatorB, factorB, divisor, multipleB)
            if (generatorsMatch(generatorA, generatorB)) {
                numberOfMatches++
            }
        }
        return numberOfMatches
    }

    fun generatorsMatch(generatorA: Long, generatorB: Long): Boolean {
        var binaryA = leftPad(java.lang.Long.toBinaryString(generatorA), 16)
        binaryA = binaryA.substring(binaryA.length - 16)
        var binaryB = leftPad(java.lang.Long.toBinaryString(generatorB), 16)
        binaryB = binaryB.substring(binaryB.length - 16)
        return binaryA == binaryB
    }

    fun calculateNextValue(value: Long, factor: Int, divisor: Int, multiple: Int): Long {
        var newValue = value
        while ((newValue * factor % divisor) % multiple != 0L) {
            newValue = newValue * factor % divisor
        }
        return newValue * factor % divisor
    }

    fun leftPad(string: String, len: Int, ch: String = "0"): String {
        var i = -1
        val length = len - string.length
        val builder = StringBuilder()
        while (++i < length) {
            builder.append(ch)
        }
        builder.append(string)
        return builder.toString()
    }
}
