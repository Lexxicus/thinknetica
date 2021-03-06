
# расчёт площади равностороннего треугольника
def isos_t(a, b)   
  h = Math.sqrt(a**2 - (b/2)**2)  
  area = h * b * 0.5
end

def area_by_type
  # объявляем масси для определения наибольшей и наименьшей стороны прямоугольника 
  arr = []
  print 'Введите длину стороны a: '
  a = gets.to_f
  arr.push(a)
  print 'Введите длину стороны b: '
  b = gets.to_f
  arr.push(b)
  print 'Введите длину стороны c: '
  c = gets.to_f
  arr.push(c)
  case 
  when a == b || a == c || c == b
    area = isos_t(arr.sort[0], arr.sort[2])
    puts "Это равнобедренный треугольник, его площадь равна: #{area}" 
  when a == b && b == c
    area = a**2*Math.sqrt(3)/4
    puts  "Это равносторонний треугольник, его площадь равна: #{area}"
  when arr.sort[2]**2 == arr.sort[0]**2 + arr.sort[1]**2
    area = arr.sort[0] * arr.sort[1]*0.5
    print "Это прямоугольный треугольник, его площадь равна: #{area}"  
  end
end

def area_by_height
  print 'Введите высоту треугольника: '
  h = gets.to_f
  print 'Введите основание треугольника: '
  a = gets.to_f
  area = 0.5 * a * h
  puts "Площадь треугольника равна: #{area}" 
end

print 'Введите 1 для расчёта площади треугольника по высоте и основанию, 2 для расчёта площади по длинам сторон: '

chose = gets.chomp

if chose == '1'
  area_by_height
elsif chose == '2'
  area_by_type
else
  print 'Ошибка ввода'
end 