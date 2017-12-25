object Day21 extends App {

  case class Image(pixels: Vector[Vector[Boolean]]) {
    def flip: List[Image] =
      List(
        Image(pixels.reverse),
        Image(pixels map { _.reverse })
      )

    def rotate: Image = Image(pixels.transpose map { _.reverse })

    def equivalent: Set[Image] = (
      Set(
          this,
          this.rotate,
          this.rotate.rotate,
          this.rotate.rotate.rotate
      )
        ++ this.flip.toSet
        ++ this.flip.map(_.rotate).toSet
    )

    def mergeh(other: Image): Image =
      Image(pixels
        .zip(other.pixels)
        .map { case (a, b) => a ++ b }
      )

    def mergev(other: Image): Image =
      Image(pixels ++ other.pixels)

    def splitv: Iterator[Image] = {
      val splitSize: Int =
        if (pixels.size % 2 == 0) 2
        else 3

      pixels
        .grouped(splitSize)
        .map(Image)
    }

    def splith: List[Image] = {
      val splitSize: Int =
        if (pixels.head.size % 2 == 0) 2
        else 3

      pixels
        .map { _.grouped(splitSize).toList }
        .transpose
        .map(Image)
        .toList
    }

    def split: Iterator[Image] = splitv flatMap { _.splith }

    def numOn: Int = pixels.flatten.count(_ == true)

    override def toString: String = "\n" + (pixels map { row =>
      row map { if (_) '.' else '#' } mkString ""
    } mkString "\n")
  }

  case class Rule(input: Set[Image], output: Image) {
    def this(input: Image, output: Image) = this(input.equivalent, output)
  }

  def parseImage(encoded: String): Image = Image(
    encoded
      .split("/")
      .map { row => row.toVector map {
        case '.' => false
        case '#' => true
      } }
      .toVector
  )

  def parseRule(line: String): Rule = line.split(" => ") match {
    case Array(i, o) => new Rule(parseImage(i), parseImage(o))
  }

  def merge(images: Seq[Image]): Image = {
    val rowLength = Math.sqrt(images.size).round.toInt

    images
      .grouped(rowLength)
      .map { row: Seq[Image] =>
        row.reduceLeft[Image]({ case (a, b) => a mergeh b })
      }
      .reduceLeft[Image]({ case (a, b) => a mergev b })
  }

  def step(update: Image => Image)(image: Image): Image =
    merge(
      image
        .split
        .map(update)
        .toSeq
    )

  def memoize[I, O](f: I => O): I => O = new scala.collection.mutable.HashMap[I, O]() {
    override def apply(key: I) = getOrElseUpdate(key, f(key))
  }

  def updater(rules: List[Rule]): Image => Image =
    memoize { image =>
      rules.find({ _.input contains image }).get.output
    }

  val start: Image = parseImage(".#./..#/###")
  val rules: List[Rule] = (io.Source.stdin.getLines() map parseRule).toList

  def solveA(rules: List[Rule]): Int = Iterator.iterate(start)(step(updater(rules))).drop(5).next().numOn
  def solveB(rules: List[Rule]): Int = Iterator.iterate(start)(step(updater(rules))).drop(18).next().numOn

  println(s"A: ${solveA(rules)}")
  println(s"B: ${solveB(rules)}")
}
