# frozen_string_literal: true

# CarriageCargo
class CarriageCargo < Carriage
  def initialize(number)
    super
    @type = 'cargo'
  end
end
