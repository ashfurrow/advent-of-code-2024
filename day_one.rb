#!/usr/bin/env ruby

list_a, list_b = File.open('./day_one.input')
  .readlines # read the lines
  .map(&:chomp) # handle whitespace
  .map { |line| line.split.map(&:to_i) } # split the columns and convert to int
  .transpose # transform into two arrays
  .map(&:sort) # sort those arrays

puts list_a.zip(list_b) # re-zip the sorted arrays
  .map { |a, b| (a-b).abs } # get the distance of each pair
  .sum # sum it up
