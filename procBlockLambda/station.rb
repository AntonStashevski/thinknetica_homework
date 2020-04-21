# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'

# Station class can take, send and display all trains.
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
    validate!(self.name, 'text', 'station_name', 5, 'Минск(русские буквы и дефисы)')
    @@instances << self
    @trains = []
    register_instance
  end

  def take_train(train)
    trains << train
  end

  def trains_on_station
    trains
  end

  def cargo_passenger_list
    cargo_count = trains.count(&:cargo?)
    passenger_count = trains.count(&:passenger?)
    [cargo_count, passenger_count]
  end

  def send_train(train)
    trains.delete(train)
  end

  def each_train
    trains_on_station.each { |train| yield(train) if block_given? }
    nil
  end

  private

  attr_accessor :trains
end
