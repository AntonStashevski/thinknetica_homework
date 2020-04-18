# frozen_string_literal: true

# CarriageCargo
class CarriageCargo < Carriage
  def initialize
    super
    @type = 'cargo'
  end
end
