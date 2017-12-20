import scala.language.implicitConversions

object Day20 extends App {

  implicit def v3ToV3Ops(a: V3) = new V3Ops(a)
  class V3Ops(a: V3) {
    def +(b: V3) = (a, b) match {
      case ((aa, ab, ac), (ba, bb, bc)) => (aa + ba, ab + bb, ac + bc)
    }
    def unary_-(): V3 = a match {
      case (aa, ab, ac) => (-aa, -ab, -ac)
    }
    def manhattan: Int = a match {
      case (a, b, c) => Math.abs(a) + Math.abs(b) + Math.abs(c)
    }
    def signa: V3 = a match {
      case (a, b, c) => (a.signum, b.signum, c.signum)
    }
  }

  type V3 = (Int, Int, Int)
  case class Particle(id: Int, p: V3, v: V3, a: V3) {
    def step: Particle =
      copy(v = v + a, p = p + (v + a))
    def willTurn: Boolean = v.signa == a.signa
  }

  val particlePattern = raw"p=<(-?\d+),(-?\d+),(-?\d+)>, v=<(-?\d+),(-?\d+),(-?\d+)>, a=<(-?\d+),(-?\d+),(-?\d+)>".r

  val particles: List[Particle] = (
    io.Source.stdin.getLines()
      .filter { _.isEmpty == false }
      .zipWithIndex
      .map { case (line, id) =>
        line.trim match {
          case particlePattern(px, py, pz, vx, vy, vz, ax, ay, az) =>
            Particle(
              id = id,
              p = (px.toInt, py.toInt, pz.toInt),
              v = (vx.toInt, vy.toInt, vz.toInt),
              a = (ax.toInt, ay.toInt, az.toInt),
            )
        }
      }
  ).toList

  def step(particles: List[Particle]): List[Particle] =
    particles map { _.step }

  def findClosest(particles: List[Particle]): Particle = {
    particles
      .minBy { particle => particle.a.manhattan }
  }

  def solveA(particles: List[Particle]) = {
    // val states = Iterator.iterate(particles)(step)
    // (states map findClosest).take(10).toList
    findClosest(particles)
  }

  println(s"A: ${solveA(particles).id}")
  // println(s"B: ${b}")
}
