# frozen_string_literal: true

# Accessors
module Accessors
  def self.included(base)
    base.extend AccessorHistory, StrongAccessor
  end

  module AccessorHistory
    def attr_accessor_with_history(*names)
      names.each do |name|
        history_name = "@#{name}_history".to_sym
        get_set_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(get_set_name) }
        define_method("#{name}_history".to_sym) { instance_variable_get(history_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(get_set_name, value)
          if instance_variable_get(history_name).nil?
            instance_variable_set(history_name, [value])
          else
            instance_variable_set(history_name, [instance_variable_get(history_name), value].flatten)
          end
        end
      end
    end
  end

  module StrongAccessor
    def strong_attr_accessor(name, attr_class)
      get_set_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(get_set_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Bad class!!!' unless value.is_a?(attr_class)

        instance_variable_set(get_set_name, value)
      end
    end
  end
end

class Test
  include Accessors
end

# test = Test.new
# Test.attr_accessor_with_history :a
# test.a = 1
# test.a = 2
# test.a = 3
# p test.a_history
# Test.strong_attr_accessor :b, Fixnum
# test.b = 100
# p test.b
# test.b = '999'
