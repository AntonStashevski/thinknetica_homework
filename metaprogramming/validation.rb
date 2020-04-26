# frozen_string_literal: true

module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation
    def validate(name, type, *params)
      @validation ||= []
      @validation << {name: name, type: type, params: params}
    end
  end

  module InstanceMethods

    def presence(name, _blank)
      raise 'Аргумент не существует.' if name.nil? || name.empty?
    end

    def format(name, params)
      binding.pry
      raise 'Аргумент не соответствует формату.' if name !~ params.first
    end

    def type(name, params)
      raise 'Аргумент не соответствует типу.' unless name.is_a?(params.first)
    end

    def validate!
      self.class.validation.each do |validation|
        send validation[:type], instance_variable_get("@#{validation[:name]}"), validation[:params]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

  end

end
