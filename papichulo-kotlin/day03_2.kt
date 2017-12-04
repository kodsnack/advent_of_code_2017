class day03_2 {
    var value = 1
    var values = HashMap<String, Int>()
    var x = 0
    var y = 0
    var max = 0
    var winner = 0

    fun puzzle2(input: String): Int {
        val inputNumber = input.toInt()
        addCurrent()
        var sideLength = 1
        max = inputNumber
        values.set("$x,$y", 1)
        while (sideLength * sideLength < inputNumber) {
            sideLength += 2
            addPositionsForRing(sideLength)
        }
        return winner
    }

    fun addPositionsForRing(sideLength: Int) {
        x++
        addRightSide(sideLength)
        addTopSide(sideLength)
        addLeftSide(sideLength)
        addBottomSide(sideLength)
    }

    fun addRightSide(sideLength: Int) {
        for (i in 0 until sideLength - 1) {
            addCurrent()
            y++
        }
        y--
    }

    fun addTopSide(sideLength: Int) {
        for (i in 0 until sideLength - 1) {
            x--
            addCurrent()
        }
    }

    fun addLeftSide(sideLength: Int) {
        for (i in 0 until sideLength - 1) {
            y--
            addCurrent()
        }
    }

    fun addBottomSide(sideLength: Int) {
        for (i in 0 until sideLength - 1) {
            x++
            addCurrent()
        }
    }

    fun addCurrent() {
        val value = getSumOfAdjecent()
        values.set("$x,$y", value)
        if(winner == 0 && value > max) {
            winner = value
        }
    }

    fun getSumOfAdjecent():Int {
        var sum = 0
        for(col in -1 until 2) {
            for(row in -1 until 2) {
                val isCenter = col == 0 && row == 0
                if (!isCenter) {
                    val key = "${x + col},${y + row}"
                    if (values.get(key) != null) {
                        sum += values.get(key)!!
                    }
                }
            }
        }
        return sum
    }
}