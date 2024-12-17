#!/usr/bin/env ruby

# WIDTH = 11.freeze
# HEIGHT = 7.freeze

WIDTH = 101.freeze
HEIGHT = 103.freeze

class Robot
  attr_accessor :x
  attr_accessor :y
  attr_reader :dx
  attr_reader :dy

  def initialize(x, y, dx, dy)
    @x = x
    @y = y
    @dx = dx
    @dy = dy  
  end

  def clocktick
    @x = (@x + @dx) % WIDTH
    @y = (@y + @dy) % HEIGHT
  end
end

def empty
  Array.new(HEIGHT) { Array.new(WIDTH) { 0 } }
end

def grid(robots)
  robots.reduce(empty) do |acc, robot|
    acc[robot.y][robot.x] += 1
    acc
  end
end

def quad_factor(quad)
  quad.sum{ |l| l.sum }
end

def safety_factor(robots)
  grid = grid(robots)

  tl = grid.take(HEIGHT/2).map{ |l| l.take(WIDTH / 2) }
  tr = grid.take(HEIGHT/2).map{ |l| l.drop(WIDTH / 2 + 1) }
  br = grid.drop(HEIGHT/2 + 1).map{ |l| l.take(WIDTH / 2) }
  bl = grid.drop(HEIGHT/2 + 1).map{ |l| l.drop(WIDTH / 2 + 1) }
  quad_factor(tl) * quad_factor(tr) * quad_factor(br) * quad_factor(bl)
end

def print(robots)
  puts grid(robots).map { |line| line.map{ |d| d > 0 ? d.to_s : "." }.join("") }
end

robots = File.open('./day_fourteen.input')
  .readlines 
  .map(&:chomp)
  .map do |line| 
    p, v = line.split(" ").map { |l| l.match /[vp]=(-?\d+).(-?\d+)/ }
    Robot.new(p[1].to_i, p[2].to_i, v[1].to_i, v[2].to_i)
  end

# 
puts "Initially:\n"
print(robots)
puts "\n\n"

# Part One
# 100.times{ robots.each{ |r| r.clocktick } }
# puts "Eventually\n"
# print(robots)
# puts "Safety factor: #{safety_factor(robots)}"

# Part Two
safety_factors = []
(WIDTH * HEIGHT).times.map do |tick_num|
  robots.each{ |r| r.clocktick } 
  safety_factors.push(safety_factor(robots))
  if safety_factors.last == 89257418 # Number determined below
    puts "Lowest safety tick number #{tick_num + 1}"
    print(robots)
  end
end

# Average is 221818940
# puts safety_factors.sum / safety_factors.length

# The safety factor for an arranged tree should be smaller than average. The 
# smallest safety factor is 89257418
# puts safety_factors.min
