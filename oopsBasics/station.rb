# frozen_string_literal: true

# Station class can take, send and display all trains.
class Station
  attr_accessor :trains_on_station, :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains_on_station = []
  end

  def take_train(train)
    @trains_on_station << train
    puts "Train number:#{train.number} arrived on #{station_name} station."
  end

  def cargo_passenger_list
    cargo = 0
    passenger = 0
    @trains_on_station.each { |train| train.type == 'cargo' ? cargo += 1 : passenger += 1 }
    puts "cargo: #{cargo}, passenger: #{passenger}."
    [cargo, passenger]
  end

  def send_train(train)
    @trains_on_station.delete(train)
    puts "Bye-bye train number:#{train.number}."
  end
end

# Route class contains start station, end station and way station's list,
# can add, delete way station's and display all stations from start to last.
class Route
  attr_accessor :start_station, :end_station, :way_stations
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @way_stations = [start_station, end_station]
  end

  def add_way_station(station)
    @way_stations.insert(-2, station)
    puts "Add station #{station.station_name} to route."
  end

  def delete_way_station(station)
    @way_stations.delete(station)
    puts "Delete station #{station.station_name} to route."
  end

  def display_stations
    @way_stations.each { |station| puts station.station_name }
  end
end

# Train class have random number, type(0 = cargo orr any symbol = passenger), carriages_count,
# you can raise speed, return current speed and carriages count, stop your train, hook or unhook
# carriage, take_route, drive_back or driveto next station,
class Train
  attr_accessor :number, :type, :speed, :carriages_count, :station, :route
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
      return "#{@station.station_name} last station"
    end

    step = @route.way_stations.index(@station)
    puts step
    @route.way_stations[step + 1].station_name
  end

  def previous_station
    if @route.way_stations.index(@station).zero?
      return "#{@station.station_name} last station"
    end

    step = @route.way_stations.index(@station)
    @route.way_stations[step - 1].station_name
  end

  def current_station
    @station.station_name
  end
end

# moscow = Station.new('Moscow')
# gomel = Station.new('Gomel')
# borisov = Station.new('Borisov')
# lida = Station.new('Lida')
# minsk = Station.new('Minsk')
# minsk_moscow = Route.new(minsk, moscow)
# gomel_lida = Route.new(gomel, lida)
# train = Train.new(1, 6)
# train2 = Train.new(1, 7)
# train3 = Train.new(0, 5)
# train4 = Train.new(0, 4)
# train.take_route(minsk_moscow)
# train2.take_route(minsk_moscow)
# train3.take_route(minsk_moscow)
# train4.take_route(gomel_lida)
# minsk.cargo_passenger_list
# gomel.cargo_passenger_list
# minsk_moscow.add_way_station(gomel)
# minsk_moscow.add_way_station(borisov)
# minsk_moscow.display_stations
# train.drive_next
# train.drive_next
# train.drive_next
# train.drive_next
# train.next_station
# train.drive_back
# train.drive_back
# train.drive_back
# train.drive_back
# train.drive_back
# train.previous_station
