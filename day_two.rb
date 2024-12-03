#!/usr/bin/env ruby

def is_safe?(report)
  return true if report.length <= 1 

  increasing = report[0] < report[1]
  acc = report[0]
  for level in report[1...]
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

reports = File.open('./day_two.input')
  .readlines # read the lines
  .map { |line| line.split(' ').map(&:to_i) } # split the levels and convert to ints

safe_reports = 0
reports.each { |r| safe_reports += is_safe?(r) ? 1 : 0}

puts safe_reports
