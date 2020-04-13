# frozen_string_literal: true

require 'colorize'
require 'pry'
require 'pry-byebug'

# Area calculator
class TriangleArea
  attr_accessor :base, :height

  def initialize
    @base = base
    @height = height
  end

  def calculate_area
    puts "Triangle Area: #{(0.5 * @base * @height)}"
  end

  def chomp_information(request_string)
    puts request_string
    loop do
      info = gets.chomp
      valid = number_validate(info)
      return info.to_i if valid
    end
  end

  def number_validate(height)
    unless height.scan(/\D/).empty?
      puts 'Triangle sizes must be in numbers, try again!!!'.red
      return false
    end
    true
  end
end

triangle = TriangleArea.new
triangle.base = triangle.chomp_information("What's triangle base?")
triangle.height = triangle.chomp_information("What's your height?")
triangle.calculate_area
