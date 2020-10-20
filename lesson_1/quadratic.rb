print "Введите коффициент a: "
a = gets.to_i
print "Введите коффициент b: "
b = gets.to_i
print "Введите коффициент c: "
c = gets.to_i

print "Высчитываем дискриминант."

15.times do
    print "."
    sleep 0.2
end
 d = b**2-4*a*c

 if d > 0
    x1 = (-b + Math.sqrt(d))/2*a
    x2 = (-b - Math.sqrt(d))/2*a
    puts
    puts "Дескриминант равен #{d}, квадратное уровнение имеет два корня х1 = #{x1}, x2 = #{x2}"
 elsif d == 0
    x = -b/2*a 
    puts
    puts "Дескриминант равен #{d}, квадратное уровнение имеет один корень х = #{x}"
 else
    puts
    puts "Дескриминант равен #{d}, корней нет"
 end