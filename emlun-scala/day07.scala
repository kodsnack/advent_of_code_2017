object Day07 extends App {
  val basePattern = raw"(\S+) \((\d+)\)(.*)".r

  case class RawProgram(name: String, weight: Int, children: Set[String])
  case class Program(name: String, weight: Int, children: Set[Program]) {
    lazy val childWeights: List[Int] = children.toList.map { _.totalWeight }
    lazy val totalWeight: Int = weight + childWeights.sum
    def isBalanced: Boolean = childWeights.toSet.size == 1
    def allChildrenBalanced: Boolean = children.forall { _.isBalanced }
  }

  def buildTree(root: RawProgram, allPrograms: Map[String, RawProgram]): Program =
    Program(
      name = root.name,
      weight = root.weight,
      children = root.children.map { child => buildTree(allPrograms(child), allPrograms) }
    )

  def parseChildren(rest: String): Set[String] =
    rest
      .stripPrefix(" -> ")
      .split(',')
      .map(_.trim)
      .filter(!_.isEmpty)
      .toSet

  def solveA(allPrograms: Set[RawProgram]): RawProgram = {
    val allDescendants: Set[String] = allPrograms.flatMap(_.children).toSet
    allPrograms.find({ p => !(allDescendants contains p.name) }).get
  }

  def solveB(root: Program): Option[Int] = {
    if (root.isBalanced)
      None
    else if (root.allChildrenBalanced) {
      val children = root.children
      val childWeights = root.childWeights

      val (goodWeights, badWeights) = childWeights.partition({ w => childWeights.count(_ == w) > 1 })
      val goodWeight = goodWeights.head
      val badWeight = badWeights.head

      val badProgram = children.find({ _.totalWeight == badWeight }).get

      Some(goodWeight - badProgram.childWeights.sum)
    }
    else
      root
        .children
        .flatMap(solveB)
        .headOption
  }

  val rawPrograms: Map[String, RawProgram] = (for {
    line <- io.Source.stdin.getLines
    if !line.trim.isEmpty
    program = {
      line.trim match {
      case basePattern(name, weight, rest) => RawProgram(name, weight.toInt, parseChildren(rest))
    }}
  } yield (program.name, program)).toMap

  val root = solveA(rawPrograms.values.toSet)

  println(s"A: ${root.name}")
  println(s"B: ${solveB(buildTree(root, rawPrograms)).get}")
}
