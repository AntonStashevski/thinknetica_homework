# frozen_string_literal: true

require 'pry'
require_relative 'manufacturer'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'carriage'
require_relative 'carriage_cargo'
require_relative 'carriage_passenger'
require_relative 'instance_counter'
require_relative 'validate'
# Menu
class Menu
  include Validate
  include Manufacturer
  include InstanceCounter

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def chomp_information
    loop do
      choice = select_information(main_menu)
      case choice
      when 1
        station_control
      when 2
        create_train
      when 3
        create_manage_route
      when 4
        choice_route
      when 5
        hook_unhook_carriage(0)
      when 6
        hook_unhook_carriage(1)
      when 7
        drive_next_previous
      when 8
        train_list_at_the_station
      when 9
        create_carriage
      else
        exit
      end
    end
  end

  private

  def station_control
    station_control_menu
    choice = select_information
    case choice
    when 1
      name = select_information(nil, 'station') { 'Введите название станции' }
      @stations << Station.new(name)
      puts "Станция #{@stations.last.name} создана"
    when 2
      station = select_information(print_all_stations) { 'Выберите станцию' }
      @stations[station].each_train do |train|
        puts "Номер поезда: #{train.number}, тип: #{train.type}, кол-во вагонов: #{train.carriages.size}"
      end
    end
  end

  def train_list_at_the_station
    train_list_at_the_station_menu
    choice = select_information
    case choice
    when 1
      print_all_trains
    when 2
      station = select_information(print_all_stations) { 'Выберите станцию' }
      station_name = @stations[station].name
      trains = @stations[station].trains_on_station.map(&:number).join(', ')
      if trains.empty?
        puts "На станции: #{station_name} нет поездов"
      else
        puts "На станции #{station_name}: #{trains} поезда."
      end
    else
      exit
    end
  end

  def drive_next_previous
    drive_next_previous_menu
    choice = select_information
    train = select_information(print_all_trains) { 'Выберите поезд' }
    train_number = @trains[train].number
    current_station_name = @trains[train].current_station
    case choice
    when 1
      next_station_name = @trains[train].next_station
      if @trains[train].drive_next.nil?
        puts "Поезд: #{train_number} находится на конечной станции"
      else
        puts "Поезд: #{train_number} отпраялется со станции #{current_station_name} на станцию #{next_station_name}."
      end
    when 2
      previous_station_name = @trains[train].previous_station
      if @trains[train].drive_back.nil?
        puts "Поезд: #{train_number} находится на начальной станции"
      else
        puts "Поезд: #{train_number} отпраялется со станции #{current_station_name} на станцию #{previous_station_name}."
      end
    else
      exit
    end
  end

  def hook_unhook_carriage(method)
    train = select_information(print_all_trains) { 'Выберите поезд' }
    carriage = select_information(print_all_carriages) { 'Выберите вагон' }
    carriage_number = @carriages[carriage].number
    if method.zero?
      if @trains[train].hook_carriage(@carriages[carriage]).nil?
        puts 'Вы не можете прицеплять вагоны пока поезд не остановится или проверьте тип вагона'
      else
        puts "Вагон: #{carriage_number} прицеплен"
      end
    elsif method == 1
      @trains[train].unhook_carriage(@carriages[carriage])

      if @trains[train].unhook_carriage(@carriages[carriage]).nil?
        puts 'Вы не можете отцеплять вагоны пока поезд не остановится или проверьте тип вагона'
      else
        puts "Вагон: #{carriage_number} отцеплен"
      end
    end
  end

  def create_carriage
    carriage_menu
    choice = select_information
    case choice
    when (1..2)
      carriage_number = select_information(nil, 'carriage') { 'Введите номер вагона' }
      volume = select_information(nil, 'volume') { 'Введите кол-во мест/объем вагона' }
      if choice == 1
        @carriages << CarriageCargo.new(carriage_number, volume)
        puts "Грузовой вагон под номером: #{@carriages.last.number} c объемом #{volume} создан"
      elsif choice == 2
        @carriages << CarriagePassenger.new(carriage_number, volume)
        puts "Пассажирский вагон под номером: #{@carriages.last.number} c #{volume} местами создан"
      end
    when (3..6)
      carriage_information(choice)
    else
      exit
    end
  end

  def carriage_information(choice)
    carriage_num = select_information(print_all_carriages) { 'Выберите вагон' }
    carriage = @carriages[carriage_num]
    if choice == 3
      puts "Кол-во мест/объема: #{carriage.volume}"
    elsif choice == 4
      if carriage.cargo?
        volume = select_information(nil, 'volume') { 'Введите объем который вы хотите занять' }
        if carriage.take_volume(volume)
          puts("Вагон: #{carriage.number} наполнился на #{volume}")
        else
          puts("Вагон: #{carriage.number} не может наполнится на такой объем!")
        end
      elsif carriage.passenger?
        if carriage.take_volume
          puts("В вагонe: #{carriage.number} сел пасажир")
        else
          puts("Вагон: #{carriage.number} уже забит!")
        end
      end
    elsif choice == 5
      puts "В вагонe: #{carriage.number} занято #{carriage.occupied_volume} мест/объема"
    elsif choice == 6
      puts "В вагонe: #{carriage.number} свободно #{carriage.free_volume} мест/объема"
    end
  end

  def create_train
    create_train_menu
    choice = select_information
    train_number = select_information(nil, 'train') { 'Введите номер поезда' }
    case choice
    when 1
      @trains << TrainPassenger.new(train_number)
      puts "Паccажирский поезд номер #{@trains.last.number} создан"
    when 2
      @trains << TrainCargo.new(train_number)
      puts "Грузовой поезд номер #{@trains.last.number} создан"
    when 3
      train = select_information(print_all_trains) { 'Выберите поезд' }
      @trains[train].each_carriage do |carriage|
        if carriage.cargo?
          puts "Номер вагона: #{carriage.number}, тип: #{carriage.type}, занятый объем: #{carriage.occupied_volume}, cвободный объем: #{carriage.free_volume}"
        else
          puts "Номер вагона: #{carriage.number}, тип: #{carriage.type}, занято мест: #{carriage.occupied_volume}, cвободно мест: #{carriage.free_volume}"
        end
      end
    else
      exit
    end
  end

  def create_manage_route
    create_manage_route_menu
    choice = select_information
    case choice
    when 1
      station1 = select_information(print_all_stations) { 'Выберите начальную станцию' }
      station2 = select_information { 'Выберите конечную станцию' }
      @routes << Route.new(@stations[station1], @stations[station2])
      puts "Маршрут #{@routes.last.name} успешно создан"
    when 2
      edit_route_stations(0) { 'Выберите станцию которую хотите добавить в путь' }
    when 3
      edit_route_stations(1) { 'Выберите станцию которую хотите удалить' }
    else
      exit
    end
  end

  def edit_route_stations(method)
    route = select_information(print_all_routes) { 'Выберите путь который хотите изменить' }
    puts yield
    station = select_information(print_all_stations)
    station_object = @stations[station]
    if method.zero?
      @routes[route].add_way_station(station_object)
      puts "К маршруту добавлена станция: #{station_object.name}."
    elsif method == 1
      @routes[route].delete_way_station(station_object)
      puts "Из маршрута удалена станция: #{station_object.name}."
    end
  end

  def choice_route
    train = select_information(print_all_trains) { 'Выберите поезд' }
    route = select_information(print_all_routes) { 'Выберите маршрут' }
    @trains[train].take_route(@routes[route])
    puts "Для поезда #{@trains[train].number} установлен маршрут: #{@routes[route].name}"
  end

  def print_all_carriages
    @carriages.map(&:number).each_with_index { |number, index| p "#{index} - #{number}" }
  end

  def print_all_trains
    @trains.map(&:number).each_with_index { |number, index| p "#{index} - #{number}" }
  end

  def print_all_routes
    @routes.map(&:name).each_with_index { |name, index| p "#{index} - #{name}" }
  end

  def print_all_stations
    @stations.map(&:name).each_with_index { |name, index| p "#{index} - #{name}" }
  end

  def select_information(_info = nil, type = 'number')
    puts yield if block_given?
    information = gets.chomp
    if type == 'number'
      # info, type, name, length, example = hash[:info], hash[:type], hash[:name], hash[:length], hash[:example]
      validate!(info: information, type: 'number', name: :choice, length: 1, example: 2)
    elsif type == 'station'
      validate!(info: information, type: 'text', name: :station_name, length: 5, example: 'Минск(русские буквы и дефисы)')
    elsif type.include? %w[carriage train]
      validate!(info: information, type: 'text', name: :train_carriage_number, length: 5, example: '(123-22)')
    elsif type == 'volume'
      validate!(info: information, type: 'number', name: :carriage_volume, length: -3, example: 24)
    end
  end

  def train_list_at_the_station_menu
    puts '________________________________________________________________'
    puts '| 1 - Список всех поездов                                      |'
    puts '| 2 - Список поездов на станции                                |'
    puts '| 0 - Выход                                                    |'
    puts '________________________________________________________________'
  end

  def drive_next_previous_menu
    puts '________________________________________________________________'
    puts '| 1 - Ехать вперед                                             |'
    puts '| 2 - Ехать назад                                              |'
    puts '| 0 - Выход                                                    |'
    puts '________________________________________________________________'
  end

  def carriage_menu
    puts '________________________________________________________________'
    puts '| 1 - Создать грузовой вагон                                   |'
    puts '| 2 - Создать пассажирский вагон                               |'
    puts '| 3 - Кол-во мест/объема у вагона                              |'
    puts '| 4 - Занять место/объем у вагона                              |'
    puts '| 5 - Кол-во занятых мест/объема у вагона                      |'
    puts '| 6 - Кол-во свободных мест/объема у вагона                    |'
    puts '| 0 - Выход                                                    |'
    puts '________________________________________________________________'
  end

  def station_control_menu
    puts '________________________________________________________________'
    puts '| 1 - Создать станцию                                          |'
    puts '| 2 - Вывести список всех поездов на станции                   |'
    puts '| 0 - Выход                                                    |'
    puts '________________________________________________________________'
  end

  def main_menu
    puts '________________________________________________________________'
    puts '| 1 -  Управление станциями                                    |'
    puts '| 2 -  Создать поезд                                           |'
    puts '| 3 -  Создать маршрут и упралять станциями в нем              |'
    puts '| 4 -  Назначить маршрут поезду                                |'
    puts '| 5 -  Прицепить вагон к поезду                                |'
    puts '| 6 -  Отцепить вагон от поезда                                |'
    puts '| 7 -  Перемещать поезд по маршруту вперед назад               |'
    puts '| 8 -  Просмотреть список поездов или список поездов на станции|'
    puts '| 9 -  Управление вагонами                                     |'
    puts '| 0 - Выход                                                    |'
    puts '________________________________________________________________'
  end

  def create_manage_route_menu
    puts '________________________________________________________________'
    puts '| 1 - Создать маршрут                                          |'
    puts '| 2 - Добавить станцию в маршрут                               |'
    puts '| 3 - Удалить станцию из маршрута                              |'
    puts '| 0 - Выход                                                    |'
    puts '________________________________________________________________'
  end

  def create_train_menu
    puts '________________________________________________________________'
    puts '| 1 - Создать пассажирский поезд                               |'
    puts '| 2 - Создать грузовой поезд                                   |'
    puts '| 3 - Вывести список всех  вагонов у поезда                    |'
    puts '| 2 - Создать грузовой поезд                                   |'
    puts '| 0 - Выход                                                    |'
    puts '________________________________________________________________'
  end
end

menu = Menu.new
menu.chomp_information
