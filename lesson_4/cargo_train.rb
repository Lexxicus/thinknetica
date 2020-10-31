# init commit
class CargoTrain < Train
  def initialize(number)
    @number = number
    @type = :passenger
    @wagons = []
  end

  protected

  def max_train_speed
    100
  end
end
