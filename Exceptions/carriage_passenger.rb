# frozen_string_literal: true

# CarriagePassenger
class CarriagePassenger < Carriage
  def initialize(number)
    super
    @type = 'passenger'
  end
end
