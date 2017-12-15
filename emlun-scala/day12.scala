object Day12 extends App {

  val groups: List[Set[Int]] = (for {
    line <- io.Source.stdin.getLines()
    group = parseGroup(line.trim)
  } yield group).toList

  def parseGroup(line: String) = line.split(" <-> ") match {
    case Array(a, rest) => Set(a.toInt) ++ rest.split(",").map(_.trim.toInt).toSet
  }

  def mergeAll[A](sets: Set[Set[A]]): Set[Set[A]] = sets.foldLeft(Set.empty[Set[A]])(merge) match {
    case s if s.size < sets.size => mergeAll(s)
    case _ => sets
  }

  def merge[A](sets: Set[Set[A]], next: Set[A]): Set[Set[A]] =
    sets
      .find(_.intersect(next).isEmpty == false)
      .map({ s =>
        (sets - s) + (s ++ next)
      })
      .getOrElse(sets + next)

  def solveA(groups: List[Set[Int]]) =
    mergeAll(groups.toSet)
      .find(_ contains 0)
      .get
      .size

  def solveB(groups: List[Set[Int]]) =
    mergeAll(groups.toSet)
      .size

  println(s"A: ${solveA(groups)}")
  println(s"B: ${solveB(groups)}")
}
