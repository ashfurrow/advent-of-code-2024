#!/usr/bin/env ruby


def total(input)
  input.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
  .map { |r| r[0].to_i * r[1].to_i }
  .sum
end
  
input = File.open('./day_three.input').read.gsub("\n", '') # read the file
puts total(input)

# TODO: this doesn't work yet
matches = input.scan(/(.*?)don't\(\).*?do\(\)/)
puts matches.map { |result| total(result[0]) }.sum +
  total(matches[-1][0].split("do()")[1...].join(""))
