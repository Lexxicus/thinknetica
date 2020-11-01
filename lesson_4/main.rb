require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'interface'
require_relative 'station'
require_relative 'train'
require_relative 'passanger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passanger_wagon'

ui = Interface.new
ui.start
