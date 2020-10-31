# init commit
class PassangerTrain < Train
  def initialize(number)
    @number = number
    @type = :passenger
    @wagons = []
  end

  protected

  def max_train_speed
    91
  end
end
