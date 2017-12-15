object Day08 extends App {

  type State = Map[String, Int]

  case class Command(
    operand: String,
    operation: (Int, Int) => Int,
    amount: Int,
    testand: String,
    comparison: (Int, Int) => Boolean,
    reference: Int,
  ) {
    def execute(state: State): State =
      if (comparison(state.getOrElse(testand, 0), reference))
        state.updated(operand, operation(state.getOrElse(operand, 0), amount))
      else
        state
  }

  def parseCommand(line: String): Command =
    line.split(" ") match {
      case Array(operand, operation, amount, "if", testand, comparison, reference) =>
        Command(
          operand = operand,
          operation = operation match {
            case "inc" => { _ + _ }
            case "dec" => { _ - _ }
          },
          amount = amount.toInt,
          testand = testand,
          comparison = comparison match {
            case "<"  => { _ <  _ }
            case "<=" => { _ <= _ }
            case ">"  => { _ >  _ }
            case ">=" => { _ >= _ }
            case "==" => { _ == _ }
            case "!=" => { _ != _ }
          },
          reference = reference.toInt,
        )
    }

  val commands: Seq[Command] = (for {
    line <- io.Source.stdin.getLines()
    command = parseCommand(line.trim)
  } yield command).toSeq

  def solveA(commands: Seq[Command]): Int =
    commands
      .foldLeft(Map.empty[String, Int]) { (state, command) => command.execute(state) }
      .values
      .max

  def solveB(commands: Seq[Command]): Int =
    commands
      .scanLeft(Map.empty[String, Int]) { (state, command) => command.execute(state) }
      .flatMap { _.values }
      .max

   println(s"A: ${solveA(commands)}")
   println(s"B: ${solveB(commands)}")
}
