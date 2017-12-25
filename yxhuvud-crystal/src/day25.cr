state = :a

tape = Hash(Int32, Int32).new(default_value: 0)
pos = 0
12368930.times do
  case state
  when :a
    if tape[pos] == 0
      tape[pos] = 1
      pos += 1
      state = :b
    else
      tape[pos] = 0
      pos += 1
      state = :c
    end
  when :b
    if tape[pos] == 0
      tape[pos] = 0
      pos -= 1
      state = :a
    else
      tape[pos] = 0
      pos += 1
      state = :d
    end
  when :c
    if tape[pos] == 0
      tape[pos] = 1
      pos += 1
      state = :d
    else
      tape[pos] = 1
      pos += 1
      state = :a
    end
  when :d
    if tape[pos] == 0
      tape[pos] = 1
      pos -= 1
      state = :e
    else
      tape[pos] = 0
      pos -= 1
      state = :d
    end
  when :e
    if tape[pos] == 0
      tape[pos] = 1
      pos += 1
      state = :f
    else
      tape[pos] = 1
      pos -= 1
      state = :b
    end
  when :f
    if tape[pos] == 0
      tape[pos] = 1
      pos += 1
      state = :a
    else
      tape[pos] = 1
      pos += 1
      state = :e
    end
  end
end

puts "part1"
p tape.values.count(&.==(1))
