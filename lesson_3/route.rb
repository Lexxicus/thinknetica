# class initial commit
class Route
  attr_reader :starting_station, :end_station, :route

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @route = [@starting_station, @end_station]
  end

  def add_station(station)
    @route.insert(-2, station)
  end

  def del_station(station)
    @route.delete(station)
  end

  def next_station(station)
    index = @route.find_index(station) + 1
    @route[index] if index <= @route.size
  end

  def prev_station(station)
    index = @route.find_index(station)
    if index.zero?
      index
    else
      index -= 1
    end
    @route[index] if index >= 0
  end
end
