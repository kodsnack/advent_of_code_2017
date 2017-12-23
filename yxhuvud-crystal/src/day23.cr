program = File.read(ARGV[0]).lines

class Machine
  property regs : Hash(String, Int64)
  property pos
  property invoked
  property program : Array(String)

  def initialize(@program)
    @regs = registry
    @pos = 0
    @invoked = 0
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
    until pos == program.size
      case l = program[pos]
      when /set (.) ([-\w]+)/
        regs[$1] = regs[$2]
      when /add (.) ([-\w]+)/
        regs[$1] += regs[$2]
      when /sub (.) ([-\w]+)/
        regs[$1] -= regs[$2]
      when /mul (.) ([-\w]+)/
        @invoked += 1
        regs[$1] *= regs[$2]
      when /mod (.) ([-\w]+)/
        regs[$1] %= regs[$2]
      when /jgz (.) ([-\w]+)/
        @pos += regs[$2] - 1 if regs[$1] > 0
      when /jnz (.) ([-\w]+)/
        @pos += regs[$2] - 1 if regs[$1] != 0
      else
        raise "unhandled: #{l}"
      end
      @pos += 1
    end
  end
end

prog = Machine.new(program)
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

prog = Machine.new(program)
prog.program[11..23] = replacement.strip.lines
prog.regs["a"] = 1_i64
prog.run
puts "part2: #{prog.regs["h"]}"
