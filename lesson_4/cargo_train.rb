# init commit
class CargoTrain < Train
  def initialize(number)
    @number = number
    @type = :passenger
    @wagons = []
  end

  def add_wagon(wagon)
    if wagon.type == :cargo
      super
    else
      puts 'Разрешена сцепка только с грузовыми вагонами'
    end
  end

  protected

  def max_train_speed
    100
  end
end
