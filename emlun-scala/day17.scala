object Day17 extends App {

  val input = 344

  def iterate(stepsize: Int)(buffer: Vector[Int], next: Int): Vector[Int] = {
    val currentPos = buffer.indexOf(next - 1)
    val pos = (currentPos + stepsize) % next match {
      // case 0 => next
      case i => i
    }
    println(s"next: ${next}\tpos: ${pos}")
    buffer.splitAt(pos + 1) match {
      case (front, back) => (front :+ next) ++ back
    }
  }

  def solveA(input: Int) = {
    val finalBuffer = (1 to 2017).foldLeft(Vector(0))(iterate(input))
    println(finalBuffer(1))
    finalBuffer((finalBuffer.indexOf(2017) + 1) % finalBuffer.length)
  }

  def nextPos(stepsize: Int)(currentPos: Int, iteration: Int): Int = {
    val pos = ((currentPos + stepsize) % iteration) + 1
    // println(s"iteration: ${iteration}\tpos: ${pos}")
    if (pos == 1) {
      println(iteration)
    }
    pos
  }

  def solveB(input: Int) = {
    (1 to 50000000).foldLeft(0)(nextPos(input))
  }

  println(s"Example:\n${(1 to 10).scanLeft(Vector(0))(iterate(3)) mkString "\n"}")
  // println(s"A: ${solveA(3)}")
  println(s"A: ${solveA(input)}")
  println(s"B: ${solveB(input)}")
}
