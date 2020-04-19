# frozen_string_literal: true

# Train class have random number, type(0 = cargo orr any symbol = passenger),
# carriages_count, you can raise speed,
# return current speed and carriages count, stop your train,
# hook or unhook carriage, take_route, drive_back or drive to next station,
require_relative 'instance_counter'
class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :speed, :type, :carriages

  def self.find
    objects = ObjectSpace.each_object(Train).to_a
    puts 'Введите номер поезда'
    train_number = gets.chomp
    objects.each { |train| return train if train.number == train_number }
    nil
  end

  def initialize
    @number = 10.times.map { rand(10) }.join
    @speed = 0
    @carriages = []
    register_instance
  end

  def raise_speed(speed)
    self.speed = speed
  end

  def current_speed
    speed
  end

  def stop
    0
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
    return 'Your train on start station!' if @station == @route.start_station

    step = @route.way_stations.index(@station) - 1
    @route.way_stations[step + 1].send_train(self)
    @station = @route.way_stations[step]
    @route.way_stations[step].take_train(self)
  end

  def hook_carriage(carriage)
    if speed.zero? && type == carriage.type
      carriages << carriage
      puts "Hooked carriage #{carriage.number}"
    else
      puts("You can't hook carriage until the train stops or check carriage type")
    end
  end

  def unhook_carriage(carriage)
    if speed.zero? && carriages.include?(carriage)
      carriages.delete(carriage)
      puts "Unhooked carriage #{carriage.number}"
    else
      puts("You can't unhook carriage until the train stops or carriage not hooked")
    end
  end

  def hooked_carriages
    carriages_numbers = carriages.map(&:number).join(', ')
    puts "Carriages hooked to the train #{number}: #{carriages_numbers}."
  end

  def drive_next
    return 'Your train on end station!' if @station == @route.end_station

    step = @route.way_stations.index(@station) + 1
    @route.way_stations[step - 1].send_train(self)
    @station = @route.way_stations[step]
    @route.way_stations[step].take_train(self)
  end

  def next_station
    if @route.way_stations.size == @route.way_stations.index(@station) + 1
      return "#{@station.name} last station"
    end

    step = @route.way_stations.index(@station)
    @route.way_stations[step + 1].name
  end

  def previous_station
    if @route.way_stations.index(@station).zero?
      return "#{@station.name} last station"
    end

    step = @route.way_stations.index(@station)
    @route.way_stations[step - 1].name
  end

  def current_station
    @station.name
  end

  private

  attr_writer :speed, :type, :carriages
end
