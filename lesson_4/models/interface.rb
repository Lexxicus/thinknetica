# init commit
class Interface
  include MenuStation
  include MenuTrain
  include MenuRoute
  include Ask
  def initialize
    @routes = {}
  end
  COM_LIST = {
    '1' => { label: 'Создать станцию', func: :create_station },
    '2' => { label: 'Создать поезд', func: :create_train },
    '3' => { label: 'Управление маршрутами', func: :route_management },
    '4' => { label: 'Назначить маршрут поезду', func: :assign_route },
    '5' => { label: 'Добавить вагон к поезду', func: :add_wagon_to_train },
    '6' => { label: 'Отцепить вагон от поезда', func: :remove_wagon_to_train },
    '7' => { label: 'Перемещать поезд по маршруту', func: :move_train },
    '8' => { label: 'Список поездов на станции', func: :trains_on_station },
    '9' => { label: 'Посмотреть состав поезда', func: :list_of_wagons },
    '10' => { label: 'Занимать место или объем в вагоне', func: :put_in_wagon },
    '11' => { label: 'test', func: :seed },
    'exit' => { label: 'Выход', func: :exit_programm }
  }.freeze
  def start
    COM_LIST.each do |key, label|
      puts "#{key}. #{label[:label]}"
    end

    loop do
      puts 'Введите номер команды:'
      send(COM_LIST[gets.chomp][:func])
    end
  end

  protected

  def exit_programm
    abort
  end

  def seed
    Station.new('kgn')
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
