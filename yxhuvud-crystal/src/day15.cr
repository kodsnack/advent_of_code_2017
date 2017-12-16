AIN = 873u64; BIN = 583u64
AF  =  16807; BF = 48271

def n(v, factor)
  v * factor % 2147483647
end

def bits(v)
  v % 65536
end

a, b = AIN, BIN
count = 40_000_000.times.count do
  a = n(a, AF)
  b = n(b, BF)
  bits(a) == bits(b)
end
puts "part1"
p count

a, b = AIN, BIN
count = 5_000_000.times.count do
  a = n(a, AF)
  b = n(b, BF)
  while a % 4 != 0
    a = n(a, AF)
  end
  while b % 8 != 0
    b = n(b, BF)
  end
  bits(a) == bits(b)
end
puts "part2"
p count
