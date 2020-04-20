# frozen_string_literal: true

module Validate
  def self.included(base)
    base.send :include, ChoiceValidate
    base.send :include, StationNameValidate
    base.send :include, NumberValidate
  end

  module ChoiceValidate
    CHOICE_FORMAT = /^[0-9]{1,2}$/.freeze

    def validate_choice!(attempt = 0, information)
      raise 'Значение choice должно быть строкой' unless information.is_a? String
      raise 'Choice не может быть пустым' if information.empty?
      raise 'Choice имеет непраильный формат (только цифры)' if information !~ CHOICE_FORMAT

      information
    rescue StandardError => e
      if attempt < 3
        puts "#{e.message} \nОсталось #{3 - attempt} попыток"
        attempt += 1
        puts 'Введите корректный choice'
        information = gets.chomp
        retry
      else
        raise e.message
      end
    end
  end

  module StationNameValidate
    STATION_FORMAT = /^[а-я]+-*[а-я]+$/i.freeze

    def validate_station_object!(attempt = 0)
      raise 'Значение name должно быть строкой' unless name.is_a? String
      raise 'Длинна названия станции должна быть больше 3' if name.length < 3
      raise 'Станция имеет не правильный формат (только русские буквы и дефис)' if name !~ STATION_FORMAT
    rescue StandardError => e
      if attempt < 3
        puts "#{e.message} \nОсталось #{3 - attempt} попыток"
        attempt += 1
        puts 'Введите корректное название станции'
        self.name = gets.chomp
        retry
      else
        raise e.message
      end
    end

    def valid_station_object?
      validate_station_object!(5)
      true
    rescue StandardError
      false
    end

    def validate_station_name!(attempt = 0, information)
      raise 'Значение name должно быть строкой' unless information.is_a? String
      raise 'Длинна названия станции должна быть больше 3' if information.length < 3
      raise 'Станция имеет не правильный формат (только русские буквы и дефис)' if information !~ STATION_FORMAT

      information
    rescue StandardError => e
      if attempt < 3
        puts "#{e.message} \nОсталось #{3 - attempt} попыток"
        attempt += 1
        puts 'Введите корректное название станции'
        information = gets.chomp
        retry
      else
        raise e.message
      end
    end
  end

  module NumberValidate
    NUMBER_FORMAT = /^\S{3}-*\S{2}$/.freeze

    def validate_train_carriage_object_number!(attempt = 0)
      raise 'Значение number должно быть строкой' unless number.is_a? String
      raise 'Длинна номера должна быть равна 5 символам' if number.length < 5
      raise 'Номер имеет неправильный формат должно быть например (123-22)' if number !~ NUMBER_FORMAT
    rescue StandardError => e
      if attempt < 3
        puts "#{e.message} \nОсталось #{3 - attempt} попыток"
        attempt += 1
        puts 'Введите корректный номер'
        self.number = gets.chomp
        retry
      else
        raise e.message
      end
    end

    def valid_train_carriage_number?
      validate_train_carriage_object_number!(5)
      true
    rescue StandardError
      false
    end

    def validate_train_carriage_number!(attempt = 0, information)
      raise 'Значение number должно быть строкой' unless information.is_a? String
      raise 'Длинна номера должна быть равна 5 символам' if information.length < 5
      raise 'Номер имеет неправильный формат должно быть например (123-22)' if information !~ NUMBER_FORMAT

      information
    rescue StandardError => e
      if attempt < 3
        puts "#{e.message} \nОсталось #{3 - attempt} попыток"
        attempt += 1
        puts 'Введите корректный номер'
        information = gets.chomp
        retry
      else
        raise e.message
      end
    end
  end
end
