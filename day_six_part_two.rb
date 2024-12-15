#!/usr/bin/env ruby

@map = File.open('./day_six.input')
  .readlines
  .map(&:chomp)
  .map { |l| l.chars}

@height = @map.length
@width = @map.first.length

@starting_row = @map.find_index { |l| l.index('^') }
@starting_col = @map[@starting_row].index('^')

# Sanity check
puts "Starting at #{@starting_row}, #{@starting_col}"

@directions = {
  "^" => [-1, 0],
  "V" => [1, 0],
  ">" => [0, 1],
  "<" => [0, -1]
}.freeze

@rotations = {
  "^" => ">",
  "V" => "<",
  ">" => "V",
  "<" => "^"
}.freeze

def cycle_detect(map)
  row = @starting_row
  col = @starting_col

  movements = Array.new(@height) { Array.new(@width) { Set.new } }
  is_cycle = false

  loop do 
    guard = map[row][col]

    if movements[row][col].include? guard
      is_cycle = true
      break
    end

    movements[row][col].add guard

    # puts "#{row}, #{col}, #{guard}"
    d_row, d_col = @directions[guard]
    # puts d_row, d_col
    
    break if row+d_row < 0 || col+d_col < 0 || row+d_row >= @height || col+d_col >= @width

    dest = map[row+d_row][col+d_col]

    if dest != '#'
      map[row][col] = 'X'
      row += d_row
      col += d_col
      map[row][col] = guard
    else
      map[row][col] = @rotations[guard]
    end
  
  end
  
  return is_cycle
end

test_map = @map.map(&:dup)
test_map[14][16] = '#'
cycle_detect(test_map) 

# puts cycle_detect(@map.map(&:dup))
cycles = 0
@height.times do |row|
  puts "checking row #{row}"
  @width.times do |col|
    next if row == @starting_row && col == @starting_col
    # puts "    checking col #{col}"
    map = @map.map(&:dup)
    map[row][col] = '#'
    cycles += 1 if cycle_detect(map)
  end
end

puts "#{cycles} cycles"

# puts "\n\nEnding position: #{row}, #{col}"
# puts @map.flat_map { |l| l.select { |c| c == 'X' }}.length
