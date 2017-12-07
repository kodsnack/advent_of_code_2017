object Main extends App {
  val basePattern = raw"(\S+) \((\d+)\)(.*)".r

  val programs: Set[(String, Int, Set[String])] = (for {
    line <- io.Source.stdin.getLines
    if !line.trim.isEmpty
    program = {
      println(line.trim)
      line.trim match {
      case basePattern(name, weight, rest) => (name, weight.toInt, supported(rest))
    }}
  } yield program).toSet

  def supported(rest: String): Set[String] =
    rest
      .stripPrefix(" -> ")
      .split(',')
      .map(_.trim)
      .toSet

  val allSupported = programs flatMap (_._3)
  println(programs find { case (p, _, _) => !(allSupported contains p) })

  // println(s"A: ${a}")
  // println(s"B: ${b}")
}
