# frozen_string_literal: true

# Station class can take, send and display all trains.
require_relative 'instance_counter'
require_relative 'validate'
class Station
  attr_accessor :name
  include InstanceCounter
  include Validate

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    validate_station_object!
    @@instances << self
    @trains = []
    register_instance
  end

  def take_train(train)
    trains << train
  end

  def trains_on_station
    trains.map(&:number).join(', ')
  end

  def cargo_passenger_list
    cargo_count = trains.count(&:cargo?)
    passenger_count = trains.count(&:passenger?)
    [cargo_count, passenger_count]
  end

  def send_train(train)
    trains.delete(train)
  end

  private

  attr_accessor :trains
end
