# Station class
class Station
  include InstanceCounter
  attr_reader :name, :trains
  def self.stations
    @stations || {}
  end

  def initialize(name)
    @name = name
    @trains = []
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
end
