class day03_1 {
    var value = 1
    var values = HashMap<Int, Point>()
    var x = 0
    var y = 0

    fun puzzle1(input: String): Int {
        val inputNumber = input.toInt()
        addCurrent()
        var sideLength = 1
        while (sideLength * sideLength < inputNumber) {
            sideLength += 2
            addPositionsForRing(sideLength)
        }
        return Math.abs(values.get(inputNumber)!!.x) + Math.abs(values.get(inputNumber)!!.y)
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
        values.set(value, Point(x, y))
        value++
    }

    data class Point(val x: Int, val y: Int)

}