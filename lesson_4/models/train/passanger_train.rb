# init commit
class PassangerTrain < Train
  validate :number, :format, REGEXP_TRAIN_NUMBER
  def initialize(number)
    super(number, :passanger)
  end

  protected

  def max_train_speed
    91
  end
end
