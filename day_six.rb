#!/usr/bin/env ruby

map = File.open('./day_six.input')
  .readlines
  .map(&:chomp)
  .map { |l| l.chars}

# puts map.map(&:join)

height = map.length
width = map.first.length

row = map.find_index { |l| l.index('^') }
col = map[row].index('^')

# Sanity check
puts "#{row}, #{col}"

directions = {
  "^" => [-1, 0],
  "V" => [1, 0],
  ">" => [0, 1],
  "<" => [0, -1]
}.freeze

rotations = {
  "^" => ">",
  "V" => "<",
  ">" => "V",
  "<" => "^"
}.freeze

loop do 
  guard = map[row][col]
  puts "#{row}, #{col}, #{guard}"
  d_row, d_col = directions[guard]
  # puts d_row, d_col
  dest = map[row+d_row][col+d_col]
  if dest != '#'
    map[row][col] = 'X'
    row += d_row
    col += d_col
    map[row][col] = guard
  else
    map[row][col] = rotations[guard]
  end

  break if row < 0 || col < 0 || row >= height || col >= width
end

puts "\n\nEnding position: #{row}, #{col}"

puts map.flat_map { |l| l.select { |c| c == 'X' }}.length
