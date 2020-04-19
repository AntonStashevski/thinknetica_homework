# frozen_string_literal: true

# Carriage
require_relative 'instance_counter'
class Carriage
  include Manufacturer
  include InstanceCounter
  attr_reader :type, :number

  def initialize
    @number = carriage_number
    register_instance
  end

  protected

  def carriage_number
    10.times.map { rand(10) }.join
  end
end
