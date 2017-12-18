object Day18 extends App {

  val sndPattern = raw"snd (\S+)".r
  val setPattern = raw"set (\S+) (\S+)".r
  val addPattern = raw"add (\S+) (\S+)".r
  val mulPattern = raw"mul (\S+) (\S+)".r
  val modPattern = raw"mod (\S+) (\S+)".r
  val rcvPattern = raw"rcv (\S+)".r
  val jgzPattern = raw"jgz (\S+) (\S+)".r

  trait Instruction
  case class Snd(value: String) extends Instruction
  case class Set(register: String, value: String) extends Instruction
  case class Add(register: String, value: String) extends Instruction
  case class Mul(register: String, value: String) extends Instruction
  case class Mod(register: String, value: String) extends Instruction
  case class Recover(value: String) extends Instruction
  case class Receive(value: String) extends Instruction
  case class Jgz(value: String, diff: String) extends Instruction

  case class MachineState(
    program: Vector[Instruction],
    registers: Map[String, Long] = Map.empty,
    eip: Int = 0,
    queue: Vector[Long] = Vector.empty,
    waiting: Boolean = false,
    numSent: Long = 0,
  ) {
    def resolve(value: String): Long =
      if (value.length == 1 && value(0).isLetter)
        registers get value getOrElse 0
      else
        value.toLong

    def nextInstruction: Instruction = program(eip)

    def isFinished: Boolean = !(program.indices contains eip)

    def next(partner: MachineState): (MachineState, MachineState) =
      program(eip) match {
        case Snd(value) => {
          (
            copy(eip = eip + 1, numSent = numSent + 1),
            partner.copy(queue = partner.queue :+ resolve(value))
          )
        }

        case Set(register, value) =>
          (
            copy(
              registers = registers + (register -> resolve(value)),
              eip = eip + 1
            ),
            partner
          )

        case Add(register, value) =>
          (
            copy(
              registers = registers + (register -> (resolve(register) + resolve(value))),
              eip = eip + 1
            ),
            partner
          )

        case Mul(register, value) =>
          (
            copy(
              registers = registers + (register -> resolve(register) * resolve(value)),
              eip = eip + 1
            ),
            partner
          )

        case Mod(register, value) =>
          (
            copy(
              registers = registers + (register -> resolve(register) % resolve(value)),
              eip = eip + 1
            ),
            partner
          )

        case Recover(value) =>
          if (resolve(value) != 0)
            (
              copy(
                queue = queue :+ partner.queue.last,
                eip = eip + 1
              ),
              partner.copy(queue = Vector.empty)
            )
          else
            (
              copy(eip = eip + 1),
              partner
            )

        case Receive(register) =>
          (
            queue match {
              case next +: rest =>
                copy(
                  registers = registers + (register -> next),
                  queue = rest,
                  waiting = false,
                  eip = eip + 1
                )
              case _ => copy(waiting = true)
            },
            partner
          )

        case Jgz(value, diff) =>
          (
            copy(
              eip =
                if (resolve(value) > 0) eip + resolve(diff).toInt
                else (eip + 1)
            ),
            partner
          )
      }
  }

  val program: Vector[Instruction] = (for {
    line <- io.Source.stdin.getLines()
    instruction = line.trim match {
      case sndPattern(value)           => Snd(value)
      case setPattern(register, value) => Set(register, value)
      case addPattern(register, value) => Add(register, value)
      case mulPattern(register, value) => Mul(register, value)
      case modPattern(register, value) => Mod(register, value)
      case rcvPattern(value)           => Recover(value)
      case jgzPattern(value, diff)     => Jgz(value, diff)
    }
  } yield instruction).toVector

  def solveA(state: MachineState, partner: MachineState): Long = state.queue match {
    case result +: rest => result
    case _ => {
      val (next, nextPartner) = state.next(partner)
      solveA(next, nextPartner)
    }
  }
  def solveA(program: Vector[Instruction]): Long =
    solveA(MachineState(program), MachineState(Vector.empty))

  def solveB(states: (MachineState, MachineState)): Long = states match {
    case (stateA, stateB) => {
      if (stateA.isFinished && stateB.isFinished)
        stateB.numSent
      else if (stateA.waiting && stateB.waiting)
        stateB.numSent
      else if (stateA.isFinished)
        solveB(stateB.next(stateA).swap)
      else if (stateB.isFinished)
        solveB(stateA.next(stateB))
      else {
        val (interA, interB) = stateA.next(stateB)
        val (nextB, nextA) = interB.next(interA)
        solveB((nextA, nextB))
      }
    }
  }
  def solveB(program: Vector[Instruction]): Long = {
    val programB = program map {
      case Recover(v) => Receive(v)
      case i => i
    }
    solveB((MachineState(programB, Map("p" -> 0)), MachineState(programB, Map("p" -> 1))))
  }

  println(s"A: ${solveA(program)}")
  println(s"B: ${solveB(program)}")
}
