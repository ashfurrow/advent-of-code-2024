#!/usr/bin/env ruby

puts File.open('./day_three.input')
  .read # read the file
  .scan(/mul\((\d{1,3}),(\d{1,3})\)/)
  .map { |r| r[0].to_i * r[1].to_i }
  .sum

