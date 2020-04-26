# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
# Carriage
class Carriage
  include Manufacturer
  include InstanceCounter
  include Validation
  attr_reader :type
  attr_accessor :number, :volume, :free_volume

  validate :number, :presence
  validate :number, :format, /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/

  def initialize(number, volume)
    @number = number
    @volume = volume
    @free_volume = volume
    validate!
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
