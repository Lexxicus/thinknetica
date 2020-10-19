print 'Введите ваше имя: '
name = gets.chomp.capitalize
print 'Укажите ваш рост: '
height = gets.to_f
# расчёт идеального веса
p_weight = (height - 110)*1.15

print p_weight > 0 ? "#{name} your perfect weight is : #{p_weight}" : "#{name} your weight is perfect"