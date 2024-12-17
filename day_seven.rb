#!/usr/bin/env ruby

def test(target, acc, operands)
  return false if acc > target

  if operands.empty?
    return acc == target
  end

  first, *rest = operands

  return test(target, acc * first, rest) || 
    test(target, acc + first, rest) ||
    test(target, "#{acc}#{first}".to_i, rest) # part two only
end

lines = File.open('./day_seven.input')
  .readlines
  .map(&:chomp)
  .map { |l| l.split(":").join(" ").split(" ").map(&:to_i) }
  .select do |line| 
    target, first, *rest = line
    test(target, first, rest) 
  end

# puts lines.map {|l| "#{l}\n\n"}
puts lines.sum { |l| l.first }
