shop_cart = {}
cart_price = {}
sum = 0
loop do
  
  print 'Введите название товара (Стоп для выхода): '
  item = gets.chomp.capitalize
  break if item == 'Стоп'
  print 'Укажите цену: '
  price  = gets.to_f
  print 'Укажите количество: '
  qnt = gets.to_f 
  shop_cart[item] =  {price: price, qnt: qnt}

end

shop_cart.each do |key, value|
  a_piece = value[:price] * value[:qnt]
  cart_price[key] = a_piece
  sum += a_piece
end

shop_cart.each do |key, value|
  puts "#{key} цена: #{value[:price]}, количество: #{value[:qnt]} "
end
cart_price.each do |key, value|
  puts "#{key} цена: #{value} "
end
puts "Цена всей корзины #{sum}"
