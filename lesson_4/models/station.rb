# Station class
class Station
  include InstanceCounter
  include Validation
  include Accessors
  attr_accessor_with_history :name, :trains
  def self.stations
    @stations ||= {}
  end

  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.stations[@name] = self
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def trains_by_type
    passanger = []
    cargo = []
    @trains.each do |train|
      if train.type == :passanger
        passanger << train
      else
        cargo << train
      end
    end
    { passanger: passanger, cargo: cargo }
  end

  def del_train(train)
    @trains.delete(train)
  end

  def trains_list
    @trains.each { |tarin| yield(tarin) }
  end

  #  protected

  #  def validate!
  #    raise 'Name should be atleast 3 symbols lengrh' if name.size < 3
  #  end
end
