# frozen_string_literal: true

# Carriage
require_relative 'instance_counter'
require_relative 'validate'
class Carriage
  include Manufacturer
  include InstanceCounter
  include Validate
  attr_reader :type
  attr_accessor :number

  def initialize(number)
    @number = number
    validate_train_carriage_object_number!
    register_instance
  end
end
