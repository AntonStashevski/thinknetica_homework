# frozen_string_literal: true

# Station class can take, send and display all trains.
class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
    puts "Train number:#{train.number} arrived on #{name} station."
  end

  def cargo_passenger_list
    cargo_count = @trains.count(&:cargo?)
    passenger_count = @trains.count(&:passenger?)
    puts "cargo: #{cargo_count}, passenger: #{passenger_count}."
    [cargo_count, passenger_count]
  end

  def send_train(train)
    @trains.delete(train)
    puts "Bye-bye train number:#{train.number}."
  end
end

# Route class contains start station, end station and way station's list,
# can add, delete way station's and display all stations from start to last.
class Route
  attr_accessor :way_stations
  attr_reader :start_station, :end_station
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @way_stations = [start_station, end_station]
  end

  def add_way_station(station)
    @way_stations.insert(-2, station)
    puts "Add station #{station.name} to route."
  end

  def delete_way_station(station)
    @way_stations.delete(station)
    puts "Delete station #{station.name} to route."
  end

  def display_stations
    @way_stations.select { |station| puts station.name }
  end
end

# Train class have random number, type(0 = cargo orr any symbol = passenger), carriages_count,
# you can raise speed, return current speed and carriages count, stop your train, hook or unhook
# carriage, take_route, drive_back or drive to next station,
class Train
  attr_reader :number, :type
  attr_accessor :carriages_count
  def initialize(type, carriages_count)
    @number = (0...10).map { ('a'..'z').to_a[rand(9)] }.join
    @type = type.zero? ? 'cargo' : 'passenger'
    @carriages_count = carriages_count
    @speed = 0
  end

  def raise_speed(speed)
    @speed = speed
  end

  def current_speed
    @speed
  end

  def cargo?
    type == 'cargo'
  end

  def passenger?
    type == 'passenger'
  end

  def stop
    @speed = 0
  end

  def hook_carriage
    @speed.zero? ? @carriages_count += 1 : puts("You can't hook carriage until the train stops")
    @carriages_count
  end

  def unhook_carriage
    @speed.zero? ? @carriages_count -= 1 : puts("You can't hook carriage until the train stops")
    @carriages_count
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
    puts step
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
end
