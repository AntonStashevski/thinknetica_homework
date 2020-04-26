# frozen_string_literal: true

# TrainCargo
class TrainCargo < Train

  validate :number, :presence
  validate :number, :format, /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/

  def initialize(number)
    super
    validate!
    @type = 'cargo'
    register_instance
  end
end
