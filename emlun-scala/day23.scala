object Day23 extends App {

  val setPattern = raw"set (\S+) (\S+)".r
  val subPattern = raw"sub (\S+) (\S+)".r
  val addPattern = raw"add (\S+) (\S+)".r
  val mulPattern = raw"mul (\S+) (\S+)".r
  val modPattern = raw"mod (\S+) (\S+)".r
  val jgzPattern = raw"jgz (\S+) (\S+)".r
  val jnzPattern = raw"jnz (\S+) (\S+)".r

  trait Instruction
  case class Snd(value: String) extends Instruction
  case class Set(register: String, value: String) extends Instruction
  case class Sub(register: String, value: String) extends Instruction
  case class Add(register: String, value: String) extends Instruction
  case class Mul(register: String, value: String) extends Instruction
  case class Mod(register: String, value: String) extends Instruction
  case class Jgz(value: String, diff: String) extends Instruction
  case class Jnz(value: String, diff: String) extends Instruction

  case class MachineState(
    program: Vector[Instruction],
    registers: Map[String, Long] = Map.empty,
    eip: Int = 0,
  ) {
    def resolve(value: String): Long =
      if (value.length == 1 && value(0).isLetter)
        registers get value getOrElse 0
      else
        value.toLong

    def nextInstruction: Instruction = program(eip)

    def isFinished: Boolean = !(program.indices contains eip)

    def next: MachineState =
      program(eip) match {
        case Set(register, value) =>
          copy(
            registers = registers + (register -> resolve(value)),
            eip = eip + 1
          )

        case Sub(register, value) =>
          copy(
            registers = registers + (register -> (resolve(register) - resolve(value))),
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

        case Jgz(value, diff) =>
          copy(
            eip =
              if (resolve(value) > 0) eip + resolve(diff).toInt
              else (eip + 1)
          )

        case Jnz(value, diff) =>
          copy(
            eip =
              if (resolve(value) != 0) eip + resolve(diff).toInt
              else (eip + 1)
          )
      }
  }

  val program: Vector[Instruction] = (for {
    line <- io.Source.stdin.getLines()
    instruction = line.trim match {
      case setPattern(register, value) => Set(register, value)
      case subPattern(register, value) => Sub(register, value)
      case addPattern(register, value) => Add(register, value)
      case mulPattern(register, value) => Mul(register, value)
      case modPattern(register, value) => Mod(register, value)
      case jgzPattern(value, diff)     => Jgz(value, diff)
      case jnzPattern(value, diff)     => Jnz(value, diff)
    }
  } yield instruction).toVector

  def solveA(state: MachineState) = {
    val states = Iterator.iterate(state)({ _.next }).takeWhile({ !_.isFinished })
    states.count({ state =>
      state.program(state.eip) match {
        case m: Mul => true
        case _ => false
      }
    })
  }

  println(s"A: ${solveA(MachineState(program))}")
}
