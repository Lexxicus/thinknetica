# Station class
class Station
  include InstanceCounter
  include Valid
  attr_reader :name, :trains
  def self.stations
    @stations ||= {}
  end

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

  def trains_list(&block)
    raise 'На станции нет поездов' if @trains.empty?
    @trains.each { |tarin| yield(tarin) }
  end

  protected

  def validate!
    raise 'Name should be atleast 3 symbols lengrh' if name.size < 3
  end
end
