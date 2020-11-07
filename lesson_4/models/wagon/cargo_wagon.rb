# init commit
class CargoWagon < Wagon
  attr_reader :filled_in, :volume
  def initialize(volume)
    super(:cargo)
    @volume = volume
    @filled_in = 0
  end

  def load_wagon(volume)
    raise 'Проверьте сколько осталось места' if volume + @filled_in > @volume
    @filled_in += volume
  end

  def free_space
    @volume - @filled_in
  end
end
