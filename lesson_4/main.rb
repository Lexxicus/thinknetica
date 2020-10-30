require_relative 'command_for_main'
require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passanger_wagon'
require_relative 'passenger_train'
@stations = {}
@trains = {}
@routes = {}
puts %(
  123. Выход
  1. Создать станцию
  2. Создать поезд
  3. Управление маршрутами
  4. Назначить маршрут поезду
  5. Добавить вагон к поезду
  6. Отцепить вагон от поезда
  7. Перемещать поезд по маршруту
  8. Просмотреть список станций и список поездов на станции
)

loop do
  puts 'Введите номер команды:'
  choice = gets.to_i
  case choice
  when 123
    exit
  when 1
    create_station
  when 2
    create_train
  when 3
    route_management
  when 4
    assign_route
  when 5
    add_wagon_to_train
  when 6
    remove_wagon_to_train
  when 7
    move_train
  when 8
    list_of_stations_trains
  end
end
