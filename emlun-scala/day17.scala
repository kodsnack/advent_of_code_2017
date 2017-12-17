object Day17 extends App {

  val input = 344

  def iterate(stepsize: Int)(buffer: Vector[Int], next: Int): Vector[Int] = {
    val currentPos = buffer.indexOf(next - 1)
    val pos = (currentPos + stepsize) % next match {
      // case 0 => next
      case i => i
    }
    buffer.splitAt(pos + 1) match {
      case (front, back) => (front :+ next) ++ back
    }
  }

  def solveA(input: Int) = {
    val finalBuffer = (1 to 2017).foldLeft(Vector(0))(iterate(input))
    finalBuffer((finalBuffer.indexOf(2017) + 1) % finalBuffer.length)
  }

  // println(s"Example:\n${solveA(3) mkString "\n"}")
  println(s"A: ${solveA(3)}")
  println(s"A: ${solveA(input)}")
  // println(s"B: ${solveB(moves)}")
}
