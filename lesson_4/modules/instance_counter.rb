# init commit fo InstanceCounter module
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  # commit
  module ClassMethods
    def instances
      @instances ||= 0
    end

    def instances_increment
      @instances ||= 0
      @instances += 1
    end
  end
  # commit
  module InstanceMethods
    protected

    def register_instance
      self.class.instances_increment
    end
  end
end
