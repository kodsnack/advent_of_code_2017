import java.io.File

fun captcha(input: List<Int>, step: Int) =
        input.indices.filter { input[it] == input[(it+step) % input.size] }
                     .map { input[it] }
                     .sum()

val digits = File("day_01_input").readText().map { it-'0' }
println("solution 1: " + captcha(digits, 1))             // 1393
println("solution 2: " + captcha(digits, digits.size/2)) // 1292