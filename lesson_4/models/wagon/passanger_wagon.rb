# init commit
class PassangerWagon < Wagon
  def initialize(number_of_seats)
    super(:passanger)
    @number_of_seats = Array.new(number_of_seats, 0)
  end
# логика закладывалась с учетом, что дальше может понадобиться
# занимать конкретное место, а при таком раскладе метод легко
# модернизируется, если нужно приведу к виду грузового вагона 
  def take_the_place
    size = @number_of_seats.size
    raise 'Вагон полон' if @number_of_seats.count(1) == size
    0.upto(size) do |i|
      if i != size && @number_of_seats[i].zero?
        @number_of_seats[i] = 1
        break
      end
    end
  end

  def occupied_places
    @number_of_seats.count(1)
  end

  def free_places
    @number_of_seats.count(0)
  end
end
