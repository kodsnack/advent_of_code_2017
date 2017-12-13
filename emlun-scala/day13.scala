object Main extends App {

  case class Layer(depth: Int, range: Int) {
    def scannerPos(t: Int): Int = t % (range * 2 - 2) match {
      case i if i < range => i
      case i              => range * 2 - 2 - i
    }
    def severity: Int = depth * range
    def toString(t: Int): String = s"${depth} ${(0 until range).map({ r => if (scannerPos(t) == r) "[S]" else "[ ]" }).mkString(" ")}"
  }
  case class State(layers: List[Layer], t: Int) {
    def next: State = copy(t = t + 1)
    override def toString: String = layers map { _.toString(t) } mkString "\n"

    def severity: Int =
      (catchingLayer
        map { _.severity }
        getOrElse 0
      )

    def catchingLayer: Option[Layer] = layers.find { l => l.depth == t && l.scannerPos(t) == 0 }
  }

  def length(layers: List[Layer]): Int =
    layers
      .map { _.depth }
      .max

  val layers: List[Layer] = (for {
    line <- io.Source.stdin.getLines()
    Array(depth, range) = line.split(":").map(_.trim.toInt)
  } yield Layer(depth, range)).toList

  def solveA(layers: List[Layer]): Int =
    (for {
      t <- 0 to length(layers)
      state = State(layers, t)
    } yield state.severity).sum

  println(s"A: ${solveA(layers)}")
}
