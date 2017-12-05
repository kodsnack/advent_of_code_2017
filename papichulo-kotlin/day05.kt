class day05 {
    fun puzzle1(input: String): Int {
        var steps = 0
        var position = 0
        val list = input.lines().map{ it.toInt() }.toMutableList()
        while (position < list.size) {
            val current = list[position]
            val newCurrent = current + 1
            list[position] = newCurrent
            position += current
            steps++
        }
        return steps
    }

    fun puzzle2(input: String): Int {
        var steps = 0
        var position = 0
        val list = input.lines().map{ it.toInt() }.toMutableList()
        while (position < list.size) {
            val current = list[position]
            val newCurrent = if (current >= 3) current - 1 else current + 1
            list[position] = newCurrent
            position += current
            steps++
        }
        return steps
    }
}

