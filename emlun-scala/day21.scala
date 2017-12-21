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
      Image(pixels.zip(other.pixels) map { case (a, b) => a ++ b })

    def mergev(other: Image): Image =
      Image(pixels ++ other.pixels)

    def splitv: List[Image] = {
      val splitSize: Int =
        if (pixels.size % 2 == 0) 2
        else 3

      pixels
        .sliding(splitSize, splitSize)
        .map(Image)
        .toList
    }

    def splith: List[Image] = {
      val splitSize: Int =
        if (pixels.head.size % 2 == 0) 2
        else 3

      pixels
        .map { _.sliding(splitSize, splitSize).toList }
        .transpose
        .map(Image)
        .toList
    }

    def split: List[Image] = splitv flatMap { _.splith }

    def numOn: Int = pixels.flatten.count(_ == true)

    override def toString: String = "\n" + (pixels map { row =>
      row map {
        case false => '.'
        case true => '#'
      } mkString ""
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

  def merge(images: List[Image]): Image = images match {
    case List(single) => single
    case _ => {
      val rowLength = Math.sqrt(images.size).round.toInt
      print(s"images length: ${images.size}, rowLength: ${rowLength}")

      images
        .sliding(images.size / rowLength, rowLength)
        .map { row: List[Image] =>
          row.reduceLeft[Image]({ case (a, b) => a mergeh b })
        }
        .reduceLeft[Image]({ case (a, b) => a mergev b })
    }
  }


  def step(rules: List[Rule])(image: Image): Image = {
    println()
    println(s"step ${image}")
    println(s"split: ${image.split}")
    println(s"replaced: ${image.split
      .map({ part =>
        rules.find({ _.input contains part }).get.output
      }).length}")
    val result = merge(image
      .split
      .map { part =>
        rules.find({ _.input contains part }).get.output
      }
    )

    println(s"merged: ${result}")
    result
  }

  val start: Image = parseImage(".#./..#/###")

  val rules: List[Rule] = (io.Source.stdin.getLines() map parseRule).toList

  // println(rules mkString "\n")
  // println()
  // println(start.split)
  // println(parseImage("#..#/..../..../#..#").split)
  // println(merge(start.split))
  // println(merge(parseImage("#..#/..../..../#..#").split))
  // println(step(rules)(start))
  // println(rules.head.flip mkString "\n")
  // println(rules.head.rotate)
  // println(rules.head.rotate.rotate)
  // println(rules.head.rotate.rotate.rotate)
  //
  def solveA(rules: List[Rule]) = {
    Iterator.iterate(start)(step(rules)).drop(5).next().numOn
  }

  println(s"A: ${solveA(rules)}")
  // println(s"B: ${solveB(particles)}")
}
