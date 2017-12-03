package day3

object Main {
  def main(args: Array[String]): Unit = {
    print("input: ")
    val input = readLine.toInt
        
    val r = Math.ceil(Math.ceil(Math.sqrt(input)) / 2 - .5) // distance to center from this line (from a number on center of the side)
    val numsPerSide = r * 2 + 1 // numbers on each side
    val min = Math.pow(r * 2 - 1, 2) + 1 // smallest number on this cycle
    val mids = for (i <- 0 to 3) yield min + r - 1 + i * (numsPerSide - 1) // middles of all 4 sides on this cycle
    val p1 = r + mids.map(i => Math.abs(input - i)).min // distance from a middle to center + distance to closest middle
    
    println("part 1: " + p1);
    
    val side = 100
    var vals = Array.fill(side, side)(0)
    var x = side / 2 - 1
    var y = side / 2 - 1
    vals(x)(y) = 1
    
    /*vals.foreach(a => { 
      a.foreach (i => print(i + ", ")) 
      println 
    })*/
    
    val lengths = (for (i <- 1 to side) yield i).flatMap(i => Array(i, i)) // num steps in each direction
    
    for (i <- 0 to lengths.length) {
      var dx = 0
      var dy = 0
      i % 4 match {
        case 0 => dx = 1
        case 1 => dy = -1
        case 2 => dx = -1
        case 3 => dy = 1
      }
      for (j <- 1 to lengths(i)) {
        x += dx
        y += dy
        val ret = setAt(x, y, vals)
        if (ret > input) {
          println("part 2: " + ret)
          return 
        }
      }
    }
  }
  
  def setAt(x: Int, y: Int, vals: Array[Array[Int]]): Int = {
    var sum = 0
    for (_x <- x - 1 to x + 1) {
      for (_y <- y - 1 to y + 1) {
        sum += vals(_x)(_y)
      }
    }
    vals(x)(y) = sum
    /*println("==========================")
    vals.foreach(a => { 
      a.foreach (i => print(i + ", ")) 
      println 
    })*/
    return sum
  }
}