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
      instruction <- section match {
        case List(
          "",
          statePattern(currentState),
          currentValuePattern(currentValue1),
          writeValuePattern(writeValue1),
          movePattern(move1),
          nextStatePattern(nextState1),
          currentValuePattern(currentValue2),
          writeValuePattern(writeValue2),
          movePattern(move2),
          nextStatePattern(nextState2),
        ) => {
          val ia = Instruction(
            currentState,
            currentValue1.toInt == 1,
            writeValue1.toInt == 1,
            if (move1 == "right") 1 else -1,
            nextState1
          )
          val ib = Instruction(
            currentState,
            currentValue2.toInt == 1,
            writeValue2.toInt == 1,
            if (move2 == "right") 1 else -1,
            nextState2
          )

          List(
            (currentState, ia.currentValue) -> ia,
            (currentState, ib.currentValue) -> ib,
          )
        }
      }
    } yield instruction).toMap

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
