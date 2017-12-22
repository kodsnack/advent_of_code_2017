import scala.language.implicitConversions

object Day22 extends App {

  implicit def v2ToV2Ops(a: V2) = new V2Ops(a)
  class V2Ops(a: V2) {
    def +(b: V2) = (a, b) match {
      case ((aa, ab), (ba, bb)) => (aa + ba, ab + bb)
    }
    def unary_- : V2 = a match {
      case (aa, bb) => (-aa, -bb)
    }
    def manhattan: Int = a match {
      case (a, b) => Math.abs(a) + Math.abs(b)
    }
    def turnLeft: V2 = a match { case (x, y) => (y, -x) }
    def turnRight: V2 = a match { case (x, y) => (-y, x) }
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

  def burstA(state: State): State = state match {
    case State(infections, pos, dir, infectionsMade) => {
      val nextDir: V2 = infections.get(pos) match {
        case Some(Clean) | None => dir.turnLeft
        case Some(Infected)  => dir.turnRight
        case _ => ???
      }

      val nextStatus: Status = infections.get(pos) match {
        case None           => Infected
        case Some(Clean)    => Infected
        case Some(Infected) => Clean
        case _ => ???
      }

      val nextInfections: Map[V2, Status] = infections.updated(pos, nextStatus)

      val nextPos = pos + nextDir

      State(nextInfections, nextPos, nextDir, infectionsMade + (if (nextStatus == Infected) 1 else 0))
    }
  }

  def burstB(state: State): State = state match {
    case State(infections, pos, dir, infectionsMade) => {
      val nextDir: V2 = infections.get(pos) match {
        case Some(Clean) | None => dir.turnLeft
        case Some(Weakened)     => dir
        case Some(Infected)     => dir.turnRight
        case Some(Flagged)      => -dir
      }

      val nextStatus: Status = infections.getOrElse(pos, Clean).next

      val nextInfections: Map[V2, Status] = infections.updated(pos, nextStatus)

      val nextPos = pos + nextDir

      State(nextInfections, nextPos, nextDir, infectionsMade + (if (nextStatus == Infected) 1 else 0))
    }
  }

  sealed trait Status { def next: Status }
  case object Clean extends Status { override def next = Weakened }
  case object Weakened extends Status { override def next = Infected }
  case object Infected extends Status { override def next = Flagged }
  case object Flagged extends Status { override def next = Clean }

  case class State(infections: Map[V2, Status], pos: V2, dir: V2, infectionsMade: Int) {
    override def toString: String = {
      val maxx = Math.max(infections.keySet.map({ _._1 }).max, pos._1)
      val minx = Math.min(infections.keySet.map({ _._1 }).min, pos._1)
      val maxy = Math.max(infections.keySet.map({ _._2 }).max, pos._2)
      val miny = Math.min(infections.keySet.map({ _._2 }).min, pos._2)

      val lines =
        (miny to maxy) map { y =>
          ((minx to maxx) map { x =>
            val middle = infections.get((x, y)) match {
              case Some(Infected) => '#'
              case Some(Weakened) => 'W'
              case Some(Flagged)  => 'F'
              case Some(Clean)    => '.'
              case None           => '.'
            }
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
    // println(input mkString "\n")

    val startPos: V2 = (w / 2, h / 2)
    val startDir: V2 = (0, -1)

    val states = Iterator.iterate(State(map.map({ k => (k -> Infected) }).toMap, startPos, startDir, 0))(burstA).take(10001).toList
    // println(states mkString "\n\n")
    states.last.infectionsMade
  }

  def solveB(input: Set[V2], h: Int, w: Int) = {
    // println(input mkString "\n")

    val startPos: V2 = (w / 2, h / 2)
    val startDir: V2 = (0, -1)

    // val state = Iterator.iterate(State(map.map({ k => (k -> Infected) }).toMap, startPos, startDir, 0))(burstB).drop(1).take(10000000).next()
    val state = Iterator.iterate(State(map.map({ k => (k -> Infected) }).toMap, startPos, startDir, 0))(burstB).drop(10000000).next()
    // println(states mkString "\n\n")
    state.infectionsMade
  }

  val (map: Set[V2], h: Int, w: Int) = parseMap(io.Source.stdin.getLines())

  println(s"A: ${solveA(map, h, w)}")
  println(s"B: ${solveB(map, h, w)}")
}
