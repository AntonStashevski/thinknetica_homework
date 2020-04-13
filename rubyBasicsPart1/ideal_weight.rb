# frozen_string_literal: true

require 'colorize'
require 'pry'

# Calculate your ideal weight
class WeightCalculator
  attr_accessor :name, :height

  def initialize
    @name = name
    @height = height
  end

  def calculate_weight
    binding.pry
    ideal_height = (@height.to_i - 110) * 1.15
    if ideal_height.positive?
      puts "Your ideal weight: #{ideal_height.round 3}"
    else
      puts "Your weight is already optimal!!!"
    end
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
    unless height.scan(/\D/).empty?
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
