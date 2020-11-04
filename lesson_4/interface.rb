# init commit
class Interface
  def initialize
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
      when 9
        instances
      when 10
        seed
      end
    end
  end

  protected

  def create_station
    puts 'Укажите название будующей станции:'
    name = gets.chomp
    Station.new(name)
    puts "Построена станция #{name}"
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def create_train
    puts 'Укажите номер создоваемого поезда:'
    number = gets.chomp
    puts 'Для пассажирского поезда введите 1, для грузового 2'
    type = gets.to_i
    train = PassangerTrain.new(number) if type == 1
    train = CargoTrain.new(number) if type == 2
    puts "Создан #{train.type == :passanger ? 'пассажирский' : 'грузовой'} поезд № #{number}"
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def create_route
    puts 'Укажите название начальной станции: '
    starting_station = gets.chomp
    puts 'Укажите название конечной станции: '
    end_station = gets.chomp
    if Station.stations[starting_station].nil?
      puts "Такой станции #{starting_station} не существует"
    elsif Station.stations[end_station].nil?
      puts "Такой станции #{end_station} не существует"
    else
      route_name = "#{starting_station}-#{end_station}"
      @routes[route_name] = Route.new(Station.stations[starting_station], Station.stations[end_station])
      puts "Маршрут #{route_name} создан"
    end
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def filling_route
    puts 'Введите название маршрута для редактирования'
    route_name = gets.chomp
    if @routes[route_name].nil?
      puts 'Маршрут не создан'
    else
      puts 'Укажите название станции:'
      input = gets.chomp
      if Station.stations.nil?
        puts 'Станция не создана'
      else
        puts 'Введите add для добавления станции, remove для удаления'
        command = gets.chomp
        @routes[route_name].add_station(Station.stations[input]) if command == 'add'
        @routes[route_name].del_station(Station.stations[input]) if command == 'remove'
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
    if Train.find(number).nil?
      puts 'Поезд с таким номером не существует'
    elsif @routes[route_name].nil?
      puts 'Маршрут не задан'
    else
      puts Train.find(number).add_route(@routes[route_name])
    end
  end

  def add_wagon_to_train
    puts 'Укажите номер поезда'
    number = gets.chomp
    if Train.find(number).nil?
      puts 'Поезд с таким номером не существует'
    else
      puts Train.find(number).add_wagon(PassangerWagon.new) if @trains[number].type == :passanger
      puts Train.find(number).add_wagon(CargoWagon.new) if @trains[number].type == :cargo
    end
  end

  def remove_wagon_to_train
    puts 'Укажите номер поезда'
    number = gets.chomp
    if Train.find(number).nil?
      puts 'Поезд с таким номером не существует'
    elsif Train.find(number).wagons.empty?
      puts 'У поезда нет вагонов'
    else
      Train.find(number).remove_wagon
    end
  end

  def move_train
    puts 'Укажите номер поезда'
    number = gets.chomp
    if Train.find(number).nil?
      puts 'Поезд с таким номером не существует'
    else
      puts 'Для движения по маршруту задайте на правление вперёд или назад'
      direction = gets.chomp
      puts Train.find(number).move_forward if direction == 'вперёд'
      puts Train.find(number).move_back if direction == 'назад'
    end
  end

  def list_of_stations_trains
    puts "Всего станций #{Station.stations.size}, названия:"
    Station.all.each_key { |station_name| puts station_name }
    puts "Всего поездов #{Train.tarins.size}, номера: "
    Train.all.each_key { |train_number| puts train_number }
  end

  def instances
    puts "Экземпляров класса Станция создано: #{Station.instances}"
    puts "Экземпляров класса Поезд создано: #{Train.instances}, pass #{PassangerTrain.instances}, cargo #{CargoTrain.instances}"
  end

  def seed
    Station.new('kgn')
    Station.new('ekb')
    Station.new('ekb')
    Station.new('msk')
    PassangerTrain.new('12345')
    CargoTrain.new('12467')
    @routes['kgn-msk'] = Route.new(Station.stations['kgn'], Station.stations['msk'])
    @routes['msk-kgn'] = Route.new(Station.stations['msk'], Station.stations['kgn'])
  end
end
