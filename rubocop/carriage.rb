# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'
# Carriage
class Carriage
  include Manufacturer
  include InstanceCounter
  include Validate
  attr_reader :type
  attr_accessor :number, :volume, :free_volume

  def initialize(number, volume)
    @number = number
    @volume = volume
    @free_volume = volume
    validate!({ info: self.number, type: 'text', name: :train_carriage_number, length: 5, example: '(123-22)' }, 5)
    register_instance
  end

  def cargo?
    type == 'cargo'
  end

  def passenger?
    type == 'passenger'
  end

  def take_volume(value = 1)
    volume = free_volume - value
    volume >= 0 ? self.free_volume = volume : nil
  end

  def occupied_volume
    volume - free_volume
  end
end
