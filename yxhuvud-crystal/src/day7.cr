input = File.read ARGV[0]

parents = Hash(String, String).new
children = Hash(String, Tuple(Array(String), Int32)).new
input.lines.map do |l|
  parts = l.match /(\w+) \((\d+)\)( -> ((\w+)(, )?)+)?/
  if parts
    if parts[3]?
      child_parts = parts[3].gsub(/ -> /, "").split(", ")
      child_parts.each do |p|
        parents[p] = parts[1]
        children[parts[1]] = {child_parts, parts[2].to_i}
      end
    else
      children[parts[1]] = {[] of String, parts[2].to_i}
    end
  end
end

bottom = parents.keys.first?

while parents[bottom]?
  bottom = parents[bottom]
end

puts "part 1"
puts bottom

def cost(n, current_children, children)
  balances = current_children.map do |val|
    if children[val]?
      arr, n2 = children[val]
      ccost = cost(n2, arr, children).as(Int32)
      {ccost, n2}
    else
      {0, 0}
    end
  end

  imbalanced = balances.group_by(&.first)
  wrong, right = imbalanced.partition do |k, val|
    val.size.==(1)
  end
  if wrong.size == 1
    puts "part 2"
    puts wrong.first.last.first.last - (wrong.first.first - right.first.first)
    exit
  end
  n + balances.map(&.first).sum
end

cost(children[bottom][1], children[bottom][0], children)
