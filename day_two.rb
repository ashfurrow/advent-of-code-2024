#!/usr/bin/env ruby

def is_safe?(report)
  return true if report.length <= 1 

  increasing = report[0] < report[1]
  acc = report[0]
  report[1...].each do |level|
    if increasing
      return false if level <= acc
    else # decreasing
      return false if level >= acc
    end

    return false if (level-acc).abs > 3

    acc = level
  end

  return true
end

def remove_index(arr, index)
  arr.dup.tap{|i| i.delete_at(index)}
end


def is_safe_dampener?(report)
  # Any report of length 1 is valid, and we can remove any single element. 
  return true if report.length <= 2 
  
  # Let's handle the easy case, if the report is conventionally safe.
  return true if is_safe?(report)

  # Okay, so the report is not "safe." 
  # The naive approach is to remove elements from the array and check if 
  # removing just one makes it safe. Inelegant.
  # The more sophisticated approach is to rewrite is_safe? in a way that detects
  # individual problems based on context.
  # But the dampener was installed after-the-fact, not realtime. And the input
  # data is small enough that the naive approach works.
  
  report.each_with_index do |_, index|
    return true if is_safe?(remove_index(report, index))
  end

  return false
end

reports = File.open('./day_two.input')
  .readlines # read the lines
  .map { |line| line.split(' ').map(&:to_i) } # split the levels and convert to ints

puts reports.select{ |r| is_safe?(r) }.length
puts reports.select{ |r| is_safe_dampener?(r) }.length
