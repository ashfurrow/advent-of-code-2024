#!/usr/bin/env ruby

# Returns input[row][col] or " " if out of bounds.
def at(input, row, col)
  return " " if row < 0 || col < 0 || row >= input.length || col >= input[0].length
  return input[row][col]
end

# Check if the X-MAS's that start from here IE: the A is at (row, col)
def check(input, row, col)
  return false if at(input, row, col) != 'A'

  # Get the four characters around us
  down_right = at(input, row+1, col+1)  
  up_right = at(input, row-1, col+1)  
  down_left = at(input, row+1, col-1)  
  up_left = at(input, row-1, col-1)  

  return (
    # /
    (down_left == 'M' && up_right == 'S' || down_left == 'S' && up_right == 'M') &&
    # \
    (down_right == 'M' && up_left == 'S' || down_right == 'S' && up_left == 'M')
  )
end

input = File.open('./day_four.input').readlines
matches = 0

input.length.times do |row|
  input[0].length.times do |col|
    matches += 1 if check(input, row, col)
  end
end

puts matches
