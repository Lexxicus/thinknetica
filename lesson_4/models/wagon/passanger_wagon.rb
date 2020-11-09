# init commit
class PassangerWagon < Wagon
  attr_reader :filled_in
  def initialize(number_of_seats)
    super(:passanger)
    @number_of_seats = number_of_seats
    @filled_in = 0
  end

  def take_the_place
    raise 'Нет свободных мест' if 1 + @filled_in > @number_of_seats
    @filled_in += 1
  end

  def occupied_places
    @filled_in
  end

  def free_places
    @number_of_seats - @filled_in
  end
end
