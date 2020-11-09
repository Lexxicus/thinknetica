# init commit
class Interface
  include Ask
  def initialize
    @routes = {}
  end
  COMMANDS_LIST = { '1' => :create_station, '2' => :create_train,
                    '3' => :route_management, '4' => :assign_route,
                    '5' => :add_wagon_to_train, '6' => :remove_wagon_to_train,
                    '7' => :move_train, '8' => :trains_on_station,
                    '9' => :list_of_wagons, '10' => :put_in_wagon,
                    '11' => :seed, 'exit' => :exit_programm }.freeze
  def start
    puts %(
      exit. Выход
      1. Создать станцию
      2. Создать поезд
      3. Управление маршрутами
      4. Назначить маршрут поезду
      5. Добавить вагон к поезду
      6. Отцепить вагон от поезда
      7. Перемещать поезд по маршруту
      8. Просмотреть список поездов на станции
      9. Посмотреть состав поезда
      10. Занимать место или объем в вагоне
    )

    loop do
      puts 'Введите номер команды:'
      send(COMMANDS_LIST[gets.chomp])
    end
  end

  protected

  def exit_programm
    abort
  end

  def create_station
    station = Station.new(ask('Укажите название будующей станции:'))
    puts "Построена станция #{station.name}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    puts 'Для пассажирского поезда введите 1, для грузового 2'
    type = gets.to_i
    train = PassangerTrain.new(ask('Укажите номер поезда:')) if type == 1
    train = CargoTrain.new(ask('Укажите номер поезда:')) if type == 2
    puts "Создан #{train.type == :passanger ? 'пассажирский' : 'грузовой'} поезд."
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    starting_station = Station.stations[ask('Начальная станция: ')]
    end_station = Station.stations[ask('Конечная станции: ')]
    if starting_station.nil? || end_station.nil?
      puts 'Такой станции не существует'
    else
      route_name = "#{starting_station.name}-#{end_station.name}"
      @routes[route_name] = Route.new(starting_station.name, end_station.name)
      puts "Маршрут #{route_name} создан"
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def filling_route
    route_name = ask('Введите название маршрута для редактирования')
    if @routes[route_name].nil?
      puts 'Маршрут не создан'
    else
      input = ask('Укажите название станции:')
      if Station.stations[input].nil?
        puts 'Станция не создана'
      else
        command = ask('Введите add для добавления станции, remove для удаления')
        @routes[route_name].add_station(Station.stations[input]) if command == 'add'
        @routes[route_name].del_station(Station.stations[input]) if command == 'remove'
      end
    end
  end

  def route_management
    choice = ask('Для создания маршрута введите 1, для редактирования 2')
    case choice
    when 1
      create_route
    when 2
      filling_route
    end
  end

  def assign_route
    number = ask('Укажите номер поезда для назначения на маршрут: ')
    route_name = ask('Укажите название маршрута: ')
    train = Train.find(number)
    if train.nil?
      puts 'Поезд с таким номером не существует'
    elsif @routes[route_name].nil?
      puts 'Маршрут не задан'
    else
      puts train(number).add_route(@routes[route_name])
    end
  end

  def add_wagon_to_train
    number = ask('Укажите номер поезда')
    train = Train.find(number)
    if train.nil?
      puts 'Поезд с таким номером не существует'
    else
      puts "Укажите #{train.type == :passanger ? 'кол-во мест' : 'объём'} вагона"
      value = gets.to_i
      train.add_wagon(PassangerWagon.new(value)) if train.type == :passanger
      tarin.add_wagon(CargoWagon.new(value)) if train.type == :cargo
    end
  end

  def remove_wagon_to_train
    number = ask('Укажите номер поезда')
    train = Train.find(number)
    if train.nil?
      puts 'Поезд с таким номером не существует'
    elsif train.wagons.empty?
      puts 'У поезда нет вагонов'
    else
      train.remove_wagon
    end
  end

  def move_train
    number = ask('Укажите номер поезда')
    train = Train.find(number)
    if train.nil?
      puts 'Поезд с таким номером не существует'
    else
      direction = ask('Задайте на правление вперёд или назад')
      train.move_forward if direction == 'вперёд'
      train.move_back if direction == 'назад'
      puts "Поезд на станции #{train.current_station}"
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def trains_on_station
    station_name = ask('Введите название станции:')
    if Station.stations[station_name].nil?
      puts 'Станция не создана'
    else
      t_list = proc do |train|
        puts "Поезд № #{train.number},
              #{train.type == :passanger ? 'пассажирский' : 'грузовой'},
              вагонов #{train.wagons.size} "
      end
      puts 'Поезда на станции: '
      Station.stations[station_name].trains_list(&t_list)
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def list_of_wagons
    number = ask('Введите номер поезда:')
    train = Train.find(number)
    if train.nil?
      puts 'Поезда с таким номером не существует'
    else
      w_list = proc do |wagon|
        if wagon.type == :passanger
          puts "Вагон №#{wagon.wagon_number},
                свободных мест: #{wagon.free_places},
                занятых: #{wagon.occupied_places}"
        else
          puts "Вагон №#{wagon.wagon_number}, объём: #{wagon.volume},
                занято: #{wagon.filled_in}"
        end
      end
      puts 'Перечень вагонов подвижного состава: '
      train.wagons_list(&w_list)
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def put_in_wagon
    number = ask('Введите номер поезда:')
    train = Train.find(number)
    if train.nil? || train.wagons.empty?
      puts 'Поезд Шредингера'
    else
      puts 'Введите номер вагона'
      wagon_number = gets.to_i
      raise 'нет такого вагона' if train.wagons[wagon_number].nil?
      train.wagons[wagon_number].take_the_place if train.type == :passanger
      train.wagons[wagon_number].load_wagon(1) if train.type == :cargo
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def seed
    Station.new('kgn')
    Station.new('ekb')
    Station.new('che')
    Station.new('msk')
    cr = CargoTrain.new('12467')
    pr = PassangerTrain.new('12342')
    10.times { cr.add_wagon(CargoWagon.new(20)) }
    10.times { pr.add_wagon(PassangerWagon.new(37)) }
    Station.stations['kgn'].add_train(pr)
    Station.stations['kgn'].add_train(cr)
    pr.add_route(@routes['kgn-msk'] = Route.new(Station.stations['kgn'], Station.stations['msk']))
    @routes['msk-kgn'] = Route.new(Station.stations['msk'], Station.stations['kgn'])
  end
end
