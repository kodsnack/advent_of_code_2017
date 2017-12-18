object Day18 extends App {

  val sndPattern = raw"snd (\S+)".r
  val setPattern = raw"set (\S+) (\S+)".r
  val addPattern = raw"add (\S+) (\S+)".r
  val mulPattern = raw"mul (\S+) (\S+)".r
  val modPattern = raw"mod (\S+) (\S+)".r
  val rcvPattern = raw"rcv (\S+)".r
  val jgzPattern = raw"jgz (\S+) (\S+)".r

  val registerPattern = raw"^[a-bA-B]$$".r

  trait Instruction
  case class Snd(value: String) extends Instruction
  case class Set(register: String, value: String) extends Instruction
  case class Add(register: String, value: String) extends Instruction
  case class Mul(register: String, value: String) extends Instruction
  case class Mod(register: String, value: String) extends Instruction
  case class Rcv(value: String) extends Instruction
  case class Jgz(value: String, diff: String) extends Instruction

  case class MachineState(program: List[Instruction], registers: Map[String, Long], eip: Int, recovered: Option[Long] = None, played: Option[Long] = None) {
    def resolve(value: String): Long =
      if (value.length == 1 && value(0).isLetter)
        registers get value getOrElse 0
      else
        value.toLong

    def nextInstruction: Instruction = program(eip)

    def isFinished: Boolean = !(program.indices contains eip)

    def next: MachineState =
      program(eip) match {
        case Snd(value) =>
          copy(
            played = Some(resolve(value)),
            eip = eip + 1
          )

        case Set(register, value) =>
          copy(
            registers = registers + (register -> resolve(value)),
            eip = eip + 1
          )

        case Add(register, value) =>
          copy(
            registers = registers + (register -> (resolve(register) + resolve(value))),
            eip = eip + 1
          )

        case Mul(register, value) =>
          copy(
            registers = registers + (register -> resolve(register) * resolve(value)),
            eip = eip + 1
          )

        case Mod(register, value) =>
          copy(
            registers = registers + (register -> resolve(register) % resolve(value)),
            eip = eip + 1
          )

        case Rcv(value) =>
          copy(
            recovered = if (resolve(value) != 0) played
                        else recovered,
            eip = eip + 1
          )

        case Jgz(value, diff) =>
          copy(
            eip =
              if (resolve(value) > 0) eip + resolve(diff).toInt
              else (eip + 1)
          )
      }
  }

  val program = (for {
    line <- io.Source.stdin.getLines
    instruction = line.trim match {
      case sndPattern(value) => Snd(value)
      case setPattern(register, value) => Set(register, value)
      case addPattern(register, value) => Add(register, value)
      case mulPattern(register, value) => Mul(register, value)
      case modPattern(register, value) => Mod(register, value)
      case rcvPattern(value) => Rcv(value)
      case jgzPattern(value, diff) => Jgz(value, diff)
    }
  } yield instruction).toList

  def run(state: MachineState): MachineState = {
    println()
    println(state.nextInstruction)
    println(state.registers)
    println(state.played)
    println(state.recovered)
    state.nextInstruction match {
    case _: Rcv => {
      val next = state.next
      state.recovered map { s => state } getOrElse (run(next))
    }
    case _ => state.next match {
      case newState if newState.isFinished => newState
      case newState => run(newState)
    }
  }
  }

  println("A:\n" + (run(MachineState(program, Map.empty, 0)).recovered))
  // println("B:\n" + (run(MachineState(program, Map.empty, 0)).registers mkString "\n"))

}
