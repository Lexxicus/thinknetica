# init wagon class commit
class Wagon
  include Manufacturer
  attr_reader :type, :wagon_number
  def initialize(type)
    @type = type
    @wagon_number = rand(100..999)
  end
end
