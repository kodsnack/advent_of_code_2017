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
    def turnLeft: V2  = a match { case (x, y) => ( y, -x) }
    def turnRight: V2 = a match { case (x, y) => (-y,  x) }
  }
  type V2 = (Int, Int)

  def parseMap(lines: Iterator[String]): (Map[V2, Status], V2) = {
    val linesList = lines.toList
    val h = linesList.length
    val w = linesList.head.length
    val startPos: V2 = (w / 2, h / 2)

    val map = (
      for {
        (line, y) <- linesList.zipWithIndex
        (cell, x) <- line.zipWithIndex
        if cell == '#'
      } yield ((x, y) -> Infected)
    ).toMap

    (map, startPos)
  }

  def updateDir(infections: Map[V2, Status], pos: V2, dir: V2): V2 = infections.getOrElse(pos, Clean) match {
    case Clean    => dir.turnLeft
    case Weakened => dir
    case Infected => dir.turnRight
    case Flagged  => -dir
  }

  def updateStatusA(status: Status): Status = status match {
    case Clean    => Infected
    case Infected => Clean
    case _        => ???
  }
  def updateStatusB(status: Status): Status = status.next

  def burst(updateStatus: Status => Status)(state: State): State = state match {
    case State(infections, pos, dir, infectionsMade) => {
      val nextDir: V2 = updateDir(infections, pos, dir)
      val nextStatus: Status = updateStatus(infections.getOrElse(pos, Clean))
      val nextInfections: Map[V2, Status] = infections.updated(pos, nextStatus)
      val nextPos = pos + nextDir

      State(nextInfections, nextPos, nextDir, infectionsMade + (if (nextStatus == Infected) 1 else 0))
    }
  }

  sealed trait Status                 {          def next: Status    }
  case object Clean    extends Status { override def next = Weakened }
  case object Weakened extends Status { override def next = Infected }
  case object Infected extends Status { override def next = Flagged  }
  case object Flagged  extends Status { override def next = Clean    }

  case class State(infections: Map[V2, Status], pos: V2, dir: V2, infectionsMade: Int)

  def solveA(input: Map[V2, Status], startPos: V2) =
    Iterator.iterate(State(map, startPos, (0, -1), 0))(burst(updateStatusA)).drop(10000).next().infectionsMade

  def solveB(input: Map[V2, Status], startPos: V2) =
    Iterator.iterate(State(map, startPos, (0, -1), 0))(burst(updateStatusB)).drop(10000000).next().infectionsMade

  val (map: Map[V2, Status], startPos: V2) = parseMap(io.Source.stdin.getLines())

  println(s"A: ${solveA(map, startPos)}")
  println(s"B: ${solveB(map, startPos)}")
}
