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
    'Маршрут назначке'
  end

  def speed_up
    @speed = max_train_speed
  end

  def break
    @speed = 0
  end

  def add_wagon(wagon)
    if wagon.type == @type
      @wagons[wagon.wagon_number] = wagon
      'Вагон прицеплен к составу'
    else
      'Неверный тип вагона'
    end
  end

  def wagons_list(&block)
    raise 'Состав не укомлектован' if @wagons.empty?
    @wagons.each_value { |wagon| yield(wagon) }
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon)
    'Вагон отцеплен'
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
    if @route.nil?
      'Маршрут не задан'
    elsif next_station
      @current_station.del_train(self)
      @current_station = next_station
      @current_station.add_train(self)
      "Поезд прибыл на станцию #{@current_station.name}"
    else
      'Поезд прибыл на конечную станцию'
    end
  end

  def move_back
    if @route.nil?
      'Маршрут не задан'
    elsif prev_station
      @current_station.del_train(self)
      @current_station = prev_station
      @current_station.add_train(self)
      "Поезд прибыл на станцию #{@current_station.name}"
    else
      'Начальная точка маршрута'
    end
  end

  def print_stations
    if @route
      "Предыдущая станция: #{prev_station.name}" unless prev_station.nil?
      "Поезд находится тут: #{@current_station.name}"
      "Следующая станция: #{next_station.name}" unless next_station.nil?
    else
      'Маршрут не задан'
    end
  end

  protected

  def validate!
    raise 'Number format: XXXXX or XXX-XX' if number !~ REGEXP_TRAIN_NUMBER
  end

  def max_train_speed
    50
  end
end
