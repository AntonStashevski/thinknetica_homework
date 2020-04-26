# frozen_string_literal: true

# TrainPassenger
class TrainPassenger < Train

  validate :number, :presence
  validate :number, :format, /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/

  def initialize(number)
    super
    validate!
    @type = 'passenger'
    register_instance
  end
end
