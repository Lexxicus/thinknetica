# class initial commit
class Route
  attr_reader :starting_station, :end_station, :stations

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stations = [@starting_station, @end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    @stations.delete(station)
  end
end
