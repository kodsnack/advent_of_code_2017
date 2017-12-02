puts "1a"
input = gets
sum = 0
if input
  input.size.times do |i|
    if input[i] == input[(i + 1) % input.size]
      sum += input[i].to_i
    end
  end
end
puts sum
puts "1b"
sum = 0
if input
  input.size.times do |i|
    if input[i] == input[(i + input.size/2) % input.size]
      sum += input[i].to_i
    end
  end
end
puts sum
