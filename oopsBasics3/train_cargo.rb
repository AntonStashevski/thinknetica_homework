# frozen_string_literal: true

# TrainCargo
class TrainCargo < Train
  def initialize
    super
    @type = 'cargo'
  end
end
