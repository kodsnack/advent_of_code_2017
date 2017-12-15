object Day13 extends App {

  case class Layer(depth: Int, range: Int) {
    def severity: Int = depth * range
    def period: Int = range * 2 - 2
  }

  case class State(layers: List[Layer], t: Int) {
    def severity(delay: Int): Int =
      (catchingLayer(delay)
        map { _.severity }
        getOrElse 0
      )

    def catchingLayer(delay: Int): Option[Layer] = layers.find { l => l.depth == (t - delay) && t % l.period == 0 }
  }

  def length(layers: List[Layer]): Int = layers.map({ _.depth }).max

  val layers: List[Layer] = (for {
    line <- io.Source.stdin.getLines()
    Array(depth, range) = line.split(":").map(_.trim.toInt)
  } yield Layer(depth, range)).toList

  def solveA(layers: List[Layer]): Int =
    (for {
      t <- 0 to length(layers)
      state = State(layers, t)
    } yield state.severity(0)).sum

  def solveB(layers: List[Layer]) = {
    val positions: Seq[Int] = 0 to length(layers)
    val periods: Vector[Int] = positions.toVector map { i => layers find { _.depth == i } map { _.period } getOrElse -1 }

    def search(delay: Int): Int = {
      val caughtAtTimes: Seq[Boolean] = positions.map({ playerPos =>
        (periods(playerPos) > 0) && (playerPos + delay) % periods(playerPos) == 0
      })

      if (caughtAtTimes forall { _ == false })
        delay
      else
        search(delay + 1)
    }

    search(0)
  }

  println(s"A: ${solveA(layers)}")
  println(s"B: ${solveB(layers)}")
}
