# Station class
class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def all_trains
    @trains.each { |train| puts "Поезд номер: #{train.number}" }
  end

  def trains_types
    pas, cargo = 0
    @trains.each do |train|
      if train.type == 'pas'
        pas += 1
      else
        cargo += 1
      end
    end
    puts "Всего пассажирских поездов: #{pas}"
    puts "Всего грузовых поездов: #{cargo}"
  end

  def del_train(train)
    @trains.delete(train)
  end

  def move_train(train)
    train.move_forward if @tarins.include?(tarin)
  end
end
