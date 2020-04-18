# frozen_string_literal: true

# TrainPassenger
class TrainPassenger < Train
  def initialize
    super
    @type = 'passenger'
  end
end
