# frozen_string_literal: true

# Station class can take, send and display all trains.
require_relative 'instance_counter'
class Station
  attr_reader :name
  include InstanceCounter

  @@instances = []

  def self.all
    @@instances
  end

  # насколько я понимаю initialize по дефолту private метод и его не обязательно перемещать под private???
  def initialize(name)
    @name = name
    @@instances << self
    @trains = []
    register_instance
  end

  def take_train(train)
    trains << train
    puts "Train number:#{train.number} arrived on #{name} station."
  end

  def trains_on_station
    trains_number = trains.map(&:number).join(', ')
    if trains_number.empty?
      puts "No trains on station #{name}"
    else
      puts "Now on station #{name}: #{trains_number} trains."
    end
  end

  def cargo_passenger_list
    cargo_count = trains.count(&:cargo?)
    passenger_count = trains.count(&:passenger?)
    puts "cargo: #{cargo_count}, passenger: #{passenger_count}."
  end

  def send_train(train)
    trains.delete(train)
    puts "Train number:#{train.number} departs from #{name} station."
  end

  private

  attr_accessor :trains
end
