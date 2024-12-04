#!/usr/bin/env ruby


def total(input)
  input.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
  .map { |r| r[0].to_i * r[1].to_i }
  .sum
end
  
input = File.open('./day_three.input').read.gsub("\n", '') # read the file
puts total(input)

matches = "do()#{input}don't()".scan(/do\(\)(.*?)don't\(\)/)
puts matches.map { |result| total(result[0]) }.sum 
