# init commit
module MenuStation
  protected

  def create_station
    station = Station.new(ask('Укажите название будующей станции:'))
    puts "Построена станция #{station.name}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def trains_block(station_name)
    t_list = proc do |train|
      puts "Поезд № #{train.number}," \
      " #{train.type == :passanger ? 'пассажирский' : 'грузовой'}" \
      ", вагонов #{train.wagons.size}"
    end
    Station.stations[station_name].trains_list(&t_list)
  end

  def trains_on_station
    station_name = ask('Введите название станции:')
    raise 'Станция не создана' if Station.stations[station_name].nil?
    puts 'Поезда на станции: '
    trains_block(station_name)
  rescue RuntimeError => e
    puts e.message
    retry
  end
end
