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

  case class MachineState(id: String, program: List[Instruction], registers: Map[String, Long], eip: Int, queue: List[Long] = Nil, waiting: Boolean = false, numSent: Long = 0) {
    def resolve(value: String): Long =
      if (value.length == 1 && value(0).isLetter)
        registers get value getOrElse 0
      else
        value.toLong

    def nextInstruction: Instruction = program(eip)

    def isFinished: Boolean = !(program.indices contains eip)

    def wake(partner: MachineState): (MachineState, MachineState) =
      if (waiting)
        copy(waiting = false).next(partner)
      else
        (this, partner)

    def next(partner: MachineState): (MachineState, MachineState) =
      program(eip) match {
        case Snd(value) => {
          (
            copy(eip = eip + 1, numSent = numSent + 1),
            partner.copy(queue = partner.queue :+ resolve(value))
          )
            // .wake(copy(eip = eip + 1, numSent = numSent + 1)) match { case (b, a) => (a, b) }
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

        case Rcv(register) =>
          (
            queue match {
              case Nil => copy(waiting = true)
              case next :: rest =>
                copy(
                  registers = registers + (register -> next),
                  queue = rest,
                  waiting = false,
                  eip = eip + 1
                )
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

  def run(states: (MachineState, MachineState)): Long = states match {
    case (stateA, stateB) => {
      if (stateA.isFinished && stateB.isFinished)
        stateB.numSent
      else if (stateA.waiting && stateB.waiting)
        stateB.numSent
      else {
        println()
        println(s"A: ${if (stateA.isFinished) "End" else stateA.nextInstruction} ${stateA.eip} ${stateA.registers} ${stateA.queue}")
        println(s"B: ${if (stateB.isFinished) "End" else stateB.nextInstruction} ${stateB.eip} ${stateB.registers} ${stateB.queue}")

        if (stateA.isFinished)
          run(stateB.next(stateA))
        else if (stateB.isFinished)
          run(stateA.next(stateB))
        else {
          val (interA, interB) = stateA.next(stateB)
          val (nextB, nextA) = interB.next(interA)
          run((nextA, nextB))
        }
      }
    }
  }

  println("B:\n" + (run((MachineState("A", program, Map("p" -> 0), 0), MachineState("B", program, Map("p" -> 1), 0)))))

}
