import scala.language.implicitConversions

object Day20 extends App {

  implicit def v3ToV3Ops(a: V3) = new V3Ops(a)
  class V3Ops(a: V3) {
    def +(b: V3) = (a, b) match {
      case ((aa, ab, ac), (ba, bb, bc)) => (aa + ba, ab + bb, ac + bc)
    }
    def manhattan: Int = a match {
      case (a, b, c) => Math.abs(a) + Math.abs(b) + Math.abs(c)
    }
  }

  type V3 = (Int, Int, Int)
  case class Particle(id: Int, p: V3, v: V3, a: V3) {
    def step: Particle = copy(v = v + a, p = p + (v + a))
  }

  val particlePattern = raw"p=<\s*(-?\d+),\s*(-?\d+),\s*(-?\d+)>, v=<\s*(-?\d+),\s*(-?\d+),\s*(-?\d+)>, a=<\s*(-?\d+),\s*(-?\d+),\s*(-?\d+)>".r

  def step(particles: List[Particle]): List[Particle] = particles map { _.step }

  def findClosest(particles: List[Particle]): Particle = particles minBy { _.a.manhattan }

  def removeColliders(particles: List[Particle]): List[Particle] =
    particles
      .groupBy { _.p }
      .filter { case (_, group) => group.size == 1 }
      .flatMap { case (_, group) => group }
      .toList

  def solveA(particles: List[Particle]) =
    findClosest(particles).id

  def solveB(particles: List[Particle]) =
    Iterator.iterate(particles)((step _) andThen removeColliders)
      .drop(10000)
      .next()
      .size

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
      .toList
  )

  println(s"A: ${solveA(particles)}")
  println(s"B: ${solveB(particles)}")
}
