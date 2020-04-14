# frozen_string_literal: true

require 'colorize'
require 'pry'
require 'pry-byebug'

# Right triangle
class TriangleArea
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
    if sides_array.map { |side| side.scan(/\D/).empty? }.include?(false) || sides_array.size != 3
      puts 'Sides must be in numbers or check sides,try again!!!'.red
      return false
    end
    true
  end

  def triangle_type(sides)
    biggest_side = sides.delete_at(sides.index(sides.max))
    side1 = sides.first
    side2 = sides.last
    puts 'This triangle is rectangular!!!' if side1**2 + side2**2 == biggest_side**2
    puts 'This triangle is isosceles!!!' if side1 == side2 || side1 == biggest_side || side2 == biggest_side
    return unless side1 == side2 && side2 == biggest_side

    puts 'This triangle is equilateral!!!'
  end
end

triangle = TriangleArea.new
triangle.chomp_information('Enter the sides of the triangle in format (a b c)?')
