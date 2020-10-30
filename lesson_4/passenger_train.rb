# init commit
class PassangerTrain < Train
  def initialize(number)
    @number = number
    @type = :passenger
    @wagons = []
  end

  def add_wagon(wagon)
    if wagon.type == :passenger
      super
    else
      puts 'Разрешена сцепка только с пассажирскими вагонами'
    end
  end

  protected

  def max_train_speed
    91
  end
end
