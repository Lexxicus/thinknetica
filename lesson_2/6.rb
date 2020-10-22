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

shop_cart.each do |item, price_qnt|
  a_piece = price_qnt[:price] * price_qnt[:qnt]
  cart_price[item] = a_piece
  sum += a_piece
  puts "#{item} цена: #{price_qnt[:price]}, количество: #{price_qnt[:qnt]} "
end

cart_price.each do |name, price|
  puts "#{name} цена: #{price} "
end

puts "Цена всей корзины #{sum}"
