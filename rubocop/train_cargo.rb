# frozen_string_literal: true

# TrainCargo
class TrainCargo < Train
  def initialize(number)
    super
    @type = 'cargo'
  end
end
