# frozen_string_literal: true

# Validate
module Validate
  TRY_COUNT = 3

  REGULAR_EXPRESSIONS = {
    choice: /^[0-9]{1,2}$/.freeze,
    station_name: /^[а-я]+-*[а-я]+$/i.freeze,
    carriage_volume: /^\d{1,3}$/.freeze,
    train_carriage_number: /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/.freeze
  }.freeze

  def validate!(hash, attempt = 0)
    info ||= hash[:info]
    type ||= hash[:type]
    name ||= hash[:name]
    length ||= hash[:length]
    example ||= hash[:example]

    raise "Значение '#{name}' должно быть в формате строки" unless info.is_a? String

    if length.positive?
      raise "Значение '#{name}' не может иметь длинну меньше #{length} символов" if info.size < length
    elsif length.zero?
      raise "Значение '#{name}' не может быть пустым" unless info.any?
    elsif info.size > length.abs
      raise "Значение '#{name}' не может иметь длинну более #{length.abs} символов"
    end

    raise "Значение '#{name}' имеет неправильный формат например: #{example}" if info !~ REGULAR_EXPRESSIONS[name]

    type == 'number' ? info.to_i : info
  rescue StandardError => e
    raise e.message unless attempt < TRY_COUNT

    puts "#{e.message} \nОсталось | #{TRY_COUNT - attempt} | попыток"
    attempt += 1
    puts "Введите корректное значение #{name}"
    info = gets.chomp
    retry
  end
end
