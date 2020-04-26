# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'
# Train class have random number, type(0 = cargo orr any symbol = passenger),
# carriages_count, you can raise speed,
# return current speed and carriages count, stop your train,
# hook or unhook carriage, take_route, drive_back or drive to next station,
class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  attr_reader :number, :speed, :type, :carriages

  def self.find(train_number)
    objects = ObjectSpace.each_object(Train).to_a
    objects.each { |train| return train if train.number == train_number }
    nil
  end

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
  end

  def each_carriage
    carriages.each { |carriage| yield(carriage) if block_given? }
    nil
  end

  def raise_speed(speed)
    self.speed = speed
  end

  def current_speed
    speed
  end

  def cargo?
    type == 'cargo'
  end

  def passenger?
    type == 'passenger'
  end

  def take_route(route)
    @route = route
    @station = route.start_station
    route.start_station.take_train(self)
  end

  def drive_back
    return nil if previous_station.nil?

    step = @route.way_stations.index(@station) - 1
    @route.way_stations[step + 1].send_train(self)
    @station = @route.way_stations[step]
    @route.way_stations[step].take_train(self)
  end

  def hook_carriage(carriage)
    speed.zero? && type == carriage.type ? carriages << carriage : nil
  end

  def unhook_carriage(carriage)
    carriages.delete(carriage) if speed.zero? && carriages.include?(carriage)
  end

  def hooked_carriages
    carriages.map(&:number).join(', ')
  end

  def drive_next
    return nil if next_station.nil?

    step = @route.way_stations.index(@station) + 1
    @route.way_stations[step - 1].send_train(self)
    @station = @route.way_stations[step]
    @route.way_stations[step].take_train(self)
  end

  def next_station
    return nil if @route.way_stations.size == @route.way_stations.index(@station) + 1

    step = @route.way_stations.index(@station)
    @route.way_stations[step + 1].name
  end

  def previous_station
    return nil if @route.way_stations.index(@station).zero?

    step = @route.way_stations.index(@station)
    @route.way_stations[step - 1].name
  end

  def current_station
    @station.name
  end

  attr_writer :number

  private

  attr_writer :speed, :type, :carriages
end
