input = File.read ARGV[0]

class Op
  property lval : String
  property op : String
  property rval : Int32
  property c_lval : String
  property c_op : String
  property c_rval : Int32

  def initialize(@lval, @op, @rval, @c_lval, @c_op, @c_rval); end
end

ops = input.lines.map do |l|
  m = l.match(/(\w+) (inc|dec) (-?\d+) if (\w+) ([<>=!]+) (-?\d+)/)
  if m
    Op.new(m[1], m[2], m[3].to_i, m[4], m[5], m[6].to_i)
  else
    raise "unreachable"
  end
end

macro conds(cond_ops)
  case op.c_op
{% for name in cond_ops %}
  when {{name}}
    c_lval {{ name.id }} op.c_rval
{% end %}
  else
    raise "invalid c_op #{op.c_op}"
  end
end

max = Int32::MIN

regs = {} of String => Int32
ops.each do |op|
  c_lval = (regs[op.c_lval]? || 0)
  cond = conds(%w(< > <= >= == !=))

  if cond
    regs[op.lval] ||= 0
    case op.op
    when "inc"
      regs[op.lval] += op.rval
    when "dec"
      regs[op.lval] -= op.rval
    else
      raise "invalid op #{op.op}"
    end
    max = regs[op.lval] if regs[op.lval] > max
  end
end
puts "part1"
puts regs.values.max
puts "part2"
puts max
