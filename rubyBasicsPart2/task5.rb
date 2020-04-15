# frozen_string_literal: true

puts 'Enter the day month and year in the format (day month year)'
day, month, year = gets.chomp.split(' ').map(&:to_i)

def dates_hash(february_day)
  { January: [31, 1], February: [february_day, 2], March: [31, 3],
    April: [30, 4], May: [31, 5], June: [30, 6],
    July: [31, 7], August: [31, 8], September: [30, 9],
    October: [31, 10], November: [30, 11], December: [31, 12] }
end

def february_date(year)
  if (year % 4).zero?
    if (year % 100).zero?
      return 29 if (year % 400).zero?

      return 30
    end
    return 29
  end
  30
end

def calculate_day(day, month, dates)
  day_index = 0
  dates.map do |month2|
    return day_index += day if month2.last.last == month

    day_index += month2.last.first
  end
end

dates = dates_hash(february_date(year))
puts "Date serial number: #{calculate_day(day, month, dates)}"
