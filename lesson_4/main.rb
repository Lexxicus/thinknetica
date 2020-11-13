require_relative 'modules/instance_counter'
require_relative 'modules/menu_station'
require_relative 'modules/menu_route'
require_relative 'modules/menu_train'
require_relative 'modules/ask'
require_relative 'modules/validation'
require_relative 'modules/accessors'
require_relative 'modules/manufacturer'
require_relative 'models/interface'
require_relative 'models/station'
require_relative 'models/train/train'
require_relative 'models/train/passanger_train'
require_relative 'models/train/cargo_train'
require_relative 'models/route'
require_relative 'models/wagon/wagon'
require_relative 'models/wagon/cargo_wagon'
require_relative 'models/wagon/passanger_wagon'

ui = Interface.new
ui.seed
ui.start
