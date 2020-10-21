print 'Введите дату в формате dd/mm/yy: '

input = gets.chomp.split('/')

day = input[0].to_i

month = input[1].to_i

year = input[2].to_f

not_leap = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year%4 == 0 && year%100 != 0 || year%4 == 0 && year%100 && year%400
  not_leap[1] = 29
  d_count = not_leap.first(month - 1).sum + day
  print "Порядковый номер указанного дня #{d_count}"
else
  d_count = not_leap.first(month - 1).sum + day
  print "Порядковый номер указанного дня #{d_count}"
end
  

