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

  // val (a, b) = lineChecksums.toSeq.unzip
  // println(s"A: ${a.sum}")
  // println(s"B: ${b.sum}")
}
