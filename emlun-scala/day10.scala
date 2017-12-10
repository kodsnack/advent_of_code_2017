object Main extends App {

  val nums = (for {
    line <- io.Source.stdin.getLines
    num <- line.trim.split(",")
  } yield num.toInt).toList

  def process(lengths: List[Int], numbers: List[Int] = (0 to 255).toList, pos: Int = 0, skip: Int = 0): List[Int] = lengths match {
    case Nil => {
      println(numbers)
      numbers
    }
    case length :: restLengths => {
      println(numbers, length, pos, skip)
      val op1 = (numbers ++ numbers).splitAt(pos) match {
        case (newHead, back) => back.splitAt(length) match {
          case (front, newTail) => {
            println(s"newHead: ${newHead}")
            println(s"back: ${back}")
            println(s"front: ${front}")
            println(s"newTail: ${newTail}")

            val wrapLength =
              if (pos + length >= numbers.size)
                (pos + length) % numbers.size
              else 0

            val selection = front.reverse

            (selection.drop(length - wrapLength).take(wrapLength)
              ++ newHead.drop(wrapLength)
              ++ selection.take(length - wrapLength)
              ++ newTail
              ) take numbers.size
          }
        }
      }

      val nextPos = (pos + length + skip) % numbers.size
      val nextSkip = skip + 1

      println()

      process(restLengths, op1, nextPos, nextSkip)
    }
  }

  def solveA(lengths: List[Int]): Int = process(lengths) match {
    case a :: b :: tail => a * b
  }

  println(s"A: ${solveA(nums)}")
}
