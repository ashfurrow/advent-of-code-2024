#!/usr/bin/env ruby



list_a, list_b = File.open('./day_one.input')
  .readlines # read the lines
  .map(&:chomp) # handle whitespace
  .map { |line| line.split.map(&:to_i) } # split the columns and convert to int
  .transpose # transform into two arrays

hash_b = {}

list_b.each do |b|
  hash_b[b] = hash_b.fetch(b, 0) + 1
end

puts list_a.map { |a| hash_b.fetch(a, 0) * a }.sum
