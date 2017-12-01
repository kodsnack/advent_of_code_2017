

object Day1 {
  def main (args: Array[String]) {
    println("please enter the input")
    val input =readLine.toList.map(_.asDigit)
    println("first: " + matchSum(input, 1))
    println("second: " + matchSum(input, input.length / 2))
  }
  
  def matchSum(input: List[Int], offset: Int): Int = {
    val matched = for (i <- 0 to (input.length - 1)) yield Array(input(i), input((i + offset) % input.length))
    return matched.filter(a => a(0) == a(1)).map(_(0)).sum
  }
}