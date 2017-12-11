input = File.read ARGV[0]

def group(input, pos, n)
  depth, pos, garbage = group_list(input, pos + 1, n)
  {n + depth, pos + 1, garbage}
end

def group_list(input, pos, n)
  sum = 0
  garbage = 0
  case input[pos]
  when '}'
    return {sum, pos, garbage}
  when '{'
    depth, pos, garbage2 = group(input, pos, n + 1)
    sum += depth
    garbage += garbage2
  when '<'
    pos, garbage2 = garbage(input, pos + 1)
    garbage += garbage2
  else
    raise "unreachable"
  end
  if input[pos] == ','
    rest, pos, garbage2 = group_list(input, pos + 1, n)
    {sum + rest, pos, garbage + garbage2}
  else
    {sum, pos, garbage}
  end
end

def garbage(input, pos)
  e = false
  garbage = 0
  input[pos..-1].each_char do |c|
    pos += 1
    if e
      e = false
      next
    else
      case c
      when '!'
        e = true
      when '>'
        return {pos, garbage}
      else
        garbage += 1
        next
      end
    end
  end
  raise "unreachable"
end

input.each_line do |l|
  sum, s, garbage = group(l, 0, 1)
  puts "part1"
  p sum
  puts "part2"
  p garbage
end
