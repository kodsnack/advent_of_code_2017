object Main extends App {

  val startA: Long = 512
  val startB: Long = 191

  // val startA: Long = 65
  // val startB: Long = 8921

  val factorA = 16807
  val factorB = 48271

  val filterA = 4
  val filterB = 8

  def step(factor: Long, filterMultiplier: Long)(prev: Long): Long = {
    val v = (prev * factor) % 2147483647l
    if (v % filterMultiplier == 0)
      v
    else
      step(factor, filterMultiplier)(v)
  }

  val streamA = Iterator.iterate(startA)(step(factorA, filterA))
  val streamB = Iterator.iterate(startB)(step(factorB, filterB))

  println(streamA.zip(streamB).drop(1).take(5000000).count({ case (a, b) => (a % 65536) == (b % 65536) }))
}
