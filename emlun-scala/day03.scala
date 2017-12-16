object Day03 extends App {
  val input = io.Source.stdin.getLines.toSeq.head.trim.toInt

  def btmRight(level: Int): Int = 1 + 4 * (level * (level + 1))

  /** Solve `i <= btmRight(l)` for `l` using the quadratic roots formula */
  def findLevel(i: Int): Int = Math.ceil(0.5 * (Math.sqrt(i) - 1)).toInt

  def dist(i: Int) = {
    val level = findLevel(i)
    val indexInCircle = i - btmRight(Math.max(0, level - 1)) - level
    val modulus = Math.max(1, 2 * level)

    level + Math.abs(indexInCircle % modulus)
  }

  def shell(prev: Seq[Int]): Seq[Int] = {
    val level: Int = prev.length / 8 + 1

    if (level < 2)
      List(1, 2, 4, 5, 10, 11, 23, 25)
    else {
      val length = prev.length + 8
      val m = 2 * level - 1

      def value(i: Int): Int = i match {
        case 0                       =>                prev.last   + prev(i)
        case 1                       => prev.last    + prev(i - 1) + prev(i)     + value(i - 1)
        case i if i < m-1            => prev(i - 2)  + prev(i - 1) + prev(i)     + value(i - 1)
        case i if i == m-1           => prev(i - 2)  + prev(i - 1)               + value(i - 1)
        case i if i == m             => prev(i - 2)                              + value(i - 1)
        case i if i == m+1           => value(i - 2) + prev(i - 3) + prev(i - 2) + value(i - 1)

        case i if i < m+m            => prev(i - 4)  + prev(i - 3) + prev(i - 2) + value(i - 1)
        case i if i == m+m           => prev(i - 4)  + prev(i - 3)               + value(i - 1)
        case i if i == m+m+1         => prev(i - 4)                              + value(i - 1)
        case i if i == m+m+1+1       => value(i - 2) + prev(i - 5) + prev(i - 4) + value(i - 1)

        case i if i < m+m+1+m        => prev(i - 6)  + prev(i - 5) + prev(i - 4) + value(i - 1)
        case i if i == m+m+1+m       => prev(i - 6)  + prev(i - 5)               + value(i - 1)
        case i if i == m+m+1+m+1     => prev(i - 6)                              + value(i - 1)
        case i if i == m+m+1+m+1+1   => value(i - 2) + prev(i - 7) + prev(i - 6) + value(i - 1)

        case i if i < m+m+1+m+1+m    => prev(i - 8)  + prev(i - 7) + prev(i - 6) + value(i - 1)
        case i if i == m+m+1+m+1+m   => prev(i - 8)  + prev(i - 7) + value(0)    + value(i - 1)
        case i if i == m+m+1+m+1+m+1 => prev(i - 8)  + value(0)                  + value(i - 1)
      }

      (0 until length) map value
    }
  }

  def solveB(input: Int): Int =
    Iterator.iterate(Seq(1))(shell)
      .flatten
      .find(_ > input)
      .get

  println(s"A: ${dist(input)}")
  println(s"B: ${solveB(input)}")
}
