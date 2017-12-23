program = File.read(ARGV[0]).lines

class Machine
  property id : Int32
  property regs : Hash(String, Int64)
  property pos
  property queue
  property blocked
  property other : Nil | self
  property sent
  property invoked
  property program : Array(Instruction)

  def initialize(@id, program)
    @regs = registry
    regs["p"] = @id.to_i64
    @pos = 0
    @queue = [] of Int64
    @blocked = false
    @other = nil
    @sent = 0
    @invoked = 0
    @program = parser(program)
  end

  def parser(program)
    program.map do |l|
      parse(l, [Snd, Rcv, Set, Add, Sub, Mul, Mod, Jgz, Jnz])
    end
  end

  macro parse(line, ops)
      case l
      {% for name in ops %}
       when {{name}}::PATTERN
         {{name}}.new $1, $2
      {% end %}
      else
         raise "unhandled: #{{{line}}}"
      end
    end

  def registry
    Hash(String, Int64).new do |h, k|
      if k =~ /^-?\d+/
        k.to_i64
      else
        h[k] = 0i64
      end
    end
  end

  def run
    until blocked || pos == program.size
      if program[pos].call(self)
        next
      else
        @pos += 1
      end
    end
  end

  abstract struct Instruction
    property arg1 : String
    property arg2 : String

    def initialize(@arg1, @arg2); end
  end

  struct Snd < Instruction
    PATTERN = /snd ([-\w]+)/

    def call(machine)
      if o = machine.other
        o.queue << machine.regs[arg1]
        o.blocked = false
        machine.sent += 1
      end
      false
    end
  end

  struct Rcv < Instruction
    PATTERN = /rcv ([-\w]+)/

    def call(machine)
      return true if machine.blocked = machine.queue.empty?
      machine.regs[arg1] = machine.queue.shift.not_nil!
      false
    end
  end

  struct Set < Instruction
    PATTERN = /set (.) ([-\w]+)/

    def call(machine)
      machine.regs[@arg1] = machine.regs[@arg2]
      false
    end
  end

  struct Add < Instruction
    PATTERN = /add (.) ([-\w]+)/

    def call(machine)
      machine.regs[@arg1] += machine.regs[@arg2]
      false
    end
  end

  struct Sub < Instruction
    PATTERN = /sub (.) ([-\w]+)/

    def call(machine)
      machine.regs[@arg1] -= machine.regs[@arg2]
      false
    end
  end

  struct Mul < Instruction
    PATTERN = /mul (.) ([-\w]+)/

    def call(machine)
      machine.invoked += 1
      machine.regs[@arg1] *= machine.regs[@arg2]
      false
    end
  end

  struct Mod < Instruction
    PATTERN = /mod (.) ([-\w]+)/

    def call(machine)
      machine.regs[@arg1] %= machine.regs[@arg2]
      false
    end
  end

  struct Jgz < Instruction
    PATTERN = /jgz (.) ([-\w]+)/

    def call(machine)
      machine.pos += machine.regs[@arg2] - 1 if machine.regs[@arg1] > 0
      false
    end
  end

  struct Jnz < Instruction
    PATTERN = /jnz (.) ([-\w]+)/

    def call(machine)
      machine.pos += machine.regs[@arg2] - 1 if machine.regs[@arg1] != 0
      false
    end
  end
end

prog = Machine.new(0, program)
prog.run
puts "part1: #{prog.invoked}"

replacement = <<-EOS
set g b
mul g 1
mul g 1
mod g d
jgz g 3
set f 0
jnz 1 7
add d 1
set g d
mul g g
sub g b
jgz g 2
jgz 1 -13
EOS

prog = Machine.new(0, program)
prog.program[11..23] = prog.parser(replacement.strip.lines)
prog.regs["a"] = 1_i64
prog.run
puts "part2: #{prog.regs["h"]}"
