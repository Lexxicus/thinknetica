# init commit
module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    @@history = {}
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @@history[name] ||= []
          @@history[name] << value
        end
        define_method("#{name}_history") { @@history[name] }
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Неверный тип переменной' if value.is_a?(type)
        instance_variable_set(var_name, value)
      end
    end
  end
end
