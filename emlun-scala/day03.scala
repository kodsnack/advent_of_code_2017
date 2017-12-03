object Main extends App {

  val input = 265149

  def straightRight(n: Int): Int =
    if (n == 0)
      1
    else
      straightRight(n - 1) + (n-1)*8 + 1

  def btmRight(n: Int): Int = straightRight(n) + n*7

  for { i <- (0 to 25) } {
    println(s"${i} ${straightRight(i)}")
  }
  println(straightRight(1024))

  for { i <- (0 to 25) } {
    println(s"${i} ${btmRight(i)}")
  }
  println(btmRight(1024))

  def dist(i: Int) = {
    val n = ((Stream from 0)
      .find { (m: Int) =>
        i <= btmRight(m)
      }
      .get
    )

    val indexInCircle = i - btmRight(Math.max(0, n - 1)) - n
    val modulus = Math.max(1, 2*n)

    // (n, indexInCircle, modulus, Math.abs(indexInCircle % modulus))
    val d = n + Math.abs(indexInCircle % modulus)
    s"n ${n}, i ${indexInCircle}, m ${modulus}, a ${Math.abs(indexInCircle % modulus)}, d ${d}"
  }

  for { i <- (0 to 30) } {
    println(s"${i} ${dist(i)}")
  }
  println(dist(1024))
  println(dist(input))

  def shell(n: Int): List[Int] = {
    if (n <= 2)
      List(1, 2, 4, 5, 10, 11, 23, 25)
    else {
      val prev = shell(n - 1)
      val length = prev.length + 8

      val m = 2*(n - 1) - 1
      println(s"m ${m}")

      def value(i: Int): Int = i match {
        case 0                         => prev.last + prev.head
        case 1                         => prev.last + prev.head + prev(1) + value(0)
        case i if i < m-1              => prev(i - 2) + prev(i - 1) + prev(i) + value(i - 1)
        case i if i == m-1             => prev(i - 2) + prev(i - 1) + value(i - 1)
        case i if i == m               => prev(i - 2) + value(i - 1)
        case i if i == m+1             => prev(i - 3) + prev(i - 2) + value(i - 2) + value(i - 1)
        case i if i < m+m              => prev(i - 4) + prev(i - 3) + prev(i - 2) + value(i - 1)
        case i if i == m+m             => prev(i - 4) + prev(i - 3) + value(i - 1)
        case i if i == m+m+1           => prev(i - 4) + value(i - 1)
        case i if i == m+m+1+1         => prev(i - 5) + prev(i - 4) + value(i - 1) + value(i - 2)
        case i if i < m+m+1+m          => prev(i - 6) + prev(i - 5) + prev(i - 4) + value(i - 1)
        case i if i == m+m+1+m         => prev(i - 6) + prev(i - 5) + value(i - 1)
        case i if i == m+m+1+m+1       => prev(i - 6) + value(i - 1)
        case i if i == m+m+1+m+1+1     => prev(i - 7) + prev(i - 6) + value(i - 1) + value(i - 2)
        case i if i < m+m+1+m+1+m      => prev(i - 8) + prev(i - 7) + prev(i - 6) + value(i - 1)
        case i if i == m+m+1+m+1+m     => prev(i - 8) + prev(i - 7) + value(i - 1) + value(0)
        case i if i == m+m+1+m+1+m+1   => prev(i - 8) + value(i - 1) + value(0)
      }

      val sh = (0 until length).toList map value
      println(s"${n} ${sh}")
      sh
    }
  }


  println(shell(2))
  println(shell(3))

  println((Stream from 0) flatMap shell find { i => i > input })

  // val (a, b) = lineChecksums.toSeq.unzip
  // println(s"A: ${a.sum}")
  // println(s"B: ${b.sum}")
}
