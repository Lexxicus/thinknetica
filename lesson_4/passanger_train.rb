# init commit
class PassangerTrain < Train
  def initialize(number)
    super(number, :passanger)
  end

  protected

  def max_train_speed
    91
  end
end
