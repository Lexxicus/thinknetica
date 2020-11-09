# initial class commit
class Train
  include InstanceCounter
  include Valid
  attr_reader :number, :type, :wagons, :speed, :current_station, :route
  @@trains = {}
  REGEXP_TRAIN_NUMBER = /^[a-z0-9]{3}-*[0-9]{2}/i

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = {}
    @speed = 0
    @route = nil
    @current_station = 0
    validate!
    @@trains[@number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def self.all
    @@tarins
  end

  def add_route(route)
    @route = route
    @route.starting_station.add_train(self)
    @current_station = @route.starting_station
  end

  def speed_up
    @speed = max_train_speed
  end

  def break
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons[wagon.wagon_number] = wagon if wagon.type == @type
    wagon
  end

  def wagons_list(&block)
    @wagons.each_value { |wagon| yield(wagon) }
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon)
  end

  def next_station
    index = @route.stations.index(@current_station)
    @route.stations[index + 1] if index <= @route.stations.size
  end

  def prev_station
    index = @route.stations.index(@current_station)
    return if index.zero?
    @route.stations[index - 1]
  end

  def move_forward
    raise 'Поезд на конечной станции' unless next_station
    @current_station.del_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_back
    raise 'Начало маршрута' unless prev_station
    @current_station.del_train(self)
    @current_station = prev_station
    @current_station.add_train(self)
  end

  def print_stations
    [prev_station.name ||= 0, @current_station.name, next_station.name ||= 0]
  end

  protected

  def validate!
    raise 'Number format: XXXXX or XXX-XX' if number !~ REGEXP_TRAIN_NUMBER
  end

  def max_train_speed
    50
  end
end
