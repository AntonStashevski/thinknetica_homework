# frozen_string_literal: true

require 'pry'

puts 'Enter the day month and year in the format (day month year)'
day, month, year = gets.chomp.split(' ').map(&:to_i)

def dates_hash(february_day)
  [31, february_day, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
end

def february_date(year)
  (year % 400).zero? || ((year % 4).zero? && year % 100 != 0) ? 29 : 30
end

def calculate_day(day, month, dates)
  temp = 0
  day_index = 0
  while temp < month
    day_index += dates[temp]
    temp += 1
  end
  day_index + day
end

dates = dates_hash(february_date(year))
puts "Date serial number: #{calculate_day(day, month, dates)}"
