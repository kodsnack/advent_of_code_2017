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
        case Set(g, d) +: Mul(g1, e) +: Sub(g2, b) +: Jnz(g3, "2") +: Set(f, "0") +: Sub(e1, "-1") +: Set(g4, e2) +: Sub(g5, b1) +: Jnz(g6, "-8") +: rest
          if optimize
              && List(g, g1, g2, g3, g4, g5, g6).toSet.size == 1
              && List(e, e1, e2).toSet.size == 1
              && b1 == b
          =>
          copy(
            registers = registers
              .updated("e", resolve("b"))
              .updated("f", if (resolve("b") % resolve("d") == 0) 0L else 1L)
              .updated("g", 0L)
            ,
            eip = eip + (
              if (resolve("b") % resolve("d") == 0) 13
              else 9
            )
          )

        // case Sub (d, "-1") +: Set(g, d1) +: Sub(g1, b) +: Jnz(g2, "-13") +: rest
          // if optimize
              // && d1 == d
              // && List(g, g1, g2).toSet.size == 1
          // =>
          // copy(
            // registers = registers
              // .updated("d", resolve("b"))
              // .updated("g", 0L)
            // ,
            // eip = eip + 4
          // )

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

  def isPrime(n: Long): Boolean =
    if (n <= 2) false
    else (3.to(Math.sqrt(n).floor.toInt, 2)).exists({ n % _ == 0 }) == false

  def solveB(state: MachineState) = {
    // val endState = Iterator.iterate(state.copy(program = state.program.take(10)))({ state: MachineState => state.next }).dropWhile({ !_.isFinished }).next()
    // println(endState)

    // val b = endState.resolve("b")
    // val c = endState.resolve("c")

    // val h = (for { i <- b.to(c, 17) } yield isPrime(i)).count(_ == false)

    // h
    val endState = Iterator.iterate(state)({ state: MachineState => state.next }).dropWhile({ state =>
      println(state.eip + " " + state.registers)
      !state.isFinished
    }).next()
    endState.registers("h")
  }

  println(s"A: ${solveA(MachineState(program))}")
  println(s"B: ${solveB(MachineState(program, Map("a" -> 1), optimize = true))}")
}
