# init commit
class Interface
  def initialize
    @stations = {}
    @trains = {}
    @routes = {}
  end

  def start
    puts %(
      123. Выход
      1. Создать станцию
      2. Создать поезд
      3. Управление маршрутами
      4. Назначить маршрут поезду
      5. Добавить вагон к поезду
      6. Отцепить вагон от поезда
      7. Перемещать поезд по маршруту
      8. Просмотреть список станций и список поездов на станции
    )

    loop do
      puts 'Введите номер команды:'
      choice = gets.to_i
      case choice
      when 123
        break
      when 1
        create_station
      when 2
        create_train
      when 3
        route_management
      when 4
        assign_route
      when 5
        add_wagon_to_train
      when 6
        remove_wagon_to_train
      when 7
        move_train
      when 8
        list_of_stations_trains
      end
    end
  end

  protected

  def create_station
    puts 'Укажите название будующей станции:'
    name = gets.chomp
    @stations[name] = Station.new(name)
    puts "Построена станция #{name}"
  end

  def create_train
    puts 'Укажите номер создоваемого поезда:'
    number = gets.chomp
    puts 'Для пассажирского поезда введите 1, для грузового 2'
    type = gets.to_i
    @trains[number] = PassangerTrain.new(number) if type == 1
    @trains[number] = CargoTrain.new(number) if type == 2
  end

  def create_route
    puts 'Укажите название начальной станции: '
    starting_station = gets.chomp
    puts 'Укажите название конечной станции: '
    end_station = gets.chomp
    if @stations[starting_station].nil?
      puts "Такой станции #{starting_station} не существует"
    elsif @stations[end_station].nil?
      puts "Такой станции #{end_station} не существует"
    else
      route_name = "#{starting_station}-#{end_station}"
      @routes[route_name] = Route.new(@stations[starting_station], @stations[end_station])
      puts "Маршрут #{route_name} создан"
    end
  end

  def filling_route
    puts 'Введите название маршрута для редактирования'
    route_name = gets.chomp
    if @routes[route_name].nil?
      puts 'Маршрут не создан'
    else
      puts 'Укажите название станции:'
      input = gets.chomp
      if @stations[input].nil?
        puts 'Станция не создана'
      else
        puts 'Введите add для добавления станции, remove для удаления'
        command = gets.chomp
        @routes[route_name].add_station(@stations[input]) if command == 'add'
        @routes[route_name].del_station(@stations[input]) if command == 'remove'
      end
    end
  end

  def route_management
    puts 'Для создания маршрута введите 1, для редактирования 2'
    choice = gets.to_i
    case choice
    when 1
      create_route
    when 2
      filling_route
    end
  end

  def assign_route
    puts 'Укажите номер поезда для назначения на маршрут: '
    number = gets.chomp
    puts 'Укажите название маршрута: '
    route_name = gets.chomp
    if @trains[number].nil?
      puts 'Поезд с таким номером не существует'
    elsif @routes[route_name].nil?
      puts 'Маршрут не задан'
    else
      puts @trains[number].add_route(@routes[route_name])
    end
  end

  def add_wagon_to_train
    puts 'Укажите номер поезда'
    number = gets.chomp
    if @trains[number].nil?
      puts 'Поезд с таким номером не существует'
    else
      puts @trains[number].add_wagon(PassangerWagon.new) if @trains[number].type == :passanger
      puts @trains[number].add_wagon(CargoWagon.new) if @trains[number].type == :cargo
    end
  end

  def remove_wagon_to_train
    puts 'Укажите номер поезда'
    number = gets.chomp
    if @trains[number].nil?
      puts 'Поезд с таким номером не существует'
    elsif @trains[number].wagons.empty?
      puts 'У поезда нет вагонов'
    else
      @trains[number].remove_wagon
    end
  end

  def move_train
    puts 'Укажите номер поезда'
    number = gets.chomp
    if @trains[number].nil?
      puts 'Поезд с таким номером не существует'
    else
      puts 'Для движения по маршруту задайте на правление вперёд или назад'
      direction = gets.chomp
      puts @trains[number].move_forward if direction == 'вперёд'
      puts @trains[number].move_back if direction == 'назад'
    end
  end

  def list_of_stations_trains
    puts "Всего станций #{@stations.size}, названия:"
    @stations.each_key { |station_name| puts station_name }
    puts "Всего поездов #{@trains.size}, номера: "
    @trains.each_key { |train_number| puts train_number }
  end
end
