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
    if @tarins.include?(tarin) && !train.route.nil? && self != train.route.end_station
      next_station = train.route.next_station(self)
      self.del_train(train)
      train.current_station = next_station
      next_station.add_train(train)
    else
      puts 'Поезд не отправлен'
    end
  end
end