object Main extends App {

  val startA: Long = 512
  val startB: Long = 191

  // val startA: Long = 65
  // val startB: Long = 8921

  val factorA = 16807
  val factorB = 48271

  def step(factor: Long)(prev: Long): Long = (prev * factor) % 2147483647l

  val streamA = Iterator.iterate(startA)(step(factorA))
  val streamB = Iterator.iterate(startB)(step(factorB))

  println(streamA.zip(streamB).take(40000000).count({ case (a, b) => (a % 65536) == (b % 65536) }))
}
