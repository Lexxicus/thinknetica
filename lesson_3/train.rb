# initial class commit
class Train
  attr_reader :number, :type, :wagons, :speed, :current_station, :route

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    @current_station = 0
  end

  def speed_up
    @speed = 60
  end

  def break
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed.zero?
  end

  def remove_wagon
    @wagons -= 1 if @speed.zero?
  end

  def add_route(route)
    @route = route
    @route.starting_station.add_train(self)
    @current_station = @route.starting_station
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
      puts 'Маршрут не задан'
    elsif next_station
      @current_station.del_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    else
      puts 'Поезд прибыл на конечную станцию'
    end
  end

  def move_back
    if @route.nil?
      puts 'Маршрут не задан'
    elsif prev_station
      @current_station.del_train(self)
      @current_station = prev_station
      @current_station.add_train(self)
    else
      puts 'Начальная точка маршрута'
    end
  end

  def print_stations
    if @route
      puts "Предыдущая станция: #{prev_station.name}" unless prev_station.nil?
      puts "Поезд находится тут: #{@current_station.name}"
      puts "Следующая станция: #{next_station.name}" unless next_station.nil?
    else
      puts 'Маршрут не задан'
    end
  end
end
