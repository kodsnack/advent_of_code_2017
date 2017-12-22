object Day22 extends App {

  implicit def v2ToV2Ops(a: V2) = new V2Ops(a)
  class V2Ops(a: V2) {
    def +(b: V2) = (a, b) match {
      case ((aa, ab), (ba, bb)) => (aa + ba, ab + bb)
    }
    def manhattan: Int = a match {
      case (a, b) => Math.abs(a) + Math.abs(b)
    }
  }
  type V2 = (Int, Int)

  def parseMap(lines: Iterator[String]): (Set[V2], Int, Int) = {
    val linesList = lines.toList
    val h = linesList.length
    val w = linesList.head.length
    val map = (for {
      (line, y) <- linesList.zipWithIndex
      (cell, x) <- line.zipWithIndex
      if cell == '#'
    } yield (x, y)).toSet
    (map, h, w)
  }

  def burst(state: State): State = state match {
    case State(infections, pos, dir, infectionsMade) => {
      val nextDir: V2 =
        if (infections contains pos)
          dir match { case (x, y) => (-y, x) }
        else
          dir match { case (x, y) => (y, -x) }

      val (nextInfections: Set[V2], didInfect: Boolean) =  (
        if (infections contains pos)
          ((infections - pos), false)
        else
          ((infections + pos), true)
      )

      val nextPos = pos + nextDir

      State(nextInfections, nextPos, nextDir, infectionsMade + (if (didInfect) 1 else 0))
    }
  }

  case class State(infections: Set[V2], pos: V2, dir: V2, infectionsMade: Int) {
    override def toString: String = {
      val maxx = Math.max(infections.map({ _._1 }).max, pos._1)
      val minx = Math.min(infections.map({ _._1 }).min, pos._1)
      val maxy = Math.max(infections.map({ _._2 }).max, pos._2)
      val miny = Math.min(infections.map({ _._2 }).min, pos._2)

      val lines =
        (miny to maxy) map { y =>
          ((minx to maxx) map { x =>
            val middle = if (infections contains (x, y))
                '#'
              else
                '.'
            if ((x, y) == pos)
              s"[${middle}]"
            else
              s" ${middle} "
          }).mkString("").replaceAll("  ", " ").replaceAll(" \\[", "[").replaceAll("] ", "]")
        } mkString "\n"

      lines
    }
  }

  def solveA(input: Set[V2], h: Int, w: Int) = {
    println(input mkString "\n")

    val startPos: V2 = (w / 2, h / 2)
    val startDir: V2 = (0, -1)

    val states = Iterator.iterate(State(map, startPos, startDir, 0))(burst).take(10001).toList
    // println(states mkString "\n\n")
    println(states.last.infectionsMade)
  }
  // def solveB(rules: List[Rule]): Int = Iterator.iterate(start)(step(updater(rules))).drop(18).next().numOn

  val (map: Set[V2], h: Int, w: Int) = parseMap(io.Source.stdin.getLines())

  println(s"A: ${solveA(map, h, w)}")
  // println(s"B: ${solveB(rules)}")
}
