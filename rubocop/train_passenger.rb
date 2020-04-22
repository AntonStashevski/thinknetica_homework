# frozen_string_literal: true

# TrainPassenger
class TrainPassenger < Train
  def initialize(number)
    super
    @type = 'passenger'
  end
end
