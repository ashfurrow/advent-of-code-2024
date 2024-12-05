#!/usr/bin/env ruby

def at(input, row, col)
  return " " if row < 0 || col < 0 || row >= input.length || col >= input[0].length
  return input[row][col]
end

def recurse(input, row, col, digit, row_inc, col_inc)
  return true if digit > 3

  character = case digit
  when 0
    'X'
  when 1 
    'M'
  when 2
    'A'
  when 3
    'S'
  end

  return nil if at(input, row, col) != character
  return recurse(input, row+row_inc, col+col_inc, digit+1, row_inc, col_inc)
end

START = 0.freeze

# Count the XMAS's that start from here IE: the X is at (row, col)
def count(input, row, col)
  return 0 if at(input, row, col) != 'X'

  [
    recurse(input, row, col, START, 0, 1),   # horizontal
    recurse(input, row, col, START, 1, 0),   # vertical down
    recurse(input, row, col, START, 0, -1),  # horizontal backwards
    recurse(input, row, col, START, -1, 0),  # vertical up
    recurse(input, row, col, START, -1, 1),  # diag up and right
    recurse(input, row, col, START, 1, 1),   # diag down and right
    recurse(input, row, col, START, -1, -1), # diag up and left
    recurse(input, row, col, START, 1, -1),  # diag down and left
].compact.length
end

input = File.open('./day_four.input').readlines
matches = 0

input.length.times do |row|
  input[0].length.times do |col|
    matches += count(input, row, col)
  end
end

puts matches
