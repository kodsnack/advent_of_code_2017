class day06 {
    fun puzzle1(input: String): Int {
        val memoryList = input.split("\t").map { it.toInt() }.toMutableList()
        val initialState: List<Int> = memoryList.toList()
        val previousStates: MutableList<List<Int>> = MutableList(1,{initialState})
        var steps = 0
        while (true) {
            var position = memoryList.indexOf(memoryList.max())
            var value = memoryList[position]
            memoryList[position] = 0
            while (value > 0) {
                position++
                if (position == memoryList.size) position = 0
                memoryList[position] = memoryList[position] + 1
                value--
            }
            steps++
            val state: List<Int> = memoryList.toList()
            if (previousStates.contains(state)) {
                break
            }
            previousStates.add(state)
        }
        return steps
    }

    fun puzzle2(input: String): Int {
        val memoryList = input.split("\t").map { it.toInt() }.toMutableList()
        val initialState: List<Int> = memoryList.toList()
        val previousStates: MutableList<List<Int>> = MutableList(1,{initialState})
        var steps = 0
        while (true) {
            var position = memoryList.indexOf(memoryList.max())
            var value = memoryList[position]
            memoryList[position] = 0
            while (value > 0) {
                position++
                if (position == memoryList.size) position = 0
                memoryList[position] = memoryList[position] + 1
                value--
            }
            steps++
            val state: List<Int> = memoryList.toList()
            if (previousStates.contains(state)) {
                return steps - previousStates.indexOf(state)
            }
            previousStates.add(state)
        }
    }
}