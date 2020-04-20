# frozen_string_literal: true

# CarriagePassenger
class CarriagePassenger < Carriage
  def initialize
    super
    @type = 'passenger'
  end
end
