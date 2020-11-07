# init commit
class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

  protected

  def max_train_speed
    100
  end
end
