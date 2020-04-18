# frozen_string_literal: true

# Route class contains start station, end station and way station's list,
# can add, delete way station's and display all stations from start to last.
class Route
  attr_reader :start_station, :end_station, :way_stations, :name
  def initialize(start_station, end_station)
    @name = "#{start_station.name}_#{end_station.name}"
    @start_station = start_station
    @end_station = end_station
    @way_stations = [start_station, end_station]
  end

  def add_way_station(station)
    way_stations.insert(-2, station)
    puts "Add station #{station.name} to route."
  end

  def delete_way_station(station)
    way_stations.delete(station)
    puts "Delete station #{station.name} to route."
  end

  def display_all_stations
    puts 'Stations on this route: '
    way_stations.each_with_index { |station, index| p "#{index} - #{station.name}" }
  end

  private

  attr_writer :way_stations
end
