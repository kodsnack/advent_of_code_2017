object Day17 extends App {

  val input: Int = io.Source.stdin.getLines().next().trim.toInt

  def iterate(stepsize: Int)(buffer: Vector[Int], next: Int): Vector[Int] = {
    val currentPos = buffer.indexOf(next - 1)
    val pos = (currentPos + stepsize) % next
    buffer.splitAt(pos + 1) match {
      case (front, back) => (front :+ next) ++ back
    }
  }

  def solveA(stepsize: Int) = {
    val finalBuffer = (1 to 2017).foldLeft(Vector(0))(iterate(stepsize))
    finalBuffer((finalBuffer.indexOf(2017) + 1) % finalBuffer.length)
  }

  def solveB(iterations: Int, stepsize: Int, remembered: Int, currentPos: Int, iteration: Int): Int =
    if (iteration > iterations)
      remembered
    else {
      val pos = ((currentPos + stepsize) % iteration) + 1
      solveB(iterations, stepsize, if (pos == 1) iteration else remembered, pos, iteration + 1)
    }
  def solveB(stepsize: Int): Int = solveB(50000000, stepsize, 0, 0, 1)

  println(s"A: ${solveA(input)}")
  println(s"B: ${solveB(input)}")
}
