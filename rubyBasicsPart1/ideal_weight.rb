# frozen_string_literal: true

require 'colorize'
require 'pry'
require 'pry-byebug'

# Calculate your ideal weight
class WeightCalculator
  attr_accessor :name, :height

  def initialize
    @name = name
    @height = height
  end

  def calculate_weight
    ideal_height = (@height - 110) * 1.15
    ideal_height.positive? "Your ideal weight: #{ideal_height}" ? "Your weight is already optimal!!!"
  end

  def chomp_information(request_string, validator)
    puts request_string
    while true
      info = gets.chomp
      valid = validator == 'name' ? name_validate(info) : height_validate(info)
      return info if valid
    end
  end

  def name_validate(name)
    if name[/[a-zA-Z ]+/] == name
      puts "hello #{name}!!!"
      true
    else
      puts 'name must be in english letters, try again!!!'.red
      false
    end
  end

  def height_validate(height)
    unless height[/[0-9]+/] == height
      puts 'height must be in numbers, try again!!!'.red
      return false
    end
    true
  end
end

person = WeightCalculator.new
person.name = person.chomp_information("What's your name?", 'name')
person.height = person.chomp_information("What's your height?", 'height')
person.calculate_weight
