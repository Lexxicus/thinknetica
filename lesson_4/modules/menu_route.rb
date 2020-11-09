# init commit
module MenuRoute
  protected

  ROUTE_MNG = { '1' => { label: 'Создать маршрут', func: :create_route },
                '2' => { label: 'Редактировать маршрут', func: :filling_route } }.freeze
  def create_route
    starting_station = Station.stations[ask('Начальная станция: ')]
    end_station = Station.stations[ask('Конечная станции: ')]
    raise 'Cтанция не существует' if starting_station.nil? || end_station.nil?
    route_name = "#{starting_station.name}-#{end_station.name}"
    @routes[route_name] = Route.new(starting_station.name, end_station.name)
    puts "Маршрут #{route_name} создан"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def filling_route
    route_name = ask('Введите название маршрута')
    input = ask('Укажите название станции:')
    command = ask('Введите add для добавления станции, rm для удаления')
    route = @routes[route_name]
    station = Station.stations[input]
    command == 'add' ? route.add_station(station) : route.del_station(station)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def route_management
    ROUTE_MNG.each do |key, label|
      puts "#{key}. #{label[:label]}"
    end

    loop do
      puts 'Введите команду'
      send(ROUTE_MNG[gets.chomp][:func])
      break
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
end
