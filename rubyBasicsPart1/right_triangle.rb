# frozen_string_literal: true

require 'colorize'
require 'pry'
require 'pry-byebug'

# Right triangle
class TriangleArea

  def calculate_area
    puts "Triangle Area: #{(0.5 * @base * @height)}"
  end

  def chomp_information(request_string)
    puts request_string
    loop do
      sides = gets.chomp
      valid = number_validate(sides)
      return triangle_type(sides.split(' ').map(&:to_i)) if valid
    end
  end

  def number_validate(sides)
    sides_array = sides.split(' ')
    if sides_array.map {|side| side.scan(/\D/).empty?}.include?(false) || sides_array.size != 3
      puts 'Triangle sides must be in numbers or check sides count, try again!!!'.red
      return false
    end
    true
  end

  def triangle_type(sides)
    biggest_side = sides.delete_at(sides.index(sides.max))
    side_1, side_2 = sides.first, sides.last
    if side_1**2 + side_2**2 == biggest_side**2
      puts 'This triangle is rectangular!!!'
    elsif side_1 == side_2 || side_1 == biggest_side || side_2 == biggest_side
      puts 'This triangle is isosceles!!!'
    elsif
    puts 'This triangle is simple!!!'
    end
    if side_1 == side_2 && side_2 == biggest_side
      puts 'This triangle is equilateral!!!'
    end
  end

end

triangle = TriangleArea.new
triangle.chomp_information("Enter the sides of the triangle in format (a b c)?")
