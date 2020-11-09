# init commit
module MenuTrain
  protected

  def create_train
    type = ask('Для пассажирского поезда введите 1, для грузового 2').to_i
    train = PassangerTrain.new(ask('Укажите номер поезда:')) if type == 1
    train = CargoTrain.new(ask('Укажите номер поезда:')) if type == 2
    puts "Создан #{train.type == :passanger ? 'пассажирский' : 'грузовой'} поезд."
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def wagon_type(train, value)
    if train.type == :passanger
      train.add_wagon(PassangerWagon.new(value))
    else
      tarin.add_wagon(CargoWagon.new(value))
    end
  end

  def add_wagon_to_train
    number = ask('Укажите номер поезда')
    train = Train.find(number)
    raise 'Поезд с таким номером не существует' if train.nil?
    puts "Укажите #{train.type == :cargo ? 'объём' : 'кол-во мест'} вагона"
    value = gets.to_i
    wagon_type(train, value)
  rescue RuntimeError => e
    puts e.message
    retry
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
    raise 'Поезд с таким номером не существует' if train.nil?
    direction = ask('Задайте на правление вперёд или назад')
    train.move_forward if direction == 'вперёд'
    train.move_back if direction == 'назад'
    puts "Поезд на станции #{train.current_station}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def wagons_block(train)
    w_list = proc do |wagon|
      if wagon.type == :passanger
        puts "Вагон № #{wagon.wagon_number} свободных мест: #{wagon.free_places}, занятых: #{wagon.occupied_places}"
      else
        puts "Вагон №#{wagon.wagon_number}, объём: #{wagon.volume}, занято: #{wagon.filled_in}"
      end
    end
    train.wagons_list(&w_list)
  end

  def list_of_wagons
    number = ask('Введите номер поезда:')
    train = Train.find(number)
    raise 'Нет такого поезда' if train.nil?
    puts 'Перечень вагонов подвижного состава: '
    wagons_block(train)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def add_wagon_by_type(train, wagon_number)
    raise 'Не верный номер вагона' if train.wagons[wagon_number].nil?
    if train.type == :passanger
      train.wagons[wagon_number].take_the_place(1)
    else
      train.wagons[wagon_number].load_wagon(1)
    end
  end

  def put_in_wagon
    number = ask('Введите номер поезда:')
    train = Train.find(number)
    raise 'Поезд Шредингера' if train.nil? || train.wagons.empty?
    wagon_number = ask('Введите номер вагона')
    add_wagon_by_type(train, wagon_number)
  rescue RuntimeError => e
    puts e.message
    retry
  end
end
