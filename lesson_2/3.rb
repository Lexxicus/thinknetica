@arr_1 = [1,1]

@arr_2 = [0,1]

def arr_fib(arr)
  loop do
    a = arr[-1] + arr[-2]
    if a <= 100 
      arr.push(a)
    else
      return arr
      exit
    end 
  end
end

print arr_fib(@arr_1)

puts

print arr_fib(@arr_2)