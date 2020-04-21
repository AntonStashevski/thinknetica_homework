# frozen_string_literal: true

require_relative 'instance_counter'
# Route class contains start station, end station and way station's list,
# can add, delete way station's and display all stations from start to last.
class Route
  include InstanceCounter

  attr_reader :start_station, :end_station, :way_stations, :name
  def initialize(start_station, end_station)
    @name = "#{start_station.name}_#{end_station.name}"
    @start_station = start_station
    @end_station = end_station
    @way_stations = [start_station, end_station]
  end

  def add_way_station(station)
    way_stations.insert(-2, station)
  end

  def delete_way_station(station)
    way_stations.delete(station)
  end

  def display_all_stations
    station_list = []
    way_stations.each_with_index do |station, index|
      station_list << "#{index} - #{station.name}"
    end
    station_list
  end

  private

  attr_writer :way_stations
end
