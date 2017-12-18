program = File.read(ARGV[0]).lines

class Machine
  property id : Int32
  property regs : Hash(String, Int64)
  property program : Array(String)
  property pos
  property queue
  property blocked
  property other : Nil | self
  property sent

  def initialize(@id, @program)
    @regs = registry
    regs["p"] = @id.to_i64
    @pos = 0
    @queue = [] of Int64
    @blocked = false
    @other = nil
    @sent = 0
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
    until blocked
      process
    end
  end

  def process
    case l = program[pos]
    when /snd ([-\w]+)/
      if o = other
        o.queue << regs[$1]
        o.blocked = false
        @sent += 1
      end
    when /rcv (.)/
      return if @blocked = queue.empty?
      regs[$1] = queue.shift.not_nil!
    when /set (.) ([-\w]+)/
      regs[$1] = regs[$2]
    when /add (.) ([-\w]+)/
      regs[$1] += regs[$2]
    when /mul (.) ([-\w]+)/
      regs[$1] *= regs[$2]
    when /mod (.) ([-\w]+)/
      regs[$1] %= regs[$2]
    when /jgz (.) ([-\w]+)/
      @pos += regs[$2] - 1 if regs[$1] > 0
    else
      raise "unhandled: #{l}"
    end
    @pos += 1
  end
end

prog = Machine.new(0, program)
cons = Machine.new(1, ["rcv a", "jgz 1 -1"])
prog.other = cons
prog.run
cons.run
puts "part1: #{cons.regs["a"]}"

machines = [Machine.new(0, program), Machine.new(1, program)]
machines[0].other = machines[1]
machines[1].other = machines[0]
while machine = machines.reject(&.blocked).first?
  machine.run
end
puts "part2: %s" % machines.map(&.sent).last
