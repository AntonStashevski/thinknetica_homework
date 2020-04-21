# frozen_string_literal: true

# Validate
module Validate
  TRY_COUNT = 3

  REGULAR_EXPRESSIONS = {
    'choise' => /^[0-9]{1,2}$/.freeze,
    'station_name' => /^[а-я]+-*[а-я]+$/i.freeze,
    'carriage_volume' => /^\d{1,3}$/.freeze,
    'train_carriage_number' => /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/.freeze
  }.freeze

  def validate!(attempt = 0, information, type, name, length, example)
    raise "Значение '#{name}' должно быть в формате строки" unless information.is_a? String

    if length.positive?
      raise "Значение '#{name}' не может иметь длинну меньше #{length} символов" if information.size < length
    elsif length.zero?
      raise "Значение '#{name}' не может быть пустым" unless information.any?
    else
      raise "Значение '#{name}' не может иметь длинну более #{length.abs} символов" if information.size > length.abs
    end
    raise "Значение '#{name}' имеет неправильный формат например: #{example}" if information !~ REGULAR_EXPRESSIONS[name]

    type == 'number' ? information.to_i : information
  rescue StandardError => e
    if attempt < TRY_COUNT
      puts "#{e.message} \nОсталось | #{TRY_COUNT - attempt} | попыток"
      attempt += 1
      puts "Введите корректное значение #{name}"
      information = gets.chomp
      retry
    else
      raise e.message
    end
  end
end
