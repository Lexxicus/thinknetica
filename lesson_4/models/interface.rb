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
      8. Просмотреть список поездов на станции
      9. Посмотреть состав поезда
      10. Занимать место или объем в вагоне
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
        trains_on_station
      when 9
        list_of_wagons
      when 10
        put_in_wagon
      when 11
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
      puts "Укажите #{Train.find(number).type == :passanger ? 'количество посадочных мест' : 'грузоподъемность'} вагона"
      value = gets.to_i
      puts Train.find(number).add_wagon(PassangerWagon.new(value)) if Train.find(number).type == :passanger
      puts Train.find(number).add_wagon(CargoWagon.new(value)) if Train.find(number).type == :cargo
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
      puts "Поезд на станции #{Train.find(number).current_station}"
    end
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def trains_on_station
    puts 'Введите название станции:'
    station_name = gets.chomp
    if Station.stations[station_name].nil?
      puts 'Станция не создана'
    else
      t_list = proc do |train| 
        puts "Поезд № #{train.number}, #{train.type == :passanger ? 'пассажирский' : 'грузовой'}, вагонов #{train.wagons.size} "
      end
      puts 'Поезда на станции: '
      Station.stations[station_name].trains_list(&t_list)
    end
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def list_of_wagons
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    if Train.find(train_number).nil?
      puts 'Поезда с таким номером не существует'
    else
      w_list = proc do |wagon|
        if wagon.type == :passanger
          puts "Вагон №#{wagon.wagon_number}, свободных мест: #{wagon.free_places}, занятых: #{wagon.occupied_places}"
        else
          puts "Вагон №#{wagon.wagon_number}, объём: #{wagon.volume}, занято: #{wagon.filled_in}"
        end
      end
      puts 'Перечень вагонов подвижного состава: '
      Train.find(train_number).wagons_list(&w_list)
    end
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end

  def put_in_wagon
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    train = Train.find(train_number)
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
    puts "#{e.message}"
    retry
  end

  def seed
    Station.new('kgn')
    Station.new('ekb')
    Station.new('ekb')
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
