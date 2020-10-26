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

  def move_forward
    if !@route.next_station(@current_station).nil?
      @current_station.del_train(self)
      @current_station = @route.next_station(@current_station)
      @current_station.add_train(self)
    else
      puts 'Поезд прибыл на конечную станцию'
    end
  end

  def move_back
    if !@route.prev_station(@current_station).nil?
      @current_station.del_train(self)
      @current_station = @route.prev_station(@current_station)
      @current_station.add_train(self)
    else
      puts 'Начальная точка маршрута'
    end
  end

  def print_station
    if !@route.nil?
      prev = @route.prev_station(@current_station)
      nxt = @route.next_station(@current_station)
      puts "Предыдущая станция: #{prev.name}" if !prev.nil?
      puts "Поезд находится тут: #{@current_station.name}"
      puts "Следующая станция: #{nxt.name}" if !nxt.nil?
    else
      puts 'no route'
    end
  end
end
