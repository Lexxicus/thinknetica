# init commit
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  # commit
  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(name, method, args = nil)
      validations << { name: name, method: method, args: args }
    end
  end
  # commit
  module InstanceMethods
    attr_reader :array
    def validate!
      self.class.validations.each do |validation|
        variable = instance_variable_get("@#{validation[:name]}".to_sym)
        send validation[:method], variable, validation[:args]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def presence(variable, _args)
      raise 'Значение не может быть пустым' if variable.nil? || variable.size < 3
    end

    def format(variable, args)
      raise 'Значение не соответствует регулярному выражению ' if variable !~ args
    end

    def type(variable, args)
      raise 'Не верный класс переменной' if variable.class.to_s != args
    end
  end
end
