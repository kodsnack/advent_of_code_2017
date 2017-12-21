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

    def splitv: Iterator[Image] = {
      val splitSize: Int =
        if (pixels.size % 2 == 0) 2
        else 3

      pixels
        .sliding(splitSize, splitSize)
        .map(Image)
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

    def split: Iterator[Image] = splitv flatMap { _.splith }

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

  def merge(images: Seq[Image]): Image = images.size match {
    case 1 => images.head
    case _ => {
      val rowLength = Math.sqrt(images.size).round.toInt

      images
        .sliding(images.size / rowLength, rowLength)
        .map { row: Seq[Image] =>
          row.reduceLeft[Image]({ case (a, b) => a mergeh b })
        }
        .reduceLeft[Image]({ case (a, b) => a mergev b })
    }
  }


  def step(rules: List[Rule])(image: Image): Image =
    merge(image
      .split
      .map { part =>
        rules.find({ _.input contains part }).get.output
      }
      .toSeq
    )

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

  def solveB(rules: List[Rule]) = {
    def countFutureOns(image: Image, futureDepth: Int): Int = {
      if (futureDepth == 0)
        image.numOn
      else {
        image.split
          .map(step(rules))
          .map({ countFutureOns(_, futureDepth - 1) })
          .sum
      }
    }

    def countNextOns(image: Image) = (for {
      i <- image.split
      next = step(rules)(i)
    } yield next.numOn).sum

    for { i <- 1 to 18 } {
      println()
      println(Iterator.iterate(start)(step(rules)).drop(i).next())
      println(s"i: ${i}")
      println("On: " + Iterator.iterate(start)(step(rules)).drop(i).next().numOn)
      println("Next on: " + countNextOns(Iterator.iterate(start)(step(rules)).drop(i - 1).next()))
      println("Future on: " + countFutureOns(start, i))

      /*
      println("Nexts:")
      for { im <- Iterator.iterate(start)(step(rules)).drop(i).next().split.map(step(rules)) } {
        println(im)
        println(s"On: ${im.numOn}")
      }
      */
    }
  }

  println(s"A: ${solveA(rules)}")
  println(s"B: ${solveB(rules)}")
}
