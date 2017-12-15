object Day15 extends App {

  val (startA: Long, startB: Long) =
    (
      io.Source.stdin.getLines().map({ line =>
        line.trim.split(" ") match {
          case Array("Generator", name, "starts", "with", start) => start.toLong
        }
      }).toList
    ) match {
      case List(a, b) => (a, b)
    }

  val factorA = 16807
  val factorB = 48271

  val filterA = 4
  val filterB = 8

  def step(factor: Long, filterMultiplier: Long)(prev: Long): Long = {
    val v = (prev * factor) % 2147483647l
    if (v % filterMultiplier == 0)
      v
    else
      step(factor, filterMultiplier)(v)
  }

  def solve(startA: Long, startB: Long, filterA: Long, filterB: Long, sample: Int): Long = {
    val streamA = Iterator.iterate(startA)(step(factorA, filterA))
    val streamB = Iterator.iterate(startB)(step(factorB, filterB))
    (streamA zip streamB
      drop 1
      take sample
      count {
        case (a, b) => (a % 65536) == (b % 65536)
      }
    )
  }

  def solveA(startA: Long, startB: Long): Long = solve(startA, startB, 1, 1, 40000000)
  def solveB(startA: Long, startB: Long): Long = solve(startA, startB, filterA, filterB, 5000000)

  println(s"A: ${solveA(startA, startB)}")
  println(s"B: ${solveB(startA, startB)}")
}
