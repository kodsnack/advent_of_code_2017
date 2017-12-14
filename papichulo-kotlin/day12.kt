class day12 {
    fun puzzle1(input: String): Int {
        val pipeMap = inputToPipeMap(input)
        val group = mutableListOf<Int>()
        addToList(0, pipeMap, group)
        return group.toSet().size
    }

    private fun inputToPipeMap(input: String): HashMap<Int, List<Int>> {
        val pipeMap = hashMapOf<Int, List<Int>>()
        for (line in input.lines()) {
            val keyValue = line.split(" <->")
            val values = keyValue[1].split(",").map { it.trim().toInt() }
            pipeMap.put(keyValue[0].toInt(), values)
        }
        return pipeMap
    }

    fun addToList(start: Int, pipeMap: HashMap<Int, List<Int>>, group: MutableList<Int>) {
        val values = pipeMap.remove(start)
        if (values != null && values.isNotEmpty()) {
            group.add(start)
            for (newStart in values) {
                if (!group.contains(newStart)) {
                    addToList(newStart, pipeMap, group)
                }
            }
        }
    }

    fun puzzle2(input: String): Int {
        val pipeMap = inputToPipeMap(input)
        var noGroups = 0
        while (pipeMap.isNotEmpty()) {
            val start = pipeMap.keys.stream().findFirst()
            if (start.isPresent) {
                val group = mutableListOf<Int>()
                addToList(start.get(), pipeMap, group)
                if (group.isNotEmpty()) {
                    noGroups++
                }
            }
        }
        return noGroups
    }
}