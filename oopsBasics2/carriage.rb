# frozen_string_literal: true

# Carriage
class Carriage
  attr_reader :type, :number

  def initialize
    @number = carriage_number
  end

  protected

  def carriage_number
    10.times.map { rand(10) }.join
  end
end
