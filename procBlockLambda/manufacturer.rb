# frozen_string_literal: true

# Manufacturer
module Manufacturer
  attr_reader :manufacturer

  def take_manufacturer(manufacturer)
    self.manufacturer = manufacturer
  end

  protected

  attr_writer :manufacturer
end
