#!/usr/bin/env ruby

require 'set'

input = File.open('./day_five.input')
  .readlines
  .map(&:chomp)

rules = Set.new(input.take_while { |l| l.length > 0})
manuals = input
  .reverse
  .take_while { |l| l.length > 0}
  .reverse
  .map {|m| m.split(",").map(&:to_i)}

grouped_manuals = manuals.group_by do |manual|
  group = :valid
  manual.each_with_index do |n, index|
    next if index == 0
    pair = "#{manual[index-1]}|#{n}"
    unless rules.include?(pair)
      group = :invalid
    end
  end
  group
end

# 4281
puts grouped_manuals[:valid]
  .map { |m| m[m.length/2] }
  .sum

def sort_manual(manual, rules)
  return manual.sort { |a,b| 
    if rules.include?("#{a}|#{b}")
      -1
    elsif rules.include?("#{b}|#{a}")
      1
    else
      0
    end
  }
end

# 5466
puts grouped_manuals[:invalid]
  .map { |m| sort_manual(m, rules) }
  .map { |m| m[m.length/2] }
  .sum

