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
    optimize: Boolean = false,
  ) {
    def resolve(value: String): Long =
      if (value.length == 1 && value(0).isLetter)
        registers get value getOrElse 0
      else
        value.toLong

    def nextInstruction: Instruction = program(eip)

    def isFinished: Boolean = !(program.indices contains eip)

    def next: MachineState =
      program.drop(eip) match {
        case Set(g, d) +: Mul(g1, e) +: Sub(g2, b) +: Jnz(g3, "2") +: Set(f, "0") +: Sub(e1, "-1") +: Set(g4, e2) +: Sub(g5, b1) +: Jnz(g6, "-8")
              +: Sub (d1, "-1") +: Set(g7, d2) +: Sub(g8, b2) +: Jnz(g9, "-13") +: rest
          if optimize
              && List(g, g1, g2, g3, g4, g5, g6, g7, g8, g9).toSet.size == 1
              && List(e, e1, e2).toSet.size == 1
              && List(b, b1, b2).toSet.size == 1
              && List(d, d1, d2).toSet.size == 1
          =>
          copy(
            registers = registers
              .updated(d, resolve(b))
              .updated(e, resolve(b))
              .updated(f, if (isPrime(resolve(b))) 1L else 0L)
              .updated(g, 0L)
            ,
            eip = eip + 13
          )

        case Set(register, value) +: rest =>
          copy(
            registers = registers + (register -> resolve(value)),
            eip = eip + 1
          )

        case Sub(register, value) +: rest =>
          copy(
            registers = registers + (register -> (resolve(register) - resolve(value))),
            eip = eip + 1
          )

        case Add(register, value) +: rest =>
          copy(
            registers = registers + (register -> (resolve(register) + resolve(value))),
            eip = eip + 1
          )

        case Mul(register, value) +: rest =>
          copy(
            registers = registers + (register -> resolve(register) * resolve(value)),
            eip = eip + 1
          )

        case Mod(register, value) +: rest =>
          copy(
            registers = registers + (register -> resolve(register) % resolve(value)),
            eip = eip + 1
          )

        case Jgz(value, diff) +: rest =>
          copy(
            eip =
              if (resolve(value) > 0) eip + resolve(diff).toInt
              else (eip + 1)
          )

        case Jnz(value, diff) +: rest =>
          copy(
            eip =
              if (resolve(value) != 0) eip + resolve(diff).toInt
              else (eip + 1)
          )
      }
  }

  def isPrime(n: Long): Boolean =
    if (n % 2 == 0) false
    else (3.to(Math.sqrt(n).ceil.toInt, 2)).exists({ n % _ == 0 }) == false

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

  def solveA(program: Vector[Instruction]) =
    Iterator.iterate(MachineState(program))({ _.next })
      .takeWhile { !_.isFinished }
      .count { state =>
        state.program(state.eip) match {
          case m: Mul => true
          case _ => false
        }
      }

  def solveB(program: Vector[Instruction]) =
    Iterator.iterate(MachineState(program, Map("a" -> 1), optimize = true))(_.next)
      .dropWhile(!_.isFinished)
      .next()
      .registers("h")

  println(s"A: ${solveA(program)}")
  println(s"B: ${solveB(program)}")
}
