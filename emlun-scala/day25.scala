object Day25 extends App {

  val beginPattern = raw"Begin in state (\S+).".r
  val stepCountPattern = raw".* after (\d+) steps.".r
  val statePattern = raw"In state (\S+):".r
  val currentValuePattern = raw"\s*If the current value is (0|1):".r
  val writeValuePattern = raw"\s*- Write the value (0|1).".r
  val movePattern = raw"\s*- Move one slot to the (\S+).".r
  val nextStatePattern = raw"- Continue with state (\S+).".r

  def parseMachine(input: List[String]): MachineState = {
    val (preamble, program) = input.splitAt(2)

    val startState: String = preamble.head match {
      case beginPattern(s) => s
    }

    val stepCount: Int = preamble(1) match {
      case stepCountPattern(s) => s.toInt
    }

    val instructions: Map[(String, Boolean), Instruction] = (for {
      section <- program map { _.trim } grouped 10
      (currentState, rest) = section match {
        case "" :: statePattern(currentState) :: rest => (currentState, rest)
      }
      instructionText <- rest grouped 4
      instruction = instructionText match {
        case List(
          currentValuePattern(currentValue),
          writeValuePattern(writeValue),
          movePattern(move),
          nextStatePattern(nextState),
        ) =>
          Instruction(
            currentState,
            currentValue.toInt == 1,
            writeValue.toInt == 1,
            if (move == "right") 1 else -1,
            nextState
          )
      }
    } yield (currentState, instruction.currentValue) -> instruction).toMap

    MachineState(
      startState,
      stepCount,
      instructions,
    )
  }

  case class Instruction(
    currentState: String,
    currentValue: Boolean,
    writeValue: Boolean,
    move: Int,
    nextState: String,
  )

  case class MachineState(
    state: String,
    finishCount: Int,
    program: Map[(String, Boolean), Instruction],
    memory: Map[Int, Boolean] = Map.empty,
    memoryAddress: Int = 0,
    stepCount: Int = 0,
  ) {
    def isFinished: Boolean = stepCount >= finishCount

    val currentValue: Boolean = memory.getOrElse(memoryAddress, false)
    val nextInstruction: Instruction = program((state, currentValue))

    def next: MachineState =
      copy(
        state = nextInstruction.nextState,
        memory = memory.updated(memoryAddress, nextInstruction.writeValue),
        memoryAddress = memoryAddress + nextInstruction.move,
        stepCount = stepCount + 1,
      )
  }

  def solveA(blueprint: List[String]) = {
    val state = parseMachine(blueprint)
    Iterator.iterate(state)(_.next)
      .dropWhile { !_.isFinished }
      .next()
      .memory
      .count { case (k, v) => v }
  }

  val blueprint: List[String] = io.Source.stdin.getLines().toList
  println(s"A: ${solveA(blueprint)}")
}
