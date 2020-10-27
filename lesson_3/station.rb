# Station class
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def trains_types
    passanger = []
    cargo = []
    @trains.each do |train|
      if train.type == 'pas'
        passanger << train
      else
        cargo << train
      end
    end
    trains_types = { passanger: passanger, cargo: cargo }
  end

  def del_train(train)
    @trains.delete(train)
  end

  def move_train(train)
    del_train(train)
  end
end
