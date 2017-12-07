object Main extends App {
  val basePattern = raw"(\S+) \((\d+)\)(.*)".r

  case class Program(name: String, weight: Int, supports: Set[String]) {
    def supportedWeights(allPrograms: Map[String, Program]): List[Int] =
      supports.toList.map { name => allPrograms(name).totalWeight(allPrograms) }

    def totalWeight(allPrograms: Map[String, Program]): Int =
      weight + supportedWeights(allPrograms).sum

    def isBalanced(allPrograms: Map[String, Program]): Boolean = {
      val sw = supportedWeights(allPrograms)
      println(s"isBalanced ${this} ${sw}")
      sw.toSet.size == 1
    }

    def allChildrenBalanced(allPrograms: Map[String, Program]): Boolean =
      supports
        .map(allPrograms)
        .forall(_.isBalanced(allPrograms))
  }

  val allPrograms: Map[String, Program] = (for {
    line <- io.Source.stdin.getLines
    if !line.trim.isEmpty
    program = {
      println(line.trim)
      line.trim match {
      case basePattern(name, weight, rest) => Program(name, weight.toInt, supported(rest))
    }}
  } yield (program.name, program)).toMap

  def supported(rest: String): Set[String] =
    rest
      .stripPrefix(" -> ")
      .split(',')
      .map(_.trim)
      .filter(!_.isEmpty)
      .toSet

  val allSupported: Set[String] = allPrograms.values.flatMap(_.supports).toSet
  val root = allPrograms.values.find({ p => !(allSupported contains p.name) }).get

  def solveB(root: Program, allPrograms: Map[String, Program]): Option[Int] = {
    println(s"solveB ${root}")
    println(s"weights ${root.supportedWeights(allPrograms)}")
    println(s"allChildrenBalanced ${root.allChildrenBalanced(allPrograms)}")
    println(s"children Balanced: ${root.supports.toList.map(allPrograms).map(_.isBalanced(allPrograms))}")

    if (root.isBalanced(allPrograms))
      None
    else if (root.allChildrenBalanced(allPrograms)) {
      println(s"Unbalanced: ${root}")
      println(s"Unbalanced weights: ${root.supportedWeights(allPrograms)}")

      val supports = root.supports.map(allPrograms)
      val supportedWeights = root.supportedWeights(allPrograms)

      val (goodWeights, badWeights) = supportedWeights.partition({ w => supportedWeights.count(_ == w) > 1 })
      println(s"good weights: ${goodWeights}")
      println(s"bad weights: ${badWeights}")
      val goodWeight = goodWeights.head
      val badWeight = badWeights.head

      val badProgram = supports.find({ _.totalWeight(allPrograms) == badWeight }).get

      println(supportedWeights)

      println(goodWeight - badProgram.supportedWeights(allPrograms).sum)
      Some(goodWeight - badProgram.supportedWeights(allPrograms).sum)
    }
    else
      root
        .supports
        .map(allPrograms)
        .flatMap(solveB(_, allPrograms))
        .headOption
  }

  println(s"A: ${root.name}")

  println(allPrograms)

  println(s"B: ${solveB(root, allPrograms)}")
}
