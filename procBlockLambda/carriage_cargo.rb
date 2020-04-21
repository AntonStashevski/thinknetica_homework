# frozen_string_literal: true

# CarriageCargo
class CarriageCargo < Carriage
  def initialize(number, volume)
    super
    @type = 'cargo'
  end
end
