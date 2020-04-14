# frozen_string_literal: true

require 'colorize'
require 'pry'
require 'pry-byebug'

# Calculator
class TriangleArea
  def chomp_information(request_string)
    puts request_string
    loop do
      roots = gets.chomp
      valid = number_validate(roots)
      return calculate_roots(roots.split(' ').map(&:to_i)) if valid
    end
  end

  def number_validate(roots)
    roots_array = roots.split(' ')
    if roots_array.map { |side| side[/^[-+]?\d*$/].nil? }.include?(true) || roots_array.size != 3
      puts 'Roost must be in numbers or check their count, try again!!!'.red
      return false
    end
    true
  end

  def calculate_roots(roots)
    a_root, b_root, c_root = roots[0], roots[1], roots[2]
    puts "Your equation looks like: #{a_root}x^² + #{b_root}x + #{c_root} = 0"
    discriminant = discriminant_calculate(a_root, b_root, c_root)
    roots_calculate(a_root, b_root, c_root, discriminant)
  end

  def discriminant_calculate(a_root, b_root, c_root)
    discriminant = b_root**2 - 4 * a_root * c_root
    if discriminant.negative?
      puts 'No roots!!!'.red
      sleep(1)
      exit
    end
    discriminant
  end

  def roots_calculate(a_root, b_root, c_root, discriminant)
    if discriminant > 0
      x1 = (-b_root + Math.sqrt(discriminant))/ 2.0 * a_root
      x2 = (-b_root - Math.sqrt(discriminant))/ 2.0 * a_root
    elsif discriminant == 0
      x1 = x2 = -b_root / (2.0 * a_root)
    end
    puts "Root №1: #{x1}\nRoot №2: #{x2}"
  end
end

triangle = TriangleArea.new
triangle.chomp_information('Enter the roots of the triangle in format (a b c)?')
